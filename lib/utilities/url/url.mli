val timestamp : unit -> string
val create_payload : (string * string) list -> string
val build_public : string -> string -> (string * string) list -> string
val build_signed : string -> string -> (string * string) list -> string -> string