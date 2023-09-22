open Utilities;;

module type Order' = sig
  val place_order : unit -> [> Ezjsonm.t]
end

module type Parameters = sig
  val api_key : string
  val secret_key : string
  val url : string
  val symbol : string
  val side : string
  val order_type : string
  val time_in_force : string
  val quantity : string
  val price : string
  val recv_window : string
end

module Make(P : Parameters) : Order' = struct
  let endpoint = "/api/v3/order";;

  let headers = Requests.create_header P.api_key;;

  let timestamp () = string_of_int(int_of_float ((Unix.gettimeofday ()) *. 1000.0));;

  let make_payload timestamp = let open P 
  in Printf.sprintf "symbol=%s&side=%s&type=%s&timeInForce=%s&quantity=%s&price=%s&recvWindow=%s&timestamp=%s" symbol side order_type time_in_force quantity price recv_window timestamp;;

  let uri () = let payload = make_payload (timestamp ()) 
    in Uri.of_string (P.url ^ endpoint ^ "?" ^ payload ^ "&signature=" ^ Crypto.create_signature payload P.secret_key);;

  let place_order () = Requests.post (uri ()) (headers);;
end