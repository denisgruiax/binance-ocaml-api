open Utilities;;
open Lwt.Infix;;

module type Parameters = sig val url : string end;;

module type Connectivity = sig
  val endpoint: string
  val test_connectivity : unit -> string Lwt.t
end

module Make(P : Parameters) : Connectivity = struct
  let endpoint = P.url ^  "/api/v3/ping";;

  let json_to_string json = 
    json >>= fun json' -> Lwt.return (Ezjsonm.to_string json');;

  let test_connectivity () = json_to_string (Requests.get endpoint);;
end