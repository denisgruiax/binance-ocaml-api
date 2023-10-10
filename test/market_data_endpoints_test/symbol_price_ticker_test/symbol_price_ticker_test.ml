open Binance_ocaml_api.Market_data_endpoints;;
open Lwt.Syntax;;
open Variants.Symbol;;

module Bitcoin = Symbol_price_ticker.Make(struct 
    let url = Utilities.Base_urls.api_default
    let symbol = Symbols ["\"BTCUSDT\""; "\"SOLUSDT\""]
  end);;

let bitcoin_price () = let* symbols = Bitcoin.get_price ()
  in let* _, price = Lwt.return (List.hd symbols)
  in Alcotest.(check bool "Bitcoin price" true (price > 0.0)); Lwt.return ();;

let test_bitcoin_price switch () = 
  Lwt_switch.add_hook (Some switch) bitcoin_price;Lwt.return ();;

let suite () = "Symbol price ticker", [
    Alcotest_lwt.test_case "Get bitcoin price." `Quick test_bitcoin_price
  ];;