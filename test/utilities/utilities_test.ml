open Alcotest;;
module Enpoints = Utilities.Make(struct let api = Utilities.BaseApis.api_default end);;

let test_agg_trades () = check string "agg_trades" Enpoints.agg_trades "https://api.binance.com/api/v3/aggTrades";;
let test_avg_price () = check string "avg_price" Enpoints.avg_price  "https://api.binance.com/api/v3/avgPrice";;
let test_depth () = check string "depth" Enpoints.depth  "https://api.binance.com/api/v3/depth";;
let test_exchage_info () = check string "exchange_info" Enpoints.exchange_info "https://api.binance.com/api/v3/exchangeInfo";;
let test_klines () = check string "klines" Enpoints.klines   "https://api.binance.com/api/v3/klines";;
let test_ping () = check string "ping" Enpoints.ping "https://api.binance.com/api/v3/ping";;
let test_ticker () = check string "ticker" Enpoints.ticker   "https://api.binance.com/api/v3/ticker";;
let test_ticker_24hr () = check string "ticker_24hr" Enpoints.ticker_24hr "https://api.binance.com/api/v3/ticker/24hr";;
let test_ticker_bookTicker () = check string "ticker_bookTicker" Enpoints.ticker_bookTicker   "https://api.binance.com/api/v3/ticker/bookTicker";;
let test_ticker_price () = check string "ticker_price" Enpoints.ticker_price "https://api.binance.com/api/v3/ticker/price";;
let test_time () = check string "time" Enpoints.time "https://api.binance.com/api/v3/time";;
let test_trades () = check string "trades" Enpoints.trades "https://api.binance.com/api/v3/trades";;
let test_ui_klines () = check string "ui_klines" Enpoints.ui_klines "https://api.binance.com/api/v3/uiKlines";;

let suite () = "Enpoints", [
    test_case "Aggregate trades" `Quick test_agg_trades;
    test_case "Average price" `Quick test_avg_price;
    test_case "Depth" `Quick test_depth;
    test_case "Exchange information" `Quick test_exchage_info;
    test_case "Klines" `Quick test_klines;
    test_case "Ping" `Quick test_ping;
    test_case "Ticker" `Quick test_ticker;
    test_case "Ticker 24 hour" `Quick test_ticker_24hr;
    test_case "Book ticker" `Quick test_ticker_bookTicker;
    test_case "Ticker price" `Quick test_ticker_price;
    test_case "Time" `Quick test_time;
    test_case "Trades" `Quick test_trades;
    test_case "UI klines" `Quick test_ui_klines;
  ] ;;