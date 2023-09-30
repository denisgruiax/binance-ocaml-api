open Utilities;;
open Lwt.Infix;;

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

module type Margin_account_borrow' = sig
  val make_borrow : unit -> int Lwt.t
end

module Make(P : Parameters) : Margin_account_borrow' = struct
  let parameters = let open P in [
      ("asset", asset);
      ("isIsolated", isIsolated);
      ("amount", string_of_int amount);
      ("symbol", symbol);
      ("recvWindows", string_of_int recvWindow)
    ];;

  let endpoint = Url.build_signed P.url "/sapi/v1/margin/loan" parameters P.secret_key;;

  let headers = Requests.create_header P.api_key;;

  let get_data json  = json >>= fun json' -> 
    Lwt.return (Ezjsonm.(find json' ["id"] |> get_float |> int_of_float));;

  let make_borrow () = let json = Requests.post (Uri.of_string endpoint) in get_data (json headers);;
end