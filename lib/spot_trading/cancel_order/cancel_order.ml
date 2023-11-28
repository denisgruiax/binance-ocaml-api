open Utilities;;
open Variants;;

type response = {
  symbol : Symbol.t;
  orig_client_order_id : string;
  order_id : Decimal.t;
  order_list_id : Decimal.t;
  client_order_id : string;
  transact_time: Decimal.t;
  price : Decimal.t;
  orig_qty : Decimal.t;
  executed_qty : Decimal.t;
  cummulative_quote_qty : Decimal.t;
  status : Order_status.t;
  time_in_force : Time_in_force.t;
  order_type : Order_types.t; 
  side : Order_side.t;
  self_trade_prevention_mode : string
};;

let get_data = function
    `O[
      ("symbol", `String symbol);
      ("origClientOrderId", `String orig_client_order_id);
      ("orderId", `Float order_id);
      ("orderListId", `Float order_list_id);
      ("clientOrderId", `String client_order_id);
      ("transactTime", `Float transact_time);
      ("price", `String price);
      ("origQty", `String orig_qty);
      ("executedQty", `String executed_qty);
      ("cummulativeQuoteQty", `String cummulative_quote_qty);
      ("status", `String status);
      ("timeInForce", `String time_in_force);
      ("type", `String order_type);
      ("side", `String side);
      ("selfTradePreventionMode", `String self_trade_prevention_mode);
    ] -> Ok {
      symbol = Symbol.unwrap symbol;
      orig_client_order_id = orig_client_order_id;
      order_id = Decimal.of_int (int_of_float order_id);
      order_list_id = Decimal.of_int (int_of_float order_list_id);
      client_order_id = client_order_id;
      transact_time = Decimal.of_int (int_of_float transact_time);
      price = Decimal.of_string price;
      orig_qty = Decimal.of_string orig_qty;
      executed_qty = Decimal.of_string executed_qty;
      cummulative_quote_qty = Decimal.of_string cummulative_quote_qty;
      status = Order_status.unwrap status;
      time_in_force = Time_in_force.unwrap time_in_force;
      order_type = Order_types.unwrap order_type;
      side = Order_side.unwrap side;
      self_trade_prevention_mode = self_trade_prevention_mode
    }
  |error -> Error (Error_code.get error);;


let printl = function
  |Ok result_response -> begin match result_response with
      |{
        symbol = symbol;
        orig_client_order_id = orig_client_order_id;
        order_id = order_id;
        order_list_id = order_list_id;
        client_order_id = client_order_id;
        transact_time = transact_time;
        price = price;
        orig_qty = orig_qty;
        executed_qty = executed_qty;
        cummulative_quote_qty = cummulative_quote_qty;
        status = status;
        time_in_force = time_in_force;
        order_type = order_type;
        side = side;
        self_trade_prevention_mode = self_trade_prevention_mode
      } -> let open Lwt.Syntax in let open Lwt_io in
        let* () = printf "symbol = %s\n" (Symbol.wrap symbol) in
        let* () = printf "orig_client_order_id = %s\n" orig_client_order_id in
        let* () = printf "order_id = %s\n" (Decimal.to_string order_id) in
        let* () = printf "order_list_id = %s\n" (Decimal.to_string order_list_id) in
        let* () = printf "client_order_id = %s\n" client_order_id in
        let* () = printf "transact_time = %s\n\n" (Decimal.to_string transact_time) in
        let* () = printf "price = %s\n" (Decimal.to_string price) in
        let* () = printf "orig_qty = %s\n" (Decimal.to_string orig_qty) in
        let* () = printf "executed_qty = %s\n" (Decimal.to_string executed_qty) in
        let* () = printf "cummulative_quote_qty = %s\n" (Decimal.to_string cummulative_quote_qty) in
        let* () = printf "status = %s\n" (Order_status.wrap status) in
        let* () = printf "time_in_force = %s\n" (Time_in_force.wrap time_in_force) in
        let* () = printf "order_type = %s\n" (Order_types.wrap order_type) in
        let* () = printf "side = %s\n" (Order_side.wrap side) in
        let* () = printf "self_trade_prevention_mode = %s\n\n" self_trade_prevention_mode in
        Lwt.return ()
    end
  |Error error -> Error_code.printl error;;

let parse_response json = let open Lwt.Infix in  
  json >>= fun json' -> Lwt.return (get_data json');;

let send ~base_url:base_url ~endpoint:endpoint ~api_key:api_key ~secret_key:secret_key ~parameters:parameters = 
  let header = Requests.create_header api_key in
  let parameters = parameters in
  let url = Url.build_signed base_url endpoint parameters secret_key in
  parse_response (Requests.delete url header);;