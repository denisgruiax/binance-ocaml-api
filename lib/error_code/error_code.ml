type t = {
  code : Decimal.t;
  msg : string
};;

let get = function
  |`O[
      ("code", `Float code);
      ("msg", `String msg)
    ] -> {
      code = Decimal.of_int (int_of_float code);
      msg = msg
    }
  |_ -> {
      code = Decimal.of_int (-1001);
      msg = "Error code default value, something went worng, please check manually the API response!"
    };;

let printl = function
  |{
    code = code;
    msg = msg
  } -> let open Lwt.Syntax in
    let* () = Lwt_io.printf "code = %s\n" (Decimal.to_string code) in
    let* () = Lwt_io.printf "msg = %s\n\n" msg in
    Lwt.return ();;