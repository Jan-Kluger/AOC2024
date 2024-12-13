module Solution : sig

val calc : filepath:string -> int

end = struct

  let getinput (filepath : string) : unit =
    let chl = open_in filepath in
    let rec print_lines () =
      try 
        let line = input_line chl in
        print_endline line
      with End_of_file ->
        close_in chl;
      in
      print_lines ()

  let calc ~(filepath : string) = 
    getinput filepath;
    1

end

let () = 
  print_endline (string_of_int(Solution.calc ~filepath:"/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day5/conds.txt"))
