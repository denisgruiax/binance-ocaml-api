include Binance_ocaml_api;;

let library_unit_testing () =
  Lwt_main.run @@ Alcotest_lwt.run "Binance Ocaml API Unit Testing" [
    Market_data_endpoints_test.Klines_test.suite ();
    Market_data_endpoints_test.Order_book_test.suite();
    Market_data_endpoints_test.Server_time_test.suite();
    Market_data_endpoints_test.Symbol_price_ticker_test.suite ();
    Market_data_endpoints_test.Test_connectivity_test.suite ();
    Spot_account_test.New_order_test.suite ();
    Utilities_test.suite ()
  ];;

library_unit_testing ();;