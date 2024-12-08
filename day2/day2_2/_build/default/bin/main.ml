module Solution : sig
  val read_file : string -> unit
  val process_list : int list -> int
end = struct
  let read_file (filepath: string) =
    let channel = open_in filepath in
    let rec read_helper () =
      try
        let line = input_line channel in
        let re = Str.regexp "[ ]" in

        print_endline line;
        read_helper ()
      with End_of_file ->
        close_in channel
    in
    read_helper ()

    let process_list = 
      failwith "TODO"
end


let () =
  Solution.read_file "/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day2/input.txt"
