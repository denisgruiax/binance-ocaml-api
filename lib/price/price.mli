module type Pair = sig val pair : string val get_price : float end
module UpdateSymbol :
  functor (Price : Pair) (Symbol : sig val pair : string end) ->
  sig 
    val pair : string
    val get_price : float
  end
