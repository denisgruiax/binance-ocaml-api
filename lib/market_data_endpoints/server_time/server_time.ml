open Utilities;;
open Lwt.Infix;;

let json_to_time json = json >>= fun json' -> Lwt.return Ezjsonm.(get_int (find json' ["serverTime"]));;

let get ~base_url:base_url ~endpoint:endpoint = let url = String.concat "" [base_url; endpoint] in
  json_to_time (Requests.get url);;