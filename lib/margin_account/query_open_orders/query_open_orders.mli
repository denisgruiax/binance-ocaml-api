open Variants;;

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

module Make : functor(P : Parameters) -> Query_open_orders'