open Lib;;

module P : Price.Pair = struct
  let pair = ""
  let get_price = 0.0
end;;

Printf.printf "%s %0.2f\n" P.pair;;

module X = Price.UpdateSymbol(P)(struct let pair = "SOLUSDT" end);;

Printf.printf "Pair: %s, Price: %0.2f\n" X.pair X.get_price;;