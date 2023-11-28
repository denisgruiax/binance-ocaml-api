type error_code = {
  code : Decimal.t;
  msg : string
};;

val get : [> Ezjsonm.t] -> error_code
val printl : error_code -> unit Lwt.t