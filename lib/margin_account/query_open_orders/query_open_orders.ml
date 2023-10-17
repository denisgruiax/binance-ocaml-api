open Utilities;;
open Variants;;
open Lwt.Infix;;

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string
  val symbol : Symbol.t
  val recv_window : int
end

module type Query_open_orders' = sig
  type t = {
    client_order_id : string;
    cummulative_quote_quantity : float;
    executed_quantity : float;
    iceberg_quantity : float;
    is_working : bool;
    order_id : int;
    original_quantity : float;
    price : float;
    side : Order_side.t;
    status : Order_status.t;
    stop_price : float;
    symbol : Symbol.t;
    is_isolated : bool;
    time : int;
    time_in_force : Time_in_force.t;
    order_type : Order_types.t;
    self_trade_prevention_mode : string;
    update_time : int
  }

  val get : bool -> t option list Lwt.t
end

module Make(P : Parameters) : Query_open_orders' = struct
  type t = {
    client_order_id : string;
    cummulative_quote_quantity : float;
    executed_quantity : float;
    iceberg_quantity : float;
    is_working : bool;
    order_id : int;
    original_quantity : float;
    price : float;
    side : Order_side.t;
    status : Order_status.t;
    stop_price : float;
    symbol : Symbol.t;
    is_isolated : bool;
    time : int;
    time_in_force : Time_in_force.t;
    order_type : Order_types.t;
    self_trade_prevention_mode : string;
    update_time : int
  };;

  let parameters = let open P in [
      ("symbol", Symbol.wrap symbol);
      ("recvWindow", string_of_int recv_window)
    ];;

  let headers = Requests.create_header P.api_key;;

  let get_data = function
    |`O[
        ("clientOrderId", `String client_order_id);
        ("cummulativeQuoteQty", `String cummulative_quote_quantity);
        ("executedQuantity", `String executed_quantity);
        ("icebergQuantity", `String iceberg_quantity);
        ("isWoring", `Bool is_working);
        ("orderId", `Float order_id);
        ("origQty", `String original_quantity);
        ("price", `String price);
        ("side", `String side);
        ("status", `String status);
        ("stopPrice", `String stop_price);
        ("symbol", `String symbol);
        ("isIsolated", `Bool is_isolated);
        ("time", `Float time);
        ("timeInForce", `String time_in_force);
        ("order_type", `String order_type);
        ("selfTradePreventionMode", `String self_trade_prevention_mode);
        ("updateTime", `Float update_time)
      ] -> Some {
        client_order_id = client_order_id;
        cummulative_quote_quantity = float_of_string cummulative_quote_quantity;
        executed_quantity = float_of_string executed_quantity;
        iceberg_quantity = float_of_string iceberg_quantity;
        is_working = is_working;
        order_id = int_of_float order_id;
        original_quantity = float_of_string original_quantity;
        price = float_of_string price;
        side = Order_side.unwrap side;
        status = Order_status.unwrap status;
        stop_price = float_of_string stop_price;
        symbol = Symbol.unwrap symbol;
        is_isolated = is_isolated;
        time = int_of_float time;
        time_in_force = Time_in_force.unwrap time_in_force;
        order_type = Order_types.unwrap order_type;
        self_trade_prevention_mode = self_trade_prevention_mode;
        update_time = int_of_float update_time
      }
    |_ -> None;;

  let parse_response json = 
    json >>= fun json' -> Lwt.return(Data.get_list get_data json');;

  let get is_isolated = 
    let parameters = parameters @ [("isIsolated", Binance_bool.wrap is_isolated)] in
    let url = Url.build_signed P.url "" parameters P.secret_key in
    parse_response (Requests.get_signed (Uri.of_string url) headers);;
end