open Utilities;;
open Lwt.Infix;;

let get_data = function
  |`O[("serverTime", `Float server_time)] -> Ok (Decimal.of_int (int_of_float server_time))
  |error -> Error (Error_code.get error);;

let json_to_time json = json >>= fun json' -> Lwt.return (get_data json');;

let get ~base_url:base_url ~endpoint:endpoint = let url = String.concat "" [base_url; endpoint] in
  json_to_time (Requests.get url);;