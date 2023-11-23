type error_code = {
  code : Decimal.t;
  msg : string
};;

let get = function
  |`O[
      ("code", `Float code);
      ("msg", `String msg)
    ] -> Some {
      code = Decimal.of_int (int_of_float code);
      msg = msg
    }
  |_ -> None;;

let print = function
  |Some {
      code = code;
      msg = msg
    } -> let open Lwt.Syntax in
    let* () = Lwt_io.printf "code = %s\n" (Decimal.to_string code) in
    let* () = Lwt_io.printf "msg = %s\n\n" msg in
    Lwt.return ()
  |None -> Lwt.return ();;