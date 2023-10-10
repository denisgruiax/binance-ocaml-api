val get_list : (Ezjsonm.value -> 'a) -> Ezjsonm.value -> 'a list

val get_list_from_list : ('a -> 'b) -> [> `A of [> `A of 'a] list] -> 'b list