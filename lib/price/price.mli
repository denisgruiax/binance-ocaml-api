module type Price' =
  sig val endpoint : string val get_price : unit -> float end
module Make :
  functor (Endpoint : sig val price_url : string end)
    (Pair : sig val pair : string end) -> Price'
