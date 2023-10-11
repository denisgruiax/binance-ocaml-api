open Variants

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string 
  val asset : Symbol.t
  val recv_window : int
end

module type Cross_margin_account_transfer' = sig
  val place_transfer : float -> Wallet_transfer_direction.t -> int option Lwt.t
end

module Make : functor (P : Parameters) -> Cross_margin_account_transfer'