type t = {
  id : Decimal.t;
  price : Decimal.t;
  qty : Decimal.t;
  quote_qty : Decimal.t;
  time : Decimal.t;
  is_buyer_maker : bool;
  is_best_match : bool
};;

val get_data : [> Ezjsonm.t] -> (t, Error_code.t) result

val printl : (t, Error_code.t) result -> unit Lwt.t

val print_list : (t, Error_code.t) result list -> unit Lwt.t

val get : base_url:string -> endpoint:string -> parameters:(string * string) list -> (t, Error_code.t) result list Lwt.t