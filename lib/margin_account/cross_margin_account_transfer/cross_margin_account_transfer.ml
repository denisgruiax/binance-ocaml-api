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

module type Cross_margin_account_transfer' = sig
  val place_transfer : float -> Wallet_transfer_direction.t -> int option Lwt.t
end

module Make(P : Parameters) : Cross_margin_account_transfer' = struct
  let parameters = let open P in [
      ("asset", Symbol.wrap asset);
      ("recvWindows", string_of_int recv_window)
    ];;

  let headers = Requests.create_header P.api_key;;

  let get_data json  = json >>= fun json' -> 
    Lwt.return (Some (Ezjsonm.(find json' ["id"] |> get_float |> int_of_float)));;

  let place_transfer amount type_of_transfer = 
    let parameters = parameters @ [("amount", string_of_float amount); ("type", Wallet_transfer_direction.wrap type_of_transfer)] in
    let url = Url.build_signed P.url "/sapi/v1/margin/transfer" parameters P.secret_key in
    let json = Requests.post (Uri.of_string url) in get_data (json headers);;
end