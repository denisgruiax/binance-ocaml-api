module type BaseApis' = sig
  val api_default : string
  val api_gcp : string
  val api1 : string
  val api2 : string
  val api3 : string
  val api4 : string
end

module BaseApis = struct
  let api_default = "https://api.binance.com"
  let api_gcp = "https://api-gcp.binance.com"
  let api1 = "https://api1.binance.com"
  let api2 = "https://api2.binance.com"
  let api3 ="https://api3.binance.com"
  let api4 = "https://api4.binance.com"
end

module type Urls=sig
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

module Endpoints = struct
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

module Make (BaseApi : sig val api : string end):Urls = struct
  let agg_trades = BaseApi.api ^ Endpoints.agg_trades
  let avg_price = BaseApi.api ^ Endpoints.avg_price
  let depth = BaseApi.api ^ Endpoints.depth
  let exchange_info = BaseApi.api ^ Endpoints.exchange_info
  let klines = BaseApi.api ^ Endpoints.klines
  let ping = BaseApi.api ^ Endpoints.ping
  let ticker = BaseApi.api ^ Endpoints.ticker
  let ticker_24hr = BaseApi.api ^ Endpoints.ticker_24hr
  let ticker_bookTicker = BaseApi.api ^ Endpoints.ticker_bookTicker
  let ticker_price = BaseApi.api ^ Endpoints.ticker_price
  let time = BaseApi.api ^ Endpoints.time
  let trades = BaseApi.api ^ Endpoints.trades
  let ui_klines = BaseApi.api ^ Endpoints.ui_klines
end