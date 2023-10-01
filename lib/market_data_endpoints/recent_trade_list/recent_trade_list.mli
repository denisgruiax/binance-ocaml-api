module type Parameters = sig
  val url : string
  val symbol : string
  val limit : int
end

module type Recent_trade_list' = sig
  type t = {
    id : int;
    price : float;
    qty : float;
    quoteQty : float;
    time : int;
    isBuyerMaker : bool;
    isBestMatch : bool
  }

  val get_recent_trade_list : unit -> t list Lwt.t
end

module Make : functor (P : Parameters) -> Recent_trade_list' 