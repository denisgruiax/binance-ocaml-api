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

module type Close_order' = sig
  type t = {
    symbol: Symbol.t;
    is_isolated : bool;
    order_id : int;
    orig_client_order_id : string;
    client_order_id : string;
    price : float;
    orig_quantity : float;
    executed_quantity : float;
    cummulative_quote_quantity : float;
    status : Order_status.t;
    time_in_force : Time_in_force.t;
    order_type : Order_types.t;
    side : Order_side.t
  };;
  
  val close_order : bool -> int -> t option Lwt.t
end

module Make(P : Parameters) : Close_order' = struct
  type t = {
    symbol: Symbol.t;
    is_isolated : bool;
    order_id : int;
    orig_client_order_id : string;
    client_order_id : string;
    price : float;
    orig_quantity : float;
    executed_quantity : float;
    cummulative_quote_quantity : float;
    status : Order_status.t;
    time_in_force : Time_in_force.t;
    order_type : Order_types.t;
    side : Order_side.t
  };;

  let parameters = let open P in [
      ("symbol", Symbol.wrap symbol);
      ("recvWindow", string_of_int recv_window)
    ];;

  let endpoint = Url.build_signed P.url "/sapi/v1/margin/order" parameters P.secret_key;;

  let headers = Requests.create_header P.api_key;;

  let get_data (json : Ezjsonm.t) = match json with
    |`O[
        ("symbol", `String s1);
        ("isIsolated", `Bool v1);
        ("orderId", `String s2);
        ("origClientOrderId", `String s3);
        ("clientOrderId", `String s4);
        ("price", `String s5);
        ("origQty", `String s6);
        ("executedQty", `String s7);
        ("cummulativeQuoteQty", `String s8);
        ("status", `String s9);
        ("timeInForce", `String s10);
        ("type", `String s11);
        ("side", `String s12)
      ] -> Some {
        symbol = Symbol.unwrap s1;
        is_isolated = v1;
        order_id = int_of_string s2;
        orig_client_order_id = s3;
        client_order_id = s4;
        price = float_of_string s5;
        orig_quantity = float_of_string s6;
        executed_quantity = float_of_string s7;
        cummulative_quote_quantity = float_of_string s8;
        status = Order_status.unwrap s9;
        time_in_force = Time_in_force.unwrap s10;
        order_type = Order_types.unwrap s11;
        side = Order_side.unwrap s12;  
      }
    |_ -> None;;

  let parse_response json = 
    json >>= fun json' -> Lwt.return (get_data json');;

  let close_order is_isolated order_id = 
    let parameters = parameters @ [("isIsolated", Binance_bool.wrap is_isolated)] @ [("orderId", string_of_int order_id)] in
    let url = Url.build_signed P.url "/sapi/v1/margin/order" parameters P.secret_key in
    parse_response (Requests.delete (Uri.of_string url) headers);;
end