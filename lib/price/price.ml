module type Price' = sig
  val endpoint : string
  val get_price : unit -> float
end

module type Parameters =  sig
  val url: string
  val symbol : string
end

module Make(P : Parameters) : Price' = struct
  let endpoint = P.url ^ "?symbol=" ^ P.symbol;;

  let get_json_from_api_url endpoint = let ezjsonm =
                                         Lwt.bind
                                           (Cohttp_lwt_unix.Client.get (Uri.of_string endpoint))
                                           (fun (_, body) ->
                                              Lwt.bind (Cohttp_lwt.Body.to_string body) (fun body_string ->
                                                  let json = Ezjsonm.from_string body_string in
                                                  Lwt.return json))
    in
    Lwt_main.run ezjsonm;;

  let json_to_float json = let price_string = Ezjsonm.(get_string (find json ["price"])) in float_of_string price_string;;

  let get_price () = json_to_float (get_json_from_api_url endpoint);;
end