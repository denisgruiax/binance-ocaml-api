open Utilities;;
open Lwt.Infix;;
open Records.Response;;
open Variants;;

let parse_response get_data json = 
  json >>= fun json' -> Lwt.return (get_data json');; 

let send ~base_url:base_url ~endpoint:endpoint ~api_key:api_key ~secret_key:secret_key ~order_response:order_response ~parameters:parameters = 
  let header = Requests.create_header api_key in
  let parameters = parameters @ [("newOrderRespType", Order_response.wrap order_response)] in
let url = Url.build_signed base_url endpoint parameters secret_key in
match order_response with
|Order_response.ACK -> ACK (parse_response get_ack (Requests.post url header))
|RESULT -> RESULT (parse_response get_result (Requests.post url header))
|FULL -> FULL (parse_response get_full (Requests.post url header));;