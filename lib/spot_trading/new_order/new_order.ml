open Utilities;;
open Lwt.Infix;;
open Records;;

let parse_response json = 
  json >>= fun json' -> Lwt.return (Response.get json');; 

let send ~base_url:base_url ~endpoint:endpoint ~api_key:api_key ~secret_key:secret_key ~parameters:parameters = 
  let header = Requests.create_header api_key in
  let parameters = parameters in
  let url = Url.build_signed base_url endpoint parameters secret_key in
  parse_response (Requests.post url header);;