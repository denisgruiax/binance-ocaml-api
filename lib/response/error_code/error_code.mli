type error_code = {
  code : Decimal.t;
  msg : string
};;

val get : [> Ezjsonm.t] -> error_code option
val printl : error_code option -> unit Lwt.t