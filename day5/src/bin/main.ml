module IntMap = Map.Make(Int)

module Solution : sig

val calc : cond_filepath:string -> list_filepath:string -> (int * int) list

end = struct

  let get_cond_input (filepath : string) : 'a IntMap.t =
    let chl = open_in filepath in
    let rec print_lines acc =
      try 
        let line = input_line chl in
        match String.split_on_char '|' line with
        | [l_str; r_str] -> 
            let l = int_of_string l_str in
            let r = int_of_string r_str in
            print_lines ((l,r) :: acc)
        | _ -> 
            failwith "input ill formatted"
      with End_of_file ->
        close_in chl;
        List.rev acc
      in
      (* Add everything to set *)
      let counter = IntMap.empty in
      let conds = print_lines [] in
      List.fold_left (fun acc (l,r) -> IntMap.add l r acc) counter conds

  let get_list_input (filepath : string) = 
    let chl = open_in filepath in
    let rec glines acc =
      try
        let line = input_line chl in
        String.split_on_char ',' line
      with End_of_file ->
        close_in chl;
        []
      in
      glines filepath

  let calc ~(cond_filepath : string) ~(list_filepath : string) = 
    let wut = get_cond_input cond_filepath in
    let wat = get_list_input list_filepath in
    List.rev (IntMap.bindings wut)
end

let res =
  Solution.calc ~cond_filepath:"/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day5/conds.txt" ~list_filepath:"/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day5/input.txt"


