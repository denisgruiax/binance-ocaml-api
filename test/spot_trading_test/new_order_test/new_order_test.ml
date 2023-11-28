open Binance_ocaml_api.Spot_trading;;
open Lwt.Syntax;;
open Variants;;

let api_key = "API_KEY";;
let secret_key = "SECRET_KEY";;
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
  let* response_result = New_order.send ~base_url:base_url ~endpoint:endpoint ~api_key:api_key ~secret_key:secret_key ~parameters:parameters in
  let* is_error_result = Lwt.return (Result.is_error response_result) in
  let* error = Lwt.return (if is_error_result then Result.get_error response_result else failwith "Invalid response result") in
  Alcotest.(check int "Verify code for not enough balance" 0 Decimal.(compare (of_int (-1001)) error.code)); Lwt.return ();;

let test_order_response_size switch () = 
  Lwt_switch.add_hook (Some switch) send_order; Lwt.return ();;

let suite () = "New order", [
    Alcotest_lwt.(test_case "New order of buy test on BTC/USDT pair." `Quick test_order_response_size);
  ];;