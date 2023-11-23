open Binance_ocaml_api.Market_data_endpoints;;
open Lwt.Syntax;;
open Variants;;
open Utilities;;

let base_url = Base_urls.api_default;;
let endpoint = Endpoints.Market_data.symbol_price_ticker;;
let parameters = [
  ("symbol", "BTCUSDT")
]

let bitcoin_price () = let* symbol, price = Symbol_price_ticker.get ~base_url:base_url ~endpoint:endpoint ~parameters:parameters in
  let open Alcotest in
  check bool "Symbol name" true ((Symbol.wrap symbol) = "BTCUSDT"); 
  check bool "Symbol price" true (float_of_string (Decimal.to_string price) > 0.0);
  Lwt.return ();;

Lwt_main.run (bitcoin_price ());;

let test_bitcoin_price switch () = 
  Lwt_switch.add_hook (Some switch) bitcoin_price;Lwt.return ();;

let suite () = "Symbol price ticker", [
    Alcotest_lwt.test_case "Get bitcoin price." `Quick test_bitcoin_price
  ];;