open Binance_ocaml_api.Spot_account;;
open Lwt.Syntax;;
open Utilities;;

open Variants.Symbol;;
open Variants.Order_side;;
open Variants.Order_types;;
open Variants.Time_in_force;;
open Variants.Order_response;;

module BitcoinOrder = New_order.Make(struct
    let api_key = "YOUR_API_KEY"
    let secret_key = "YOUR_SECRET_KEY"
    let url = Base_urls.api_default
    let symbol = SYMBOL "ICPUSDT"
    let side = BUY
    let order_type = MARKET
    let time_in_force = GTC
    let quantity = 1.0
    let price = 0.0
    let stop_price = 0.0
    let iceberg_quantity = 0.0
    let new_order_response_type = FULL
    let recv_window = 0
  end);; 

let order_response_size () = let* json = BitcoinOrder.place_order () 
  in let* response = Lwt.return(Ezjsonm.to_string json) 
  in Alcotest.(check bool "Order response length" ((String.length response > 10)) true);
  Lwt.return ();;

let test_order_response_size switch () = 
  Lwt_switch.add_hook (Some switch) order_response_size;Lwt.return ();;

let suite () = "New order", [
    Alcotest_lwt.(test_case "New order of buy test on BTC/USDT pair." `Quick test_order_response_size);
  ];; 