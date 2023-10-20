val create_header : string -> Cohttp.Header.t
val get : string -> [> Ezjsonm.t] Lwt.t
val get_signed : string -> Cohttp.Header.t -> [> Ezjsonm.t] Lwt.t
val post : string -> Cohttp.Header.t -> [> Ezjsonm.t] Lwt.t
val delete : string -> Cohttp.Header.t -> [>Ezjsonm.t] Lwt.t