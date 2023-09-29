module type Price = sig 
  val endpoint : string 
  val get_price : unit -> float Lwt.t
end

module type Parameters =  sig
  val url: string
  val symbol : string
end

module Make :
  functor (P : Parameters) -> Price
