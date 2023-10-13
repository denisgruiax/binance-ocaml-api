open Utilities;;
open Lwt.Infix;;
open Variants;;

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string
  val symbol : Symbol.t
  val quote_order_quantity : float
  val stop_price : float
  val iceberg_quantity : float
  val side_effect_type : Side_effect_type.t
  val auto_repay_at_cancel : bool
  val recv_window : int
end

module type New_order' = sig
  type fill = {
    price : float;
    qty : float;
    commission : float;
    commissionAsset : string
  }

  type ack_response = {
    symbol : Symbol.t;
    order_id : int;
    client_order_id : string;
    is_isolated : bool;
    transaction_time: int
  }

  type result_response = {
    symbol : Symbol.t;
    order_id : int;
    client_order_id : string;
    transaction_time : int;
    price : float;
    orig_quantity : float;
    executed_quantity : float;
    cummulative_quote_quantity : float;
    status : Order_status.t;
    time_in_force : Time_in_force.t;
    order_type : Order_types.t;
    is_isolated : bool;
    side : Order_side.t;
    self_trade_prevention_mode : string
  }

  type full_response = {
    symbol : Symbol.t;
    order_id : int;
    client_order_id : string;
    transaction_time : int;
    price : float;
    orig_quantity : float;
    executed_quantity : float;
    cummulative_quote_quantity : float;
    status : Order_status.t;
    time_in_force : Time_in_force.t;
    order_type : Order_types.t;
    side : Order_side.t;
    margin_buy_borrow_amount : int;
    margin_buy_borrow_asset : string;
    is_isolated : bool;
    self_trade_prevention_mode : string;
    fills : fill list
  }

  type response = Ack of ack_response | Result of result_response | Full of full_response | Error_code

  val market : Order_side.t -> float -> bool -> Order_response.t -> response Lwt.t
  val limit : Order_side.t -> float -> float -> bool -> Order_response.t -> response Lwt.t
end

