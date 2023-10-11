open Variants

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string 
  val asset : Symbol.t
  val is_isolated : bool
  val symbol : Symbol.t
  val amount : float
  val recv_window : int
end

module type Margin_account_repay' = sig
  val make_repay : unit -> int Lwt.t
end

module Make : functor (P : Parameters) -> Margin_account_repay'