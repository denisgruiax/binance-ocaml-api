open Variants

val get : base_url:string -> endpoint:string -> parameters:(string * string) list -> (Symbol.t * Decimal.t, Error_code.t) result Lwt.t