module Make(P : Parameters) : New_order' = struct
  type fill = {
    price : float;
    qty : float;
    commission : float;
    commissionAsset : string
  };;

  type ack_response = {
    symbol : Symbol.t;
    order_id : int;
    client_order_id : string;
    is_isolated : bool;
    transaction_time: int
  }

  type result_response = {
    symbol : Symbol.t;
    order_id : int;
    client_order_id : string;
    transaction_time : int;
    price : float;
    orig_quantity : float;
    executed_quantity : float;
    cummulative_quote_quantity : float;
    status : Order_status.t;
    time_in_force : Time_in_force.t;
    order_type : Order_types.t;
    is_isolated : bool;
    side : Order_side.t;
    self_trade_prevention_mode : string
  }
  type full_response = {
    symbol : Symbol.t;
    order_id : int;
    client_order_id : string;
    transaction_time : int;
    price : float;
    orig_quantity : float;
    executed_quantity : float;
    cummulative_quote_quantity : float;
    status : Order_status.t;
    time_in_force : Time_in_force.t;
    order_type : Order_types.t;
    side : Order_side.t;
    margin_buy_borrow_amount : int;
    margin_buy_borrow_asset : string;
    is_isolated : bool;
    self_trade_prevention_mode : string;
    fills : fill list
  };;

  type response = Ack of ack_response | Result of result_response | Full of full_response | Error_code;;

  let get_fill = function
    |fields -> {
        price = Ezjsonm.(find fields ["price"] |> get_string |> float_of_string);
        qty = Ezjsonm.(find fields ["qty"] |> get_string |> float_of_string);
        commission = Ezjsonm.(find fields ["commission"] |> get_string |> float_of_string);
        commissionAsset = Ezjsonm.(find fields ["commissionAsset"] |> get_string)
      }
  ;;

  let get_fills fills = let rec get_fills' fills acc = match fills with
      |`A(head :: tail) -> get_fills' (`A tail) (get_fill head :: acc)
      | _ -> List.rev acc
    in get_fills' fills [];;

  let get_data = function
    |`O[
        ("symbol", `String symbol);
        ("orderId", `Float order_id);
        ("clientOrderId", `String client_order_id);
        ("isIsolated", `Bool is_isolated);
        ("transactTime", `Float transaction_time)
      ] -> Ack {
        symbol = Symbol.unwrap symbol;
        order_id = int_of_float order_id;
        client_order_id = client_order_id;
        is_isolated = is_isolated;
        transaction_time = int_of_float transaction_time
      }

    |`O[
        ("symbol", `String symbol);
        ("orderId", `Float order_id);
        ("clientOrderId", `String client_order_id);
        ("transactTime", `Float transaction_time);
        ("price", `String price);
        ("origQty", `String orig_quantity);
        ("executedQty", `String executed_quantity);
        ("cummulativeQuoteQty", `String cummulative_quote_quantity);
        ("status", `String status);
        ("timeInForce", `String time_in_force);
        ("type", `String order_type);
        ("isIsolated", `Bool is_isolated);
        ("side", `String side);
        ("selfTradePrevetionMode", `String self_trade_prevention_mode)
      ] -> Result {
        symbol = Symbol.unwrap symbol;
        order_id = int_of_float order_id;
        client_order_id = client_order_id;
        transaction_time = int_of_float transaction_time;
        price = float_of_string price;
        orig_quantity = float_of_string orig_quantity;
        executed_quantity = float_of_string executed_quantity;
        cummulative_quote_quantity = float_of_string cummulative_quote_quantity;
        status = Order_status.unwrap status;
        time_in_force = Time_in_force.unwrap time_in_force;
        order_type = Order_types.unwrap order_type;
        is_isolated = is_isolated;
        side = Order_side.unwrap side;
        self_trade_prevention_mode = self_trade_prevention_mode
      }

    |`O[
        ("symbol", `String symbol);
        ("orderId", `Float order_id);
        ("clientOrderId", `String client_order_id);
        ("transactTime", `Float transaction_time);
        ("price", `String price);
        ("origQty", `String orig_quantity);
        ("executedQty", `String executed_quantity);
        ("cummulativeQuoteQty", `String cummulative_quote_quantity);
        ("status", `String status);
        ("timeInForce", `String time_in_force);
        ("type", `String order_type);
        ("side", `String side);
        ("marginBuyBorrowAmount", `Float margin_buy_borrow_amount);
        ("marginBuyBorrowAsset", `String margin_buy_borrow_asset);
        ("isIsolated", `Bool is_isolated);
        ("selfTradePrevetionMode", `String self_trade_prevention_mode);
        ("fills", fills)
      ] -> Full {
        symbol = Symbol.unwrap symbol;
        order_id = int_of_float order_id;
        client_order_id = client_order_id;
        transaction_time = int_of_float transaction_time;
        price = float_of_string price;
        orig_quantity = float_of_string orig_quantity;
        executed_quantity = float_of_string executed_quantity;
        cummulative_quote_quantity = float_of_string cummulative_quote_quantity;
        status = Order_status.unwrap status;
        time_in_force = Time_in_force.unwrap time_in_force;
        order_type = Order_types.unwrap order_type;
        is_isolated = is_isolated;
        side = Order_side.unwrap side;
        margin_buy_borrow_amount = int_of_float margin_buy_borrow_amount;
        margin_buy_borrow_asset = margin_buy_borrow_asset;
        self_trade_prevention_mode = self_trade_prevention_mode;
        fills = get_fills fills
      }
    |_ -> Error_code
  ;;

  let parse_response json = 
    json >>= fun json' -> Lwt.return (get_data json');;

  let parameters = let open P in [
      ("symbol", Symbol.wrap symbol);
      ("quoteOrderQty", string_of_float quote_order_quantity);
      ("stopPrice", string_of_float stop_price);
      ("icebergQty", string_of_float iceberg_quantity);
      ("sideEffectType", Side_effect_type.wrap side_effect_type);
      ("autoRepayAtCancel", Binance_bool.wrap auto_repay_at_cancel);
      ("recvWindow", string_of_int recv_window)
    ]

  let headers = Requests.create_header P.api_key;;

  let market side quantity is_isolated response_type = 
    let parameters = parameters @ [
        ("side", Order_side.wrap side);
        ("quantity", string_of_float quantity);
        ("isIsolated", Binance_bool.wrap is_isolated);
        ("newOrderRespType", Order_response.wrap response_type);
        ("type", Order_types.(wrap MARKET));
        ("timeInForce", Time_in_force.(wrap GTC))
      ] 
    in let url = Url.build_signed P.url "/sapi/v1/margin/order" parameters P.secret_key
    in parse_response (Requests.post (Uri.of_string url) headers);;

  let limit side quantity price is_isolated response_type = 
    let parameters = parameters @ [
        ("side", Order_side.wrap side);
        ("quantity", string_of_float quantity);
        ("price", string_of_float price);
        ("isIsolated", Binance_bool.wrap is_isolated);
        ("newOrderRespType", Order_response.wrap response_type);
        ("type", Order_types.(wrap LIMIT));
        ("timeInForce", Time_in_force.(wrap GTC))
      ] 
    in let url = Url.build_signed P.url "/sapi/v1/margin/order" parameters P.secret_key
    in parse_response (Requests.post (Uri.of_string url) headers);;
end