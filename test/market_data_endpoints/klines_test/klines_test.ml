open Binance_ocaml_api.Market_data_endpoints
open Alcotest;;
open Utilities;;

module BitcoinCandlesticks = Klines.Make(struct let url = Base_urls.api_default let symbol = "BTCUSDT" let size = "5m" end);;
module MultiversXCandlesticks = Klines.Make(struct let url = Base_urls.api_default let symbol = "EGLDUSDT" let size = "5m" end);;
module PolkadotCandlesticks = Klines.Make(struct let url = Base_urls.api_default let symbol = "DOTUSDT" let size = "5m" end);;

let bitcoin_candlesticks = BitcoinCandlesticks.get_candlesticks ();;
let multiversx_candlesticks = MultiversXCandlesticks.get_candlesticks ();;
let polkadot_candlesticks = PolkadotCandlesticks.get_candlesticks ();; 

let bitcoin_candlesticks_size () = check int "Bitcoin number of candlesticks" 500 ((List.length (bitcoin_candlesticks)));;
let multiversx_candlesticks_size () = check int "MultiversX number of candlesticks" 500 ((List.length (multiversx_candlesticks)));;
let polkadot_candlesticks_size () = check int "Polkadot number of candlesticks" 500 ((List.length (polkadot_candlesticks)));;

let suite () = "Klines", [
    test_case "Bitcoin number of candlesticks" `Quick bitcoin_candlesticks_size;
    test_case "MultiversX number of candlesticks" `Quick multiversx_candlesticks_size;
    test_case "Polkadot number of candlesticks" `Quick polkadot_candlesticks_size
  ];;