open Variants

val get : base_url:string -> endpoint:string -> parameters:(string * string) list -> (Symbol.t * Decimal.t) Lwt.t