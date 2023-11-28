type t = {
  last_update_id : Decimal.t;
  bids : (Decimal.t * Decimal.t) list;
  asks : (Decimal.t * Decimal.t) list
}

val get_depth : base_url:string -> endpoint:string -> parameters:(string * string) list -> (t, Error_code.t) result Lwt.t