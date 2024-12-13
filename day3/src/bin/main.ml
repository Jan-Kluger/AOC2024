module Solution : sig
  val calc : string -> int
end = struct

  (* let read_file (file_path : string) : (int * int) list =
    let channel = open_in file_path in
    let re = Str.regexp "mul(\\([0-9]+\\),\\([0-9]+\\))" in

    let rec read_and_accumulate (acc : (int * int) list) =
      try
        let line = input_line channel in

        let pos = ref 0 in
        let rec search_line (acc_inner : (int * int) list) =
          if Str.string_match re line !pos then
            let num1 = int_of_string (Str.matched_group 1 line) in
            let num2 = int_of_string (Str.matched_group 2 line) in
            pos := Str.match_end (); 
            search_line ((num1, num2) :: acc_inner)
          else if !pos < String.length line then
            (incr pos; search_line acc_inner)
          else
            acc_inner
        in

        let new_acc = search_line acc in
        read_and_accumulate new_acc
      with End_of_file ->
        close_in channel;
        List.rev acc
    in
    read_and_accumulate [] *)

    let read_file (file_path : string) : (int * int) list =
      let channel = open_in file_path in
      let re_mul = Str.regexp "mul(\\([0-9]+\\),\\([0-9]+\\))" in
      let re_do = Str.regexp "do()" in
      let re_dont = Str.regexp "don't()" in
      let rec read_and_accumulate acc enabled =
        try
          let line = input_line channel in
          let pos = ref 0 in
          let rec search_line acc_inner enabled_inner =
            if !pos >= String.length line then
              (acc_inner, enabled_inner)
            else if Str.string_match re_mul line !pos then
              let n1 = int_of_string (Str.matched_group 1 line) in
              let n2 = int_of_string (Str.matched_group 2 line) in
              pos := Str.match_end ();
              let new_acc = if enabled_inner then (n1, n2)::acc_inner else acc_inner in
              search_line new_acc enabled_inner
            else if Str.string_match re_do line !pos then
              (pos := Str.match_end (); search_line acc_inner true)
            else if Str.string_match re_dont line !pos then
              (pos := Str.match_end (); search_line acc_inner false)
            else
              (incr pos; search_line acc_inner enabled_inner)
          in
          let new_acc, new_enabled = search_line acc enabled in
          read_and_accumulate new_acc new_enabled
        with End_of_file ->
          close_in channel;
          List.rev acc
      in
      read_and_accumulate [] true

  let calc (file_path : string) = 
    let es = read_file file_path in
    List.fold_left (fun acc (e1, e2) -> acc + (e1 * e2)) 0 es

end
let () =
  let res = Solution.calc "/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day3/src/bin/input.txt" in
  print_endline (string_of_int res)