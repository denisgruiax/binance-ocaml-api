val timestamp : unit -> string
val create_payload : (string * string) option list -> string
val build_public : string -> string -> (string * string) option list -> string
val build_signed : string -> string -> (string * string) option list -> string -> string
val check_limit : int -> int -> int -> int -> int