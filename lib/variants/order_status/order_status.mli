type t = NEW | PARTIALLY_FILLED | FILLED
                  | CANCELED | PENDING_CANCEL | REJECTED | EXPIRED | EXPIRED_IN_MATCH;;

val wrap : t -> string

val unwrap : string -> t