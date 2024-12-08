module Solution : sig
  val process_list : string -> int
end = struct
  let read_file (filepath: string) =
    let channel = open_in filepath in
    let rec read_helper (acc : int list list) =
      try
        let line = input_line channel in
        let re = Str.regexp " " in
        let parts = Str.split re line |> List.map int_of_string in
        read_helper (parts :: acc)
      with End_of_file ->
        close_in channel;
        acc
    in
    read_helper []

  let process_list (filepath: string) : int =
    let (data : int list list) = read_file filepath in
    let rec is_valid ?(asc = true) ?(dsc = true) ?(used = false) = function
    | x :: y :: xs -> (
      let diff = x - y in
      match diff with
      | x when x > 0 && abs(x) < 4  -> is_valid ~asc ~dsc:false ~used (y::xs)
      | x when x < 0 && abs(x) < 4  -> is_valid ~asc:false ~dsc ~used (y::xs)
      | _ ->
      if not used then
        let option1 = is_valid ~asc ~dsc ~used:true (x :: xs) in
        let option2 = is_valid ~asc ~dsc ~used:true (y :: xs) in
        if option1 = 1 || option2 = 1 then 1 else 0
      else
        0)
    | _ -> if asc || dsc then 1 else 0
  in
  List.fold_left (fun acc el -> acc + (is_valid el)) 0 data
end

let res = Solution.process_list "/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day2/input.txt"