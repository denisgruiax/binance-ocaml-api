open Variants

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string
  val symbol : Symbol.t
  val is_isolated : bool
  val order_id : int
  val recv_window : int
end

module type Close_order' = sig
  type t

  val close_order : unit -> t Lwt.t
end

module Make: functor(P : Parameters) -> Close_order' 