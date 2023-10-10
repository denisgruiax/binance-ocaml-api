open Variants;;

module type Parameters = sig
  val url : string
  val symbol : Symbol.t
  val limit : int
end

module type Order_book' = sig
  type t = {
    lastUpdateId : int;
    bids_t : (float * float) list;
    asks_t : (float * float) list
  }

  val get_depth : unit -> t Lwt.t
end

module Make : functor(P : Parameters) -> Order_book'