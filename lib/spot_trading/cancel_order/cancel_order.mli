open Variants;;

type response = {
  symbol : Symbol.t;
  orig_client_order_id : string;
  order_id : Decimal.t;
  order_list_id : Decimal.t;
  client_order_id : string;
  transact_time: Decimal.t;
  price : Decimal.t;
  orig_qty : Decimal.t;
  executed_qty : Decimal.t;
  cummulative_quote_qty : Decimal.t;
  status : Order_status.t;
  time_in_force : Time_in_force.t;
  order_type : Order_types.t; 
  side : Order_side.t;
  self_trade_prevention_mode : string
};;

val printl : (response, Error_code.t) result -> unit Lwt.t

val send : base_url:string -> endpoint:string -> api_key:string -> secret_key:string -> parameters:(string * string) list -> (response, Error_code.t) result Lwt.t