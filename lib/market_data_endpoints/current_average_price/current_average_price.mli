module type Parameters = sig
  val url : string
  val symbol : string
end

module type Current_average_price' = sig
  type t = {
    mins : int;
    price : float
  }

  val get_current_average_price : unit -> t Lwt.t
end

module Make : functor (P : Parameters) -> Current_average_price'