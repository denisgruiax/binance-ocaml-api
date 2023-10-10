let get_list get_data (data:Ezjsonm.value) = 
  let rec get_list' data acc = match data with
    |`A( head :: tail) -> get_list' (`A tail) ((get_data head) :: acc)
    |_ -> List.rev acc
  in get_list' data [];;

let get_list_from_list get_data data = let rec get_list_of_data' data acc = match data with
    |`A(`A head :: tail) -> get_list_of_data' (`A tail) (get_data head :: acc) 
    |_ -> List.rev acc
  in get_list_of_data' data [];;