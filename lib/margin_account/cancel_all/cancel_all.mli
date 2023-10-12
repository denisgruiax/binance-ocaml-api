open Variants;;

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string 
  val symbol : Symbol.t
  val recv_window : int
end

module type Cancel_all' = sig
  val place : bool -> bool Lwt.t
end

module Make : functor (P : Parameters) -> Cancel_all'