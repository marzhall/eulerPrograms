open Batteries
module Memo = Map.Make(Int)

(** Take a map of known Collatz lengths and a number to get the number's collatz
 * length *)
let collatz memos n =
    let rec collHelper n len = if Memo.mem n memos then
            len + (Memo.find n memos)
        else
            match n with 
              1 -> len
            | n when n mod 2 == 0 -> collHelper (n / 2) (len + 1)
            | n -> collHelper ((n * 3) + 1) (len + 1) in
    collHelper n 1

let enumerate n = 
    let rec count start accum =
        if start == n then
            n::accum
        else
            count (start+1) (start::accum)
    in
    count 1 []
            
let () = 
    begin
        print_string "This is gonna take a minute, but the longest collatz \
        sequence in the list of numbers from 1 to 1 million is: ";
        match 
        (List.fold_left 
            (fun (memos, longest, len) y -> 
                (* Where memos is a map of known collatz lengths *)
                let collatzed = (collatz memos y) in
                let newMemo = Memo.add y collatzed memos
                in
                if collatzed > len then
                    (newMemo, y, collatzed)
                else
                    (newMemo, longest, len))
        (Memo.empty, 1, 1)
        (enumerate 1000000)) with
        (memos, result, longestLength) -> print_int result;
    end;;
