type t =
  |SECOND of int
  |MINUTE of int
  |HOUR of int
  |DAY of int
  |WEEK of int
  |MONTH of int;;

val wrap : t -> string

val unwrap : string -> t