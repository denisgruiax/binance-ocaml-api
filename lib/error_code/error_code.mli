type t = {
  code : Decimal.t;
  msg : string
};;

val get : [> Ezjsonm.t] -> t

val printl : t -> unit Lwt.t