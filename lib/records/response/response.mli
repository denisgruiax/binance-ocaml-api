open Variants

type fill = {
  price : Decimal.t;
  qty : Decimal.t;
  commission : Decimal.t;
  commission_asset : string;
  trade_id : Decimal.t
}

type ack = {
  symbol : Symbol.t;
  order_id : Decimal.t;
  order_list_id : Decimal.t;
  client_order_id : string;
  transact_time: Decimal.t
}

type result = {
  ack : ack option;
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
}

type full = {
  result : result option;
  fills : fill option list
}

type response = ACK of ack option | RESULT of result option | FULL of full option

type lwt_response = ACK of ack option Lwt.t | RESULT of result option Lwt.t | FULL of full option Lwt.t

val get_fill : [> Ezjsonm.t] -> fill option
val print_fill : fill option -> unit Lwt.t
val print_fills : fill option list -> unit Lwt.t

val get_ack : [> Ezjsonm.t] -> ack option 
val print_ack : ack option -> unit Lwt.t

val get_result : [> Ezjsonm.t] -> result option
val print_result : result option -> unit Lwt.t

val get_full : [> Ezjsonm.t] -> full option
val print_full : full option -> unit Lwt.t