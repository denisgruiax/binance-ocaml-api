open Utilities;;
module type Price = sig
  val endpoint : string
  val get_price : unit -> float Lwt.t
end

module type Parameters =  sig
  val url: string
  val symbol : string
end

module Make(P : Parameters) : Price = struct
  let endpoint = "/api/v3/ticker/price";;

  let parameters = let open P in [
      ("symbol", symbol);
    ];;

  let json_to_float json = 
    let price_string = Ezjsonm.(get_string (find json ["price"])) in float_of_string price_string;;

  let get_price_from_json json = let open Lwt.Infix in
    json >>= fun json' -> Lwt.return (Ezjsonm.(get_string (find json' ["price"])))
    >>= fun price_string -> Lwt.return (float_of_string price_string);;

  let get_price () = get_price_from_json (Requests.get (Url.build_public P.url endpoint parameters));;
end