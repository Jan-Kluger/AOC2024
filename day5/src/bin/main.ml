module IntMap = Map.Make(Int)

module Solution : sig

val calc : cond_filepath:string -> list_filepath:string -> int

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

  let get_list_input (filepath : string) : int list list = 
    let chl = open_in filepath in
    let rec glines acc =
      try
        let line = input_line chl in
        let elements = List.map (fun s -> int_of_string s) (String.split_on_char ',' line) in
        glines (elements :: acc)
      with End_of_file ->
        close_in chl;
        acc
      in
      glines []

  let check_list (list : int list) (conds : 'a IntMap.t) : int =
    let to_return = List.nth list ((List.length list)/2) in
    let rec chelper elements inserted =
      match elements with
      | x :: xs -> (
        let succ = IntMap.find_opt x inserted in
        match succ with
        | Some _ -> 0
        | None -> 
          let newmap = IntMap.add x 1 inserted in
          chelper xs newmap
      )
      | [] -> to_return
    in
    chelper list IntMap.empty

  let calc ~(cond_filepath : string) ~(list_filepath : string) = 
    let conds = get_cond_input cond_filepath in
    let list_i = get_list_input list_filepath in
    let rec check_valid es res = 
      match es with
      | x :: xs -> (
        check_valid xs res + (check_list x conds)
      )
      | [] -> res
    in
    check_valid list_i 1

end

let cf = "/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day5/conds.txt"
let lf = "/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day5/input.txt"

let res =
  Solution.calc ~cond_filepath:cf ~list_filepath:lf


