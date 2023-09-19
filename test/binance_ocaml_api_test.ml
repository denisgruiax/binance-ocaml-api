include Binance_ocaml_api;;

let library_unit_testing () =
  let open Alcotest in run "Module Endoints" [
    Utilities_test.suite ();
    Symbol_price_ticker_test.suite ();
    Klines_test.suite ();
    New_order_test.suite ()
  ];;

library_unit_testing ();;