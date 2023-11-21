open Binance_ocaml_api.Spot_account;;
open Lwt.Syntax;;
open Utilities;;
open Variants;;

let base_url = "https://testnet.binance.vision/api";;
let endpoint = "/api/v3/order";;
let api_key =  "";;
let secret_key =  "";;
let parameters = [
  ("symbol", "BTCUSDT");
  ("side", Order_side.wrap BUY);
  ("type", Order_types.wrap MARKET);
  ("quantity", "1.2")
]

let send_order () = 
  let* response = New_order.send ~base_url:base_url ~endpoint:endpoint ~api_key:api_key ~secret_key:secret_key ~order_response:ACK ~parameters:parameters in


  let order_response_size () = let* json = BitcoinOrder.place_order () 
    in let* response = Lwt.return(Ezjsonm.to_string json) 
    in Alcotest.(check bool "Order response length" ((String.length response > 10)) true);
    Lwt.return ();;

let test_order_response_size switch () = 
  Lwt_switch.add_hook (Some switch) order_response_size;Lwt.return ();;

let suite () = "New order", [
    Alcotest_lwt.(test_case "New order of buy test on BTC/USDT pair." `Quick test_order_response_size);
  ];; 