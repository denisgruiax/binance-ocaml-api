open Variants

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
  }

  val close_order : bool -> int -> t option Lwt.t
end

module Make: functor(P : Parameters) -> Close_order' 