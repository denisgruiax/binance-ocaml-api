open Variants;;

type fill = {
  price : Decimal.t;
  qty : Decimal.t;
  commission : Decimal.t;
  commission_asset : string;
  trade_id : Decimal.t
};;

type ack_response = {
  symbol : Symbol.t;
  order_id : Decimal.t;
  order_list_id : Decimal.t;
  client_order_id : string;
  transact_time: Decimal.t
};;

type result_response = {
  ack_response : (ack_response, Error_code.t) result;
  price : Decimal.t;
  orig_qty : Decimal.t;
  executed_qty : Decimal.t;
  cummulative_quote_qty : Decimal.t;
  status : Order_status.t;
  time_in_force : Time_in_force.t;
  order_type : Order_types.t;
  side : Order_side.t;
  working_time : Decimal.t;
  self_trade_prevention_mode : string
};;

type full_response = {
  result_response : (result_response, Error_code.t) result;
  fills : (fill, Error_code.t) result list
};;

type new_order_response = Ack of ((ack_response, Error_code.t) result) | Result of ((result_response, Error_code.t) result) | Full of ((full_response, Error_code.t) result);;

val get_fill : [> Ezjsonm.t] -> (fill, Error_code.t) result
val print_fill : (fill, Error_code.t) result -> unit Lwt.t

val get_ack : [> Ezjsonm.t] -> (ack_response, Error_code.t) result
val print_ack : (ack_response, Error_code.t) result -> unit Lwt.t

val get_result : [> Ezjsonm.t] -> (result_response, Error_code.t) result
val print_result : (result_response, Error_code.t) result -> unit Lwt.t

val get_full : [> Ezjsonm.t] -> (full_response, Error_code.t) result
val print_full : (full_response, Error_code.t) result -> unit Lwt.t

val get : [> Ezjsonm.t] -> (new_order_response, Error_code.t) result
val printl : (new_order_response, Error_code.t) result -> unit Lwt.t

val send : base_url:string -> endpoint:string -> api_key:string -> secret_key:string -> parameters:(string * string) list -> (new_order_response, Error_code.t) result Lwt.t