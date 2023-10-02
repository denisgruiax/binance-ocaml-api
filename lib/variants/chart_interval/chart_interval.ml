type t =
  |SECOND of int
  |MINUTE of int
  |HOUR of int
  |DAY of int
  |WEEK of int
  |MONTH of int;;

let wrap = function
  |SECOND 1 -> "1s"
  |MINUTE 1 -> "1m"
  |MINUTE 3 -> "3m"
  |MINUTE 5 -> "5m"
  |MINUTE 15 -> "15m"
  |MINUTE 30 -> "30m"
  |HOUR 1 -> "1h"
  |HOUR 2 -> "2h"
  |HOUR 4 -> "4h"
  |HOUR 6 -> "6h"
  |HOUR 8 -> "8h"
  |HOUR 12 -> "12h"
  |DAY 1 -> "1d"
  |DAY 3 -> "3d"
  |WEEK 1 -> "1w"
  |MONTH 1 -> "1M"
  |_ -> raise Not_found;;

let unwrap = function
  |"1s" -> SECOND 1
  |"1m" -> MINUTE 1
  |"3m" -> MINUTE 3
  |"5m" -> MINUTE 5
  |"15m" -> MINUTE 15
  |"30m" -> MINUTE 30
  |"1h" -> HOUR 1
  |"2h" -> HOUR 2
  |"4h" -> HOUR 4
  |"6h" -> HOUR 6
  |"8h" -> HOUR 8
  |"12h" -> HOUR 12
  |"1d" -> DAY 1
  |"3d" -> DAY 3
  |"1w" -> WEEK 1
  |"1M" -> MONTH 1
  |_ -> raise Not_found;;