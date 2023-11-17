open Variants;;

module type Parameters = sig
  val url : string
  val symbol : Symbol.t
  val limit : int
end

module type Recent_trade_list' = sig
  type t = {
    id : int;
    price : float;
    qty : float;
    quote_quantity : float;
    time : int;
    is_buyer_maker : bool;
    is_best_match : bool
  }

  val get_recent_trade_list : unit -> t list Lwt.t
end

module Make : functor (P : Parameters) -> Recent_trade_list' 