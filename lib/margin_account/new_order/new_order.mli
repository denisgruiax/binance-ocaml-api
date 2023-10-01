module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string
  val symbol : string
  val isIsolated : string
  val side : string
  val type_of_order : string
  val quantity : float
  val quoteOrderQty : float
  val price : float
  val stopPrice : float
  val newClientOrderId : string
  val icebergQty : float
  val newOrderRespType : string
  val sideEffectType : string
  val timeInForce : string
  val selfTradePreventionMode : string
  val autoRepayAtCancel : string
  val recvWindow : int
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