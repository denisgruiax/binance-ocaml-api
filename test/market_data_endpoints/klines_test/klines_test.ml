open Binance_ocaml_api.Market_data_endpoints
open Utilities;;
open Lwt.Syntax;;
open Variants.Symbol;;
open Variants.Chart_interval;;
module BitcoinCandlesticks = Klines.Make(struct 
    let url = Base_urls.api_default 
    let symbol = Symbol "BTCUSDT" 
    let interval = Minute 5
    let startTime = 0
    let endTime = 0
    let limit = 100
  end);;

module MultiversXCandlesticks = Klines.Make(struct 
    let url = Base_urls.api_default
    let symbol = Symbol "EGLDUSDT"
    let interval = Hour 1
    let startTime = 0
    let endTime = 0
    let limit = 500
  end);;

module PolkadotCandlesticks = Klines.Make(struct
    let url = Base_urls.api_default
    let symbol = Symbol "DOTUSDT"
    let interval = Hour 4
    let startTime = 0
    let endTime = 0
    let limit  = 1000  
  end);; 

let bitcoin_candlesticks_size () = let* candlesticks = BitcoinCandlesticks.get_candlesticks ()
  in Alcotest.(check int "Bitcoin number of candlesticks.") 100 (List.length candlesticks);
  Lwt.return ();;

let test_bitcoin_candlesticks_size switch () =
  Lwt_switch.add_hook (Some switch) bitcoin_candlesticks_size;Lwt.return ();;

let multiversx_candlesticks_size () = let* candlesticks = MultiversXCandlesticks.get_candlesticks ()
  in Alcotest.(check int "Multiversx number of candlesticks.") 500 (List.length candlesticks);
  Lwt.return ();;

let test_multiversx_candlesticks_size switch () =
  Lwt_switch.add_hook (Some switch) multiversx_candlesticks_size;Lwt.return ();;

let polkadot_candlesticks_size () =  let* candlesticks = PolkadotCandlesticks.get_candlesticks ()
  in Alcotest.(check int "Polkadot number of candlesticks.") 1000 (List.length candlesticks);
  Lwt.return ();;

let test_polkadot_candlesticks_size switch () =
  Lwt_switch.add_hook (Some switch) polkadot_candlesticks_size;Lwt.return ();;

let suite () = "Klines", [
    Alcotest_lwt.(test_case "Bitcoin number of candlesticks" `Quick test_bitcoin_candlesticks_size);
    Alcotest_lwt.(test_case "MultiversX number of candlesticks" `Quick test_multiversx_candlesticks_size);
    Alcotest_lwt.(test_case "Polkadot number of candlesticks" `Quick test_polkadot_candlesticks_size)
  ];;