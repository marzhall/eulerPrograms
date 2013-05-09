(** Gets the factors of a number, including duplicates - e.g., 24 is [3,2,2,2] *)
let factors number = 
    let rec primeFactors number current listed = 
        if number < current then
            listed
        else
            match (number mod current) with
              0 -> primeFactors (number/current) current (current::listed)
            | _ -> primeFactors number (current + 1) listed
    in primeFactors number 2 []

(** remove the first occurrence of an item in a list *) 
let rec remove lst item = match lst with
      [] -> []
    | (first::rest) -> if first == item then
            rest
        else
            first::(remove rest item)

(** The list of numbers from 2 to 20 *; can be adjusted by modifying the second
 * value in the call to count *)
let divisors =
    let rec count start stop = 
        if start > stop then
            []
        else
            start::(count (start + 1) stop) in
    count 2 20

(** Removes one element in the first list for each of that element that occurs
 * in the second list.
 * passing [2;2;2] and [2;2] will return [2]; 
 * [2;3;2] and [2;2] will return [3];
 * [2;2] [2;3;2] will return []*)
let difference lstOne lstTwo = List.fold_left (fun x y -> remove x y) lstOne lstTwo

let () = 
    let divisorFactors = (List.map factors divisors) in
    let factorsOfResult = List.fold_left (fun x y -> (difference x y) @ y )
        (List.hd divisorFactors) (List.tl divisorFactors)
    in let result = List.fold_left ( * ) 1 factorsOfResult 
    in begin
        print_string "The largest even factor of the numbers 1 through 20 is: ";
        print_int result;
    end
