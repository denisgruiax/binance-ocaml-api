module type Parameters = sig val url : string end;;

module type Connectivity = sig
  val endpoint: string
  val test_connectivity : unit -> string Lwt.t
end

module Make : 
    functor (P : Parameters) -> Connectivity