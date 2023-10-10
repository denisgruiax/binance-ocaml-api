open Utilities;;
open Variants;;

module type Order = sig
  val place_order : unit -> [> Ezjsonm.t] Lwt.t
end

module type Parameters = sig
  val api_key : string
  val secret_key : string
  val url : string
  val symbol : Symbol.t
  val side : Order_side.t
  val order_type : Order_types.t
  val time_in_force : Time_in_force.t
  val quantity : float
  val price : float
  val stop_price : float
  val iceberg_quantity : float
  val new_order_response_type : Order_response.t
  val recv_window : int
end

module Make(P : Parameters) : Order = struct
  let endpoint = "/api/v3/order";;

  let headers = Requests.create_header P.api_key;;

  let parameters = let open P in [
      ("symbol", Symbol.wrap symbol);
      ("side", Order_side.wrap side);
      ("type", Order_types.wrap order_type);
      ("timeInForce", Time_in_force.wrap time_in_force);
      ("quantity", string_of_float quantity);
      ("price", string_of_float price);
      ("recvWindow", string_of_int recv_window);
    ];;

  let place_order () = 
    let url_string = Url.build_signed P.url endpoint parameters P.secret_key 
    in Requests.post (Uri.of_string url_string) (headers);;
end