type t = {
  id : Decimal.t;
  price : Decimal.t;
  qty : Decimal.t;
  quote_qty : Decimal.t;
  time : Decimal.t;
  is_buyer_maker : bool;
  is_best_match : bool
};;

val printl : t option -> unit Lwt.t

val print_list : t option list -> unit Lwt.t

val get : base_url:string -> endpoint:string -> parameters:(string * string) list -> t option list Lwt.t