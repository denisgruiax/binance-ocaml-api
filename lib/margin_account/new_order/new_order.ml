open Utilities;;
open Lwt.Infix;;
open Variants;;

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string
  val symbol : Symbol.t
  val is_isolated : Binance_bool.t
  val side : Order_side.t
  val type_of_order : Order_types.t
  val quantity : float
  val quote_order_quantity : float
  val price : float
  val stop_price : float
  val iceberg_quantity : float
  val new_order_resp_type : Order_response.t
  val side_effect_type : Side_effect_type.t
  val time_in_force : Time_in_force.t
  val auto_repay_at_cancel : Binance_bool.t
  val recv_window : int
end

module type New_order' = sig
  type fill = {
    price : float;
    qty : float;
    commission : float;
    commissionAsset : string
  }

  type t = {
    symbol : string;
    orderId : int;
    clientOrderId : string;
    transactTime : int;
    price : float;
    origQty : float;
    executedQty : float;
    cummulativeQuoteQty : float;
    status : string;
    timeInForce : string;
    type_of_order : string;
    side :string;
    marginBuyBorrowAmount : int;
    marginBuyBorrowAsset : string;
    isIsolated : string;
    selfTradePreventionMode : string;
    fills : fill list
  }

  val new_order : unit -> t Lwt.t
end

module Make(P : Parameters) : New_order' = struct
  type fill = {
    price : float;
    qty : float;
    commission : float;
    commissionAsset : string
  };;

  type t = {
    symbol : string;
    orderId : int;
    clientOrderId : string;
    transactTime : int;
    price : float;
    origQty : float;
    executedQty : float;
    cummulativeQuoteQty : float;
    status : string;
    timeInForce : string;
    type_of_order : string;
    side :string;
    marginBuyBorrowAmount : int;
    marginBuyBorrowAsset : string;
    isIsolated : string;
    selfTradePreventionMode : string;
    fills : fill list
  };;

  let parameters = let open P in [
      ("symbol", Symbol.wrap symbol);
      ("isIsolated", Binance_bool.wrap is_isolated);
      ("side", Order_side.wrap side);
      ("type", Order_types.wrap type_of_order);
      ("quantity", string_of_float  quantity);
      ("quoteOrderQty", string_of_float quote_order_quantity);
      ("price", string_of_float price);
      ("stopPrice", string_of_float stop_price);
      ("icebergQty", string_of_float iceberg_quantity);
      ("newOrderRespType", Order_response.wrap new_order_resp_type);
      ("sideEffectType", Side_effect_type.wrap side_effect_type);
      ("timeInForce", Time_in_force.wrap time_in_force);
      ("autoRepayAtCancel", Binance_bool.wrap auto_repay_at_cancel);
      ("recvWindow", string_of_int recv_window)
    ]

  let endpoint = Url.build_signed P.url "/sapi/v1/margin/order" parameters P.secret_key;;

  let headers = Requests.create_header P.api_key;;

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
    |fields ->{
        symbol = Ezjsonm.(find fields ["symbol"] |> get_string);
        orderId = Ezjsonm.(find fields ["orderId"] |> get_float |> int_of_float);
        clientOrderId = Ezjsonm.(find fields ["clientOrderId"] |> get_string);
        transactTime = Ezjsonm.(find fields ["transactTime"] |> get_float |> int_of_float);
        price = Ezjsonm.(find fields ["price"] |> get_string |> float_of_string);
        origQty = Ezjsonm.(find fields ["origQty"] |> get_string |> float_of_string);
        executedQty = Ezjsonm.(find fields ["executedQty"] |> get_string |> float_of_string);
        cummulativeQuoteQty = Ezjsonm.(find fields ["cummulativeQuoteQty"] |> get_string |> float_of_string);
        status = Ezjsonm.(find fields ["status"] |> get_string);
        timeInForce = Ezjsonm.(find fields ["timeInForce"] |> get_string);
        type_of_order = Ezjsonm.(find fields ["type"] |> get_string);
        side = Ezjsonm.(find fields ["side"] |> get_string);
        marginBuyBorrowAmount = Ezjsonm.(find fields ["marginBuyBorrowAmount"] |> get_float |> int_of_float);
        marginBuyBorrowAsset = Ezjsonm.(find fields ["marginBuyBorrowAsset"] |> get_string);
        isIsolated = Ezjsonm.(find fields ["isIsolated"] |> get_string);
        selfTradePreventionMode = Ezjsonm.(find fields ["selfTradePreventionMode"] |> get_string);
        fills =  get_fills (Ezjsonm.find fields ["fills"])
      }
  ;;

  let parse_response json = 
    json >>= fun json' -> Lwt.return (get_data json');;

  let new_order () = parse_response (Requests.post (Uri.of_string endpoint) headers);;
end