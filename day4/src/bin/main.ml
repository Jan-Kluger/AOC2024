module Solution : sig
  val calc : string -> int
end = struct

  let puzzle_to_array (lines : string list) : char array array =
    Array.of_list (List.map Array.of_seq (List.map String.to_seq lines))

  let directions =
    [ (-1, -1); (-1, 0); (-1, 1);
      (0, -1);           (0, 1);
      (1, -1);  (1, 0);  (1, 1) ]

  let in_bounds grid r c =
    r >= 0 && c >= 0 && r < Array.length grid && c < Array.length grid.(0)

  let check_xmas grid row col dr dc =
    let word = "XMAS" in
    let len = String.length word in
    let rec loop i =
      if i = len then 1
      else
        let r = row + i * dr in
        let c = col + i * dc in
        if not (in_bounds grid r c) || grid.(r).(c) <> word.[i] then 0
        else loop (i + 1)
    in
    loop 0

  let count_xmas grid =
    let rows = Array.length grid in
    let cols = Array.length grid.(0) in
    let total = ref 0 in
    for r = 0 to rows - 1 do
      for c = 0 to cols - 1 do
        List.iter (fun (dr, dc) ->
          total := !total + check_xmas grid r c dr dc
        ) directions
      done
    done;
    !total

  let read_puzzle file_path =
    let rec read_lines acc chan =
      try
        let line = input_line chan in
        read_lines (line :: acc) chan
      with End_of_file -> List.rev acc
    in
    let chan = open_in file_path in
    let lines = read_lines [] chan in
    close_in chan;
    lines

  let calc file_path =
    let puzzle = read_puzzle file_path in
    let grid = puzzle_to_array puzzle in
    count_xmas grid

end

let () =
  let file_path = "/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day4/src/input.txt" in
  let res = Solution.calc file_path in
  Printf.printf "Number of occurrences of XMAS: %d\n" res
