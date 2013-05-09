(** The list of ints from 3 to 999 *)
let allInts =
    let rec count start stop = 
        if start > stop then
            []
        else
            start::(count (start + 1) stop) in
    count 3 999

let sum = List.fold_left (+) 0

let () = 
    let total = sum (List.filter (fun x -> x mod 3 == 0 || x mod 5 == 0) allInts) in
    begin
        print_string "The sum of all the multiples of 3 and 5 up to 1000 is: ";
        print_int total;
    end;;
                  
