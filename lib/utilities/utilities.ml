module type BaseApis' = sig
  val api_default : string
  val api_gcp : string
  val api1 : string
  val api2 : string
  val api3 : string
  val pai4 : string
end

module BaseApis = struct
  let api_default = "https://api.binance.com"
  let api_gcp = "https://api-gcp.binance.com"
  let api1 = "https://api1.binance.com"
  let api2 = "https://api2.binance.com"
  let api3 ="https://api3.binance.com"
  let pai4 = "https://api4.binance.com"
end

module type Endpoints=sig
  val agg_trades : string
  val avg_price : string
  val depth : string
  val exchange_info : string
  val klines : string
  val ping : string
  val ticker : string
  val ticker_24hr : string
  val ticker_bookTicker : string
  val ticker_price : string
  val time : string
  val trades : string
  val ui_klines : string
end

module EndApis = struct
  let agg_trades = "/api/v3/aggTrades"
  let avg_price = "/api/v3/avgPrice"
  let depth = "/api/v3/depth"
  let exchange_info = "/api/v3/exchangeInfo"
  let klines = "/api/v3/klines"
  let ping = "/api/v3/ping"
  let ticker = "/api/v3/ticker"
  let ticker_24hr = "/api/v3/ticker/24hr"
  let ticker_bookTicker = "/api/v3/ticker/bookTicker"
  let ticker_price = "/api/v3/ticker/price"
  let time = "/api/v3/time"
  let trades = "/api/v3/trades"
  let ui_klines = "/api/v3/uiKlines"
end;;

module Make (BaseApi : sig val api : string end):Endpoints = struct
  let agg_trades = BaseApi.api ^ EndApis.agg_trades
  let avg_price = BaseApi.api ^ EndApis.avg_price
  let depth = BaseApi.api ^ EndApis.depth
  let exchange_info = BaseApi.api ^ EndApis.exchange_info
  let klines = BaseApi.api ^ EndApis.klines
  let ping = BaseApi.api ^ EndApis.ping
  let ticker = BaseApi.api ^ EndApis.ticker
  let ticker_24hr = BaseApi.api ^ EndApis.ticker_24hr
  let ticker_bookTicker = BaseApi.api ^ EndApis.ticker_bookTicker
  let ticker_price = BaseApi.api ^ EndApis.ticker_price
  let time = BaseApi.api ^ EndApis.time
  let trades = BaseApi.api ^ EndApis.trades
  let ui_klines = BaseApi.api ^ EndApis.ui_klines
end