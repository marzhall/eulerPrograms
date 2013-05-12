let collatz  n =
    let rec collHelper n len = match n with 
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
            (fun (longest, len) y -> 
                let collatzed = (collatz y) in
                if (collatzed) > len then
                    (y, collatzed)
                else
                    (longest, len))
        (1, 1)
        (enumerate 1000000)) with
        (result, longestLength) -> print_int result;
    end;;
