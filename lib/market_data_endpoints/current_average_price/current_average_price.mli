type t = {
  mins : Decimal.t;
  price : Decimal.t
};;

val get : base_url:string -> endpoint:string -> parameters:(string * string) list -> (t, Error_code.t) result Lwt.t