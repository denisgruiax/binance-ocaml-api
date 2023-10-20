open Utilities;;
open Variants;;
open Lwt.Infix;;

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

module Make(P : Parameters) : Cancel_all' = struct
  let parameters = let open P in [
      ("symbol", Symbol.wrap symbol);
      ("recvWindow", string_of_int recv_window)
    ];;

  let headers = Requests.create_header P.api_key;;

  let get_data (json : Ezjsonm.t) = match json with
    |`A _-> true
    |_ -> false;;

  let parse_response json = 
    json >>= fun json' -> Lwt.return (get_data json');;

  let place is_isolated = 
    let parameters = parameters @ [("isIsolated", Binance_bool.wrap is_isolated)] in
    let url = Url.build_signed P.url "/sapi/v1/margin/openOrders" parameters P.secret_key in
    parse_response (Requests.delete url headers);;
end