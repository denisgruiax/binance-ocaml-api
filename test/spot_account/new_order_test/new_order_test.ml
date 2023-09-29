open Binance_ocaml_api.Spot_account;;
open Lwt.Syntax;;
module BitcoinOrder' = struct
  let api_key = "YOUR_BINANCE_API_KEY"
  let secret_key = "YOUR_BINANCE_SECRET_KEY"
  let url = "https://api.binance.com"
  let symbol = "BTCUSDT"
  let side = "BUY"
  let order_type = "LIMIT"
  let time_in_force = "GTC"
  let quantity = "1"
  let price = "25000"
  let recv_window = "5000"
end

module BitcoinOrder = New_order.Make(BitcoinOrder');; 

let order_response_size () = let* json = BitcoinOrder.place_order () 
  in let* response = Lwt.return(Ezjsonm.to_string json) 
  in Alcotest.(check bool "Order response length" ((String.length response > 10)) true);
  Lwt.return ();;

let test_order_response_size switch () = 
  Lwt_switch.add_hook (Some switch) order_response_size;Lwt.return ();;

let suite () = "New order", [
    Alcotest_lwt.(test_case "New order of buy test on BTC/USDT pair." `Quick test_order_response_size);
  ];; 