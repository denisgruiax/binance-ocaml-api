type commission_rate = {
  maker : Decimal.t;
  taker : Decimal.t;
  buyer : Decimal.t;
  seller : Decimal.t
};;

type balance = {
  asset : string;
  free : Decimal.t;
  locked : Decimal.t
};;

type account = {
  maker_commission : Decimal.t;
  taker_commision : Decimal.t;
  buyer_commission : Decimal.t;
  seller_commission : Decimal.t;
  commission_rates : commission_rate option;
  can_trade : bool;
  can_withdraw : bool;
  can_deposit : bool;
  brokered : bool;
  require_self_trade_prevention : bool;
  prevent_sor : bool;
  update_time : Decimal.t;
  account_type : string;
  balances : balance option list;
  permissions : string list;
  uid : Decimal.t
};;

val get_account : string -> string -> string -> string -> (string * string) list -> account option Lwt.t;;

val print_account : account option -> unit Lwt.t