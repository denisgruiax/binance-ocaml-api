include Binance_ocaml_api;;

let library_unit_testing () =
  let open Alcotest in run "Module Endoints" [
    Utilities_test.suite ();
    
    Market_data_endpoints_test.Symbol_price_ticker_test.suite ();
    Market_data_endpoints_test.Klines_test.suite ();

    Spot_account_test.New_order_test.suite ()
  ];;

library_unit_testing ();;