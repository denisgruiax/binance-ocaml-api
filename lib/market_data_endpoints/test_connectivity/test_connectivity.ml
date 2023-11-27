open Utilities;;
open Lwt.Infix;;
let json_to_string json = 
  json >>= fun json' -> Lwt.return (Ezjsonm.to_string json');;

let get ~base_url:base_url ~endpoint:endpoint = let url = String.concat "" [base_url; endpoint] in
  json_to_string (Requests.get url);;