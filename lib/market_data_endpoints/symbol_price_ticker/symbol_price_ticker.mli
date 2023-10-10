open Variants;;

module type Price = sig 
  val endpoint : string 
  val get_price : unit -> (string * float) list Lwt.t
end

module type Parameters =  sig
  val url: string
  val symbol : Symbol.t
end

module Make :
  functor (P : Parameters) -> Price
