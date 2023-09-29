open Binance_ocaml_api.Market_data_endpoints
open Utilities;;
open Lwt.Syntax;;

module BitcoinCandlesticks = Klines.Make(struct let url = Base_urls.api_default let symbol = "BTCUSDT" let interval = "5m" end);;
module MultiversXCandlesticks = Klines.Make(struct let url = Base_urls.api_default let symbol = "EGLDUSDT" let interval = "5m" end);;
module PolkadotCandlesticks = Klines.Make(struct let url = Base_urls.api_default let symbol = "DOTUSDT" let interval = "5m" end);; 

let bitcoin_candlesticks_size () = let* candlesticks = BitcoinCandlesticks.get_candlesticks ()
  in Alcotest.(check int "Bitcoin number of candlesticks.") 500 (List.length candlesticks);
  Lwt.return ();;

let test_bitcoin_candlesticks_size switch () =
  Lwt_switch.add_hook (Some switch) bitcoin_candlesticks_size;Lwt.return ();;

let multiversx_candlesticks_size () = let* candlesticks = MultiversXCandlesticks.get_candlesticks ()
  in Alcotest.(check int "Multiversx number of candlesticks.") 500 (List.length candlesticks);
  Lwt.return ();;

let test_multiversx_candlesticks_size switch () =
  Lwt_switch.add_hook (Some switch) multiversx_candlesticks_size;Lwt.return ();;

let polkadot_candlesticks_size () =  let* candlesticks = PolkadotCandlesticks.get_candlesticks ()
  in Alcotest.(check int "Polkadot number of candlesticks.") 500 (List.length candlesticks);
  Lwt.return ();;

let test_polkadot_candlesticks_size switch () =
  Lwt_switch.add_hook (Some switch) polkadot_candlesticks_size;Lwt.return ();;

let suite () = "Klines", [
    Alcotest_lwt.(test_case "Bitcoin number of candlesticks" `Quick test_bitcoin_candlesticks_size);
    Alcotest_lwt.(test_case "MultiversX number of candlesticks" `Quick test_multiversx_candlesticks_size);
    Alcotest_lwt.(test_case "Polkadot number of candlesticks" `Quick test_polkadot_candlesticks_size)
  ];;