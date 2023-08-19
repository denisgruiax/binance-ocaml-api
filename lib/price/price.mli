module type Price' =
  sig val endpoint : string val get_price : unit -> float
end

module type Parameters =  sig
  val price_url: string
  val symbol : string
end

module Make :
  functor (P : Parameters) -> Price'
