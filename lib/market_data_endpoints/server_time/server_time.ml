open Utilities;;
open Lwt.Infix;;

module type Parameters = sig
  val  url : string
end

module type Server_time' = sig
  val endpoint : string
  val get_server_time : unit -> int Lwt.t
end

module Make(P : Parameters) : Server_time' = struct
  let endpoint = P.url ^ "/api/v3/time"

  let json_to_time json = json >>= fun json' -> Lwt.return Ezjsonm.(get_int (find json' ["serverTime"]));;

  let get_server_time () = json_to_time (Requests.get endpoint);;
end