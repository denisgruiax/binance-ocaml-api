open Utilities;;
open Variants;;

let get_data = function
  |`O[
      ("symbol", `String symbol);
      ("price", `String price)
    ] -> Ok (Symbol.unwrap symbol, Decimal.of_string price)
  |error -> Error (Error_code.get error);;

let parse_symbol_price json = let open Lwt.Infix in 
  json >>= fun json' -> Lwt.return (get_data json');;

let get ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = parse_symbol_price (Requests.get (Url.build_public base_url endpoint parameters));;