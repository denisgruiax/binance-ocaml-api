open Binance_ocaml_api.Market_data_endpoints;;
open Alcotest;;


module Bitcoin = Symbol_price_ticker.Make(struct let url = Utilities.Base_urls.api_default let symbol = "BTCUSDT" end);; 

let bitcoin_price () = check bool "Bitcoin price" true (Bitcoin.get_price () > 20000.0);;

let suite () = "Price", [
    test_case "Bitcoin price" `Quick bitcoin_price
  ];; 