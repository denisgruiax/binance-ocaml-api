open Utilities;;
open Lwt.Infix;;
open Variants;;

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string 
  val asset : Symbol.t
  val recv_window : int
end

module type Margin_account_repay' = sig
  val repay : float -> Wallet_transfer_direction.t -> int option Lwt.t
  val isolated_repay : Symbol.t -> float -> Wallet_transfer_direction.t -> int option Lwt.t
end

module Make(P : Parameters) : Margin_account_repay' = struct
  let parameters = let open P in [
      ("asset", Symbol.wrap asset);
      ("recvWindow", string_of_int recv_window)
    ];;

  let headers = Requests.create_header P.api_key;;

  let get_data json  = json >>= fun json' -> 
    Lwt.return (Some (Ezjsonm.(find json' ["id"] |> get_float |> int_of_float)));;

  let repay amount type_of_transfer = 
    let parameters = parameters @ [
        ("amount", string_of_float amount);
        ("type", Wallet_transfer_direction.wrap type_of_transfer);
        ("isIsolated", Binance_bool.wrap false)
      ] in
    let url = Url.build_signed P.url "/sapi/v1/margin/repay" parameters P.secret_key in
    let json = Requests.post url in get_data (json headers);;

  let isolated_repay symbol amount type_of_transfer =
    let parameters = parameters @ [
        ("symbol", Symbol.wrap symbol);
        ("amount", string_of_float amount);
        ("type", Wallet_transfer_direction.wrap type_of_transfer);
        ("isIsolated", Binance_bool.wrap true)
      ] in
    let url = Url.build_signed P.url "/sapi/v1/margin/repay" parameters P.secret_key in
    let json = Requests.post url in get_data (json headers);;
end