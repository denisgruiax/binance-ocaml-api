open Variants;;

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string
  val symbol : Symbol.t
  val is_isolated : bool
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

module Make : functor (P : Parameters) -> New_order'