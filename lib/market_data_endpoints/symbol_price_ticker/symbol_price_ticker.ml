open Utilities;;
open Variants;;
module type Price = sig
  val endpoint : string
  val get_price : unit -> (string * float) list Lwt.t
end

module type Parameters =  sig
  val url: string
  val symbol : Symbol.t
end

module Make(P : Parameters) : Price = struct
  let endpoint = "/api/v3/ticker/price";;

  let variant_to_parameter_pair symbols = let open Symbol in 
    match symbols with
    |Symbol symbol -> ("symbol", symbol)
    |Symbols symbols -> ("symbols", Symbol.wrap (Symbols symbols));;

  let parameters = let open P in [
      variant_to_parameter_pair symbol
    ];;

  let get_data = function
    |fields -> (
        Ezjsonm.(find fields ["symbol"] |> get_string),
        float_of_string Ezjsonm.(find fields ["price"] |> get_string)
      );;

  let parse_symbol_prices json = let open Lwt.Infix in 
    json >>= fun json' -> Lwt.return (Data.get_list get_data json');;

  let get_price () = parse_symbol_prices (Requests.get (Url.build_public P.url endpoint parameters));;
end