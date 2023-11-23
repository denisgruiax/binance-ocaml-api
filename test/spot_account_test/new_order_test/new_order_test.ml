open Binance_ocaml_api.Spot_account;;
open Lwt.Syntax;;
open Variants;;

let api_key = "api_key";;
let secret_key = "secret_key";;
let base_url = Utilities.Base_urls.api_default;;
let endpoint = "/api/v3/order";;

let parameters = [
  ("symbol", "BTCUSDT");
  ("side", Order_side.wrap SELL);
  ("type", Order_types.wrap MARKET);
  ("quantity", "0.1");
  ("newOrderRespType", Order_response.(wrap ACK))
]

let send_order () = 
  let* response = New_order.send ~base_url:base_url ~endpoint:endpoint ~api_key:api_key ~secret_key:secret_key ~parameters:parameters in
  let* () = Records.Response.print response in
  Lwt.return ();;

let test_order_response_size switch () = 
  Lwt_switch.add_hook (Some switch) send_order; Lwt.return ();;

let suite () = "New order", [
    Alcotest_lwt.(test_case "New order of buy test on BTC/USDT pair." `Quick test_order_response_size);
  ];; 