open Variants

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string 
  val asset : Symbol.t
  val recv_window : int
end

module type Margin_account_borrow' = sig
  val borrow : float -> Wallet_transfer_direction.t -> int option Lwt.t
  val isolated_borrow : Symbol.t -> float -> Wallet_transfer_direction.t -> int option Lwt.t
end

module Make : functor (P : Parameters) -> Margin_account_borrow'