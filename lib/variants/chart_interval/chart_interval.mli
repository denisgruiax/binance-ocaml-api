type t =
  |Second of int
  |Minute of int
  |Hour of int
  |Day of int
  |Week of int
  |Month of int;;

val wrap : t -> string

val unwrap : string -> t