open Binance_ocaml_api
open Alcotest;;

module Enpoints = Utilities.Make(struct let api = Utilities.BaseApis.api_default end);;

module BitcoinCandlesticks = Klines.Make(struct let klines_url = Enpoints.klines end)(struct let symbol = "BTCUSDT" end)(struct let size = "5m" end);;
module MultiversXCandlesticks = Klines.Make(struct let klines_url = Enpoints.klines end)(struct let symbol = "EGLDUSDT" end)(struct let size = "5m" end);;
module PolkadotCandlesticks = Klines.Make(struct let klines_url = Enpoints.klines end)(struct let symbol = "DOTUSDT" end)(struct let size = "5m" end);;


let bitcoin_candlesticks = BitcoinCandlesticks.get_candlesticks ();;
let multiversx_candlesticks = MultiversXCandlesticks.get_candlesticks ();;
let polkadot_candlesticks = PolkadotCandlesticks.get_candlesticks ();; 

let bitcoin_candlesticks_size () = check int "Bitcoin number of candlesticks" ((List.length (bitcoin_candlesticks))) 500;;
let multiversx_candlesticks_size () = check int "MultiversX number of candlesticks" ((List.length (multiversx_candlesticks))) 500;;
let polkadot_candlesticks_size () = check int "Polkadot number of candlesticks" ((List.length (polkadot_candlesticks))) 500;;

let suite () = "Klines", [
    test_case "Bitcoin number of candlesticks" `Quick bitcoin_candlesticks_size;
    test_case "MultiversX number of candlesticks" `Quick multiversx_candlesticks_size;
    test_case "Polkadot number of candlesticks" `Quick polkadot_candlesticks_size
  ];; 