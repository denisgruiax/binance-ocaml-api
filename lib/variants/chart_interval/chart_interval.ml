type t =
  |Second of int
  |Minute of int
  |Hour of int
  |Day of int
  |Week of int
  |Month of int;;

let wrap = function
  |Second 1 -> "1s"
  |Minute 1 -> "1m"
  |Minute 3 -> "3m"
  |Minute 5 -> "5m"
  |Minute 15 -> "15m"
  |Minute 30 -> "30m"
  |Hour 1 -> "1h"
  |Hour 2 -> "2h"
  |Hour 4 -> "4h"
  |Hour 6 -> "6h"
  |Hour 8 -> "8h"
  |Hour 12 -> "12h"
  |Day 1 -> "1d"
  |Day 3 -> "3d"
  |Week 1 -> "1w"
  |Month 1 -> "1M"
  |_ -> raise Not_found;;

let unwrap = function
  |"1s" -> Second 1
  |"1m" -> Minute 1
  |"3m" -> Minute 3
  |"5m" -> Minute 5
  |"15m" -> Minute 15
  |"30m" -> Minute 30
  |"1h" -> Hour 1
  |"2h" -> Hour 2
  |"4h" -> Hour 4
  |"6h" -> Hour 6
  |"8h" -> Hour 8
  |"12h" -> Hour 12
  |"1d" -> Day 1
  |"3d" -> Day 3
  |"1w" -> Week 1
  |"1M" -> Month 1
  |_ -> raise Not_found;;