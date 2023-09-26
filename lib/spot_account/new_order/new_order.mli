module type Order = sig
  val place_order : unit -> [> Ezjsonm.t]
end

module type Parameters = sig
  val api_key : string
  val secret_key : string
  val url : string
  val symbol : string
  val side : string
  val order_type : string
  val time_in_force : string
  val quantity : string
  val price : string
  val recv_window : string
end

module Make :
  functor (P : Parameters) -> Order