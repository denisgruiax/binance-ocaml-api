open Variants;;

module type Order = sig
  val place_order : unit -> [> Ezjsonm.t] Lwt.t
end

module type Parameters = sig
  val api_key : string
  val secret_key : string
  val url : string
  val symbol : Symbol.t
  val side : Order_side.t
  val order_type : Order_types.t
  val time_in_force : Time_in_force.t
  val quantity : float
  val price : float
  val stop_price : float
  val iceberg_quantity : float
  val new_order_response_type : Order_response.t
  val recv_window : int
end

module Make :
  functor (P : Parameters) -> Order