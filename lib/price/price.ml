module type Pair = sig
  val pair : string
  val get_price : float
end

module UpdateSymbol (Price : Pair) (Symbol : sig val pair : string end) = struct
  let pair = "https://api.binance.com"^"/api/v3/ticker/price?symbol="^Symbol.pair;;
  let json_to_float json = let price_string = Ezjsonm.(get_string (find json ["price"])) in float_of_string price_string;;

  let get_json_from_api_url url = let ezjsonm =
                                    Lwt.bind
                                      (Cohttp_lwt_unix.Client.get (Uri.of_string url))
                                      (fun (_, body) ->
                                         Lwt.bind (Cohttp_lwt.Body.to_string body) (fun body_string ->
                                             let json = Ezjsonm.from_string body_string in
                                             Lwt.return json))
    in
    Lwt_main.run ezjsonm;;

  let get_price = json_to_float (get_json_from_api_url pair);;
end