module type Order' = sig
  val place_order : unit -> string
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
  let headers = Cohttp.Header.init_with "X-MBX-APIKEY" P.api_key;;

  let generate_hmac_sha256 payload secret_key =
    let hmac_key = Cstruct.of_string secret_key in
    let payload_cs = Cstruct.of_string payload in
    let hmac = Nocrypto.Hash.SHA256.hmac ~key:hmac_key payload_cs in
    Cstruct.to_string hmac

  let hex_encode s =
    let open Printf in
    let buf = Buffer.create (String.length s * 2) in
    String.iter (fun c -> bprintf buf "%02x" (int_of_char c)) s;
    Buffer.contents buf;;

  let timestamp () = string_of_int(int_of_float ((Unix.gettimeofday ()) *. 1000.0));;

  let make_payload timestamp = let open P in Printf.sprintf "symbol=%s&side=%s&type=%s&timeInForce=%s&quantity=%s&price=%s&recvWindow=%s&timestamp=%s" symbol side order_type time_in_force quantity price recv_window timestamp;;

  let signature payload = let hmac = generate_hmac_sha256 payload (P.secret_key) in
    hex_encode hmac;;

  let uri () = let payload = make_payload (timestamp ()) in Uri.of_string (P.url ^ "?" ^ payload ^ "&signature=" ^ signature payload);;

  let place_order () = let open Lwt.Infix in 
    let result = Cohttp_lwt_unix.Client.post (uri ())  ~headers ~body:(Cohttp_lwt.Body.empty)
      >>= fun (_, body) ->
      Cohttp_lwt.Body.to_string body
    in Lwt_main.run result;;
end