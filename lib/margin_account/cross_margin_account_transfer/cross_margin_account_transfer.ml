open Utilities;;
open Lwt.Infix;;
open Variants;;

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string 
  val asset : Symbol.t
  val amount : float
  val type_of_transfer : Wallet_transfer_direction.t
  val recv_window : int
end

module type Cross_margin_account_transfer' = sig
  val place_transfer : unit -> int Lwt.t
end

module Make(P : Parameters) : Cross_margin_account_transfer' = struct
  let parameters = let open P in [
      ("asset", Symbol.wrap asset);
      ("amount", string_of_float amount);
      ("type", Wallet_transfer_direction.wrap type_of_transfer);
      ("recvWindows", string_of_int recv_window)
    ];;

  let endpoint = Url.build_signed P.url "/sapi/v1/margin/transfer" parameters P.secret_key;;

  let headers = Requests.create_header P.api_key;;

  let get_data json  = json >>= fun json' -> 
    Lwt.return (Ezjsonm.(find json' ["id"] |> get_float |> int_of_float));;

  let place_transfer () = let json = Requests.post (Uri.of_string endpoint) in get_data (json headers);;
end