open Utilities;;

module type Order = sig
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

module Make(P : Parameters) : Order = struct
  let endpoint = "/api/v3/order";;
  
  let headers = Requests.create_header P.api_key;;

  let parameters = let open P in [
      ("symbol", symbol);
      ("side", side);
      ("type", order_type);
      ("timeInForce", time_in_force);
      ("quantity", quantity);
      ("price", price);
      ("recvWindow", recv_window);
    ];;

  let place_order () = 
    let url_string = Url.build_signed P.url endpoint parameters P.secret_key 
    in print_string url_string ; Requests.post (Uri.of_string url_string) (headers);;
end