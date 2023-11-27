open Utilities;;
open Lwt.Infix;;

type t = {
  mins : Decimal.t;
  price : Decimal.t
};;

let get_data = function
  |`O[
      ("mins", `Float mins);
      ("price", `String price)
    ] -> Some {
      mins = Decimal.of_string (string_of_float mins);
      price = Decimal.of_string price
    }
  |_ -> None;;

let parse_data json = json >>= fun json' -> Lwt.return (get_data json');;

let get ~base_url:base_url ~endpoint:endpoint ~parameters:parameters =
  parse_data (Requests.get (Url.build_public base_url endpoint parameters));;