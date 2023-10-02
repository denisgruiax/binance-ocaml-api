type t = SECOND | MINUTE | DAY ;;

val wrap : t -> string

val unwrap : string -> t