include Binance_ocaml_api;;

let library_unit_testing () =
  let open Alcotest in run "Module Endoints" [
    Utilities_test.suite ();
    Price_test.suite ();
    Klines_test.suite ();
    Order_test.suite ()
  ];;

library_unit_testing ();;