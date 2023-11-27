open Binance_ocaml_api.Market_data_endpoints
open Utilities;;
open Lwt.Syntax;;

let url = Base_urls.api_default;;
let endpoint = Endpoints.Market_data.klines;;

let btcusdt_parameters = [
  ("symbol", "BTCUSDT");
  ("interval", "5m");
  ("limit", "100")
];;

let egldusdt_parameters = [
  ("symbol", "EGLDUSDT");
  ("interval", "5m");
  ("limit", "500")
];;

let dotusdt_parameters = [
  ("symbol", "DOTUSDT");
  ("interval", "5m");
  ("limit", "1000")
];;

let bitcoin_candlesticks_size () = let* candlesticks = Klines.get_candlesticks ~base_url:url ~endpoint:endpoint ~parameters:btcusdt_parameters
in Alcotest.(check int "Bitcoin number of candlesticks.") 100 (List.length candlesticks);
Lwt.return ();;

let test_bitcoin_candlesticks_size switch () =
  Lwt_switch.add_hook (Some switch) bitcoin_candlesticks_size;Lwt.return ();;

let multiversx_candlesticks_size () = let* candlesticks = Klines.get_candlesticks ~base_url:url ~endpoint:endpoint ~parameters:egldusdt_parameters
  in Alcotest.(check int "Multiversx number of candlesticks.") 500 (List.length candlesticks);
  Lwt.return ();;

let test_multiversx_candlesticks_size switch () =
  Lwt_switch.add_hook (Some switch) multiversx_candlesticks_size;Lwt.return ();;

let polkadot_candlesticks_size () =  let* candlesticks = Klines.get_candlesticks ~base_url:url ~endpoint:endpoint ~parameters:dotusdt_parameters
  in Alcotest.(check int "Polkadot number of candlesticks.") 1000 (List.length candlesticks);
  Lwt.return ();;

let test_polkadot_candlesticks_size switch () =
  Lwt_switch.add_hook (Some switch) polkadot_candlesticks_size;Lwt.return ();;

let suite () = "Klines", [
    Alcotest_lwt.(test_case "Bitcoin number of candlesticks" `Quick test_bitcoin_candlesticks_size);
    Alcotest_lwt.(test_case "MultiversX number of candlesticks" `Quick test_multiversx_candlesticks_size);
    Alcotest_lwt.(test_case "Polkadot number of candlesticks" `Quick test_polkadot_candlesticks_size)
  ];;