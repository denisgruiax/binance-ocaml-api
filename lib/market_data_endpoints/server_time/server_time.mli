module type Parameters = sig
  val  url : string
end

module type Server_time' = sig
  val endpoint : string
  val get_server_time : unit -> int Lwt.t
end

module Make : functor (P : Parameters) -> Server_time'