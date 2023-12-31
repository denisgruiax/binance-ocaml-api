open Utilities;;
open Lwt.Infix;;
open Variants;;

type fill = {
  price : Decimal.t;
  qty : Decimal.t;
  commission : Decimal.t;
  commission_asset : string;
  trade_id : Decimal.t
};;

type ack_response = {
  symbol : Symbol.t;
  order_id : Decimal.t;
  order_list_id : Decimal.t;
  client_order_id : string;
  transact_time: Decimal.t
};;

type result_response = {
  ack_response : (ack_response, Error_code.t) result;
  price : Decimal.t;
  orig_qty : Decimal.t;
  executed_qty : Decimal.t;
  cummulative_quote_qty : Decimal.t;
  status : Order_status.t;
  time_in_force : Time_in_force.t;
  order_type : Order_types.t;
  side : Order_side.t;
  working_time : Decimal.t;
  self_trade_prevention_mode : string
};;

type full_response = {
  result_response : (result_response, Error_code.t) result;
  fills : (fill, Error_code.t) result list
};;

type new_order_response = Ack of ((ack_response, Error_code.t) result) | Result of ((result_response, Error_code.t) result) | Full of ((full_response, Error_code.t) result);;

let get_fill = function
  |`O[
      ("price", `String price);
      ("qty", `String qty);
      ("commission", `String commission);
      ("commissionAsset", `String commission_asset);
      ("tradeId", `Float trade_id)
    ] -> Ok {
      price = Decimal.of_string price;
      qty = Decimal.of_string qty;
      commission = Decimal.of_string commission;
      commission_asset = commission_asset;
      trade_id = Decimal.of_int (int_of_float trade_id)
    }
  |error -> Error (Error_code.get error);;

let print_fill = function
  |Ok fill -> begin match fill with
        {
          price = price;
          qty = qty;
          commission = commission;
          commission_asset = commission_asset;
          trade_id = trade_id
        } -> let open Decimal in 
        Lwt_io.printf "price = %s\nqty = %s\ncommission = %s\ncommission_asset%s\ntrade_id = %s\n\n" (to_string price) (to_string qty) (to_string commission) (commission_asset) (to_string trade_id)
    end
  |Error error -> Error_code.printl error;;

let print_fills fills = Lwt_list.iter_s (print_fill) fills;;

let get_ack = function
  |`O[
      ("symbol", `String symbol);
      ("orderId", `Float order_id);
      ("orderListId", `Float order_list_id);
      ("clientOrderId", `String client_order_id);
      ("transactTime", `Float transact_time);
    ] -> Ok { (*Here add Some Ack {ack_response} or Ack {ack_response}*)
      symbol = Symbol.unwrap symbol;
      order_id = Decimal.of_int (int_of_float order_id);
      order_list_id = Decimal.of_int (int_of_float order_list_id);
      client_order_id = client_order_id;
      transact_time = Decimal.of_int (int_of_float transact_time)
    }
  |error -> Error (Error_code.get error);;

let print_ack = function
  |Ok ack_response -> begin match ack_response with
      |{
        symbol = symbol;
        order_id = order_id;
        order_list_id = order_list_id;
        client_order_id = client_order_id;
        transact_time = transact_time;_
      } -> let open Lwt.Syntax in let open Lwt_io in
        let* () = printf "symbol = %s\n" (Symbol.wrap symbol) in
        let* () = printf "order_id = %s\n" (Decimal.to_string order_id) in
        let* () = printf "order_list_id = %s\n" (Decimal.to_string order_list_id) in
        let* () = printf "client_order_id = %s\n" client_order_id in
        let* () = printf "transact_time = %s\n\n" (Decimal.to_string transact_time) in
        Lwt.return ()
    end
  |Error error -> Error_code.printl error;;

let get_result = function
  |`O[
      ("symbol", `String symbol);
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
      ("workingTime", `Float working_time);
      ("selfTradePreventionMode", `String self_trade_prevention_mode);
    ] -> Ok {
      ack_response = get_ack (`O[
          ("symbol", `String symbol);
          ("orderId", `Float order_id);
          ("orderListId", `Float order_list_id);
          ("clientOrderId", `String client_order_id);
          ("transactTime", `Float transact_time);
        ]);

      price = Decimal.of_string price;
      orig_qty = Decimal.of_string orig_qty;
      executed_qty = Decimal.of_string executed_qty;
      cummulative_quote_qty = Decimal.of_string cummulative_quote_qty;
      status = Order_status.unwrap status;
      time_in_force = Time_in_force.unwrap time_in_force;
      order_type = Order_types.unwrap order_type;
      side = Order_side.unwrap side;
      working_time = Decimal.of_int (int_of_float working_time);
      self_trade_prevention_mode = self_trade_prevention_mode
    }
  |error -> Error (Error_code.get error);;

