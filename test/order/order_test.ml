open Alcotest;;

module BitcoinOrder' = struct
  let api_key = "YOUR_BINANCE_API_KEY"
  let secret_key = "YOUR_BINANCE_SECRET_KEY"
  let symbol = "BTCUSDT"
  let side = "BUY"
  let order_type = "LIMIT"
  let time_in_force = "GTC"
  let quantity = "1"
  let price = "25000"
  let recv_window = "5000"
end

module BitcoinOrder = Order.Make(BitcoinOrder');; 

let response = BitcoinOrder.place_order ();;

Printf.printf "Response:\n%s\n" response;;

let order_response_size () = check bool "Order response length" ((String.length response > 10)) true;;

let suite () = "Order", [
    test_case "Order response length" `Quick order_response_size;
  ];; 