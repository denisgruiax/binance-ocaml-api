open Variants;;

module type Parameters = sig
  val url : string
  val symbol : Symbol.t
  val limit : int
  val from_id : int
end

module type Old_trade_lookup' = sig
  type t = {
    id : int;
    price : float;
    qty : float;
    quote_quantity : float;
    time : int;
    is_buyer_maker : bool;
    is_best_match : bool
  }

  val get_older_trades : unit -> t list Lwt.t
end

module Make : functor (P : Parameters) -> Old_trade_lookup'