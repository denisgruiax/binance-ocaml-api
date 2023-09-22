val create_header : string -> Cohttp.Header.t
val get : string -> [> Ezjsonm.t]
val post : Uri.t -> Cohttp.Header.t -> [> Ezjsonm.t]