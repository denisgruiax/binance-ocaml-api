open Utilities;;
open Lwt.Infix;;
open Variants;;

module type Parameters = sig
  val url : string
  val api_key : string
  val secret_key : string 
  val asset : Symbol.t
  val is_isolated : bool
  val symbol : Symbol.t
  val amount : float
  val recvWindow : int
end

module type Margin_account_repay' = sig
  val make_borrow : unit -> int Lwt.t
end

module Make(P : Parameters) : Margin_account_repay' = struct
  let parameters = let open P in [
      ("asset", Symbol.wrap asset);
      ("isIsolated", Binance_bool.wrap is_isolated);
      ("symbol", Symbol.wrap symbol);
      ("amount", string_of_float amount);
      ("recvWindows", string_of_int recvWindow)
    ];;

  let endpoint = Url.build_signed P.url "/sapi/v1/margin/repay" parameters P.secret_key;;

  let headers = Requests.create_header P.api_key;;

  let get_data json  = json >>= fun json' -> 
    Lwt.return (Ezjsonm.(find json' ["id"] |> get_float |> int_of_float));;

  let make_borrow () = let json = Requests.post (Uri.of_string endpoint) in get_data (json headers);;
end