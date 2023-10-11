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

  val new_order : unit -> response Lwt.t
end

module Make : functor (P : Parameters) -> New_order'