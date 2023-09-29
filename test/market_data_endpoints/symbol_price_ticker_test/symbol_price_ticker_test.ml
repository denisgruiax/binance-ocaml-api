open Binance_ocaml_api.Market_data_endpoints;;
open Lwt.Syntax;;

module Bitcoin = Symbol_price_ticker.Make(struct let url = Utilities.Base_urls.api_default let symbol = "BTCUSDT" end);; 

let bitcoin_price () = let* price = Bitcoin.get_price () 
  in Alcotest.(check bool "Bitcoin price" true (price > 0.0)); Lwt.return ();;

let test_bitcoin_price switch () = 
  Lwt_switch.add_hook (Some switch) bitcoin_price;Lwt.return ();;

let suite () = "Symbol price ticker", [
    Alcotest_lwt.test_case "Get bitcoin price." `Quick test_bitcoin_price
  ];; 