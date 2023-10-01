module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string 
  val asset : string
  val isIsolated : string
  val amount : int
  val symbol : string
  val recvWindow : int
end

module type Margin_account_repay' = sig
  val make_borrow : unit -> int Lwt.t
end

module Make : functor (P : Parameters) -> Margin_account_repay'