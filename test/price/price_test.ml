open Binance_ocaml_api;;
open Alcotest;;

module Enpoints = Utilities.Make(struct let api = Utilities.BaseApis.api_default end);;

module Bitcoin = Price.Make(struct let price_url = Enpoints.ticker_price end) (struct let symbol = "BTCUSDT" end);; 

let bitcoin_price () = check bool "Bitcoin price" true (Bitcoin.get_price () > 20000.0);;

let suite () = "Price", [
    test_case "Bitcoin price" `Quick bitcoin_price
  ];; 