let print_result = function
  |Ok result_response -> begin match result_response with
      |{
        ack_response = ack_response;
        price = price;
        orig_qty = orig_qty;
        executed_qty = executed_qty;
        cummulative_quote_qty = cummulative_quote_qty;
        status = status;
        time_in_force = time_in_force;
        order_type = order_type;
        side = side;
        working_time = working_time;
        self_trade_prevention_mode = self_trade_prevention_mode
      } -> let open Lwt.Syntax in let open Lwt_io in
        let* () = print_ack ack_response in
        let* () = printf "price = %s\n" (Decimal.to_string price) in
        let* () = printf "orig_qty = %s\n" (Decimal.to_string orig_qty) in
        let* () = printf "executed_qty = %s\n" (Decimal.to_string executed_qty) in
        let* () = printf "cummulative_quote_qty = %s\n" (Decimal.to_string cummulative_quote_qty) in
        let* () = printf "status = %s\n" (Order_status.wrap status) in
        let* () = printf "time_in_force = %s\n" (Time_in_force.wrap time_in_force) in
        let* () = printf "order_type = %s\n" (Order_types.wrap order_type) in
        let* () = printf "side = %s\n" (Order_side.wrap side) in
        let* () = printf "working_time = %s\n" (Decimal.to_string working_time) in
        let* () = printf "self_trade_prevention_mode = %s\n\n" self_trade_prevention_mode in
        Lwt.return ()
    end
  |Error error -> Error_code.printl error;;

let get_full = function
  |`O[
      ("symbol", `String symbol);
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
      ("workingTime", `Float working_time);
      ("selfTradePreventionMode", `String self_trade_prevention_mode);
      ("fills", fills)
    ] -> Ok {
      result_response = get_result (
          `O[
            ("symbol", `String symbol);
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
            ("workingTime", `Float working_time);
            ("selfTradePreventionMode", `String self_trade_prevention_mode);
          ]);

      fills = Data.get_list get_fill fills
    }
  |error -> Error (Error_code.get error);;

let print_full = function
  |Ok full_response -> begin match full_response with
      |{
        result_response = result_response;
        fills = fills
      } -> let open Lwt.Syntax in
        let* () = print_result result_response in
        let* () = print_fills fills in
        let* () = Lwt_io.printl "" in
        Lwt.return ()
    end
  |Error error -> Error_code.printl error;;

let get = function
  |`O[
      ("symbol", `String symbol);
      ("orderId", `Float order_id);
      ("orderListId", `Float order_list_id);
      ("clientOrderId", `String client_order_id);
      ("transactTime", `Float transact_time);
    ] -> Ok (Ack (Ok { (*Here add Some Ack {ack_response} or Ack {ack_response}*)
      symbol = Symbol.unwrap symbol;
      order_id = Decimal.of_int (int_of_float order_id);
      order_list_id = Decimal.of_int (int_of_float order_list_id);
      client_order_id = client_order_id;
      transact_time = Decimal.of_int (int_of_float transact_time)
    }))

  |`O[
      ("symbol", `String symbol);
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
      ("workingTime", `Float working_time);
      ("selfTradePreventionMode", `String self_trade_prevention_mode);
    ] -> Ok (Result (Ok {
      ack_response = get_ack (`O[
          ("symbol", `String symbol);
          ("orderId", `Float order_id);
          ("orderListId", `Float order_list_id);
          ("clientOrderId", `String client_order_id);
          ("transactTime", `Float transact_time);
        ]);

      price = Decimal.of_string price;
      orig_qty = Decimal.of_string orig_qty;
      executed_qty = Decimal.of_string executed_qty;
      cummulative_quote_qty = Decimal.of_string cummulative_quote_qty;
      status = Order_status.unwrap status;
      time_in_force = Time_in_force.unwrap time_in_force;
      order_type = Order_types.unwrap order_type;
      side = Order_side.unwrap side;
      working_time = Decimal.of_int (int_of_float working_time);
      self_trade_prevention_mode = self_trade_prevention_mode
    }))

  |`O[
      ("symbol", `String symbol);
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
      ("workingTime", `Float working_time);
      ("selfTradePreventionMode", `String self_trade_prevention_mode);
      ("fills", fills)
    ] -> Ok (Full (Ok {
      result_response = get_result (
          `O[
            ("symbol", `String symbol);
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
            ("workingTime", `Float working_time);
            ("selfTradePreventionMode", `String self_trade_prevention_mode);
          ]);

      fills = Data.get_list get_fill fills
    }))
  |error -> Error (Error_code.get error);;

let printl = function
  |Ok (Ack ack_response) -> print_ack ack_response
  |Ok (Result result_response) -> print_result result_response
  |Ok (Full full_response) -> print_full full_response
  |Error error_code -> Error_code.printl error_code;;

let parse_response json = 
  json >>= fun json' -> Lwt.return (get json');; 

let send ~base_url:base_url ~endpoint:endpoint ~api_key:api_key ~secret_key:secret_key ~parameters:parameters = 
  let header = Requests.create_header api_key in
  let parameters = parameters in
  let url = Url.build_signed base_url endpoint parameters secret_key in
  parse_response (Requests.post url header);;