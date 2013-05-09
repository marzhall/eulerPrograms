let sum = List.fold_left (+) 0

(** remove the first occurrence of an item in a list *) 
let rec remove lst item = match lst with
      [] -> []
    | (first::rest) -> if first == item then
            rest
        else
            first::(remove rest item)

(** Take a starting integer, an ending integer, and an increment to create a
 * list of integers. Passing 3 10 3 will return [3;6;9]; passing 10 3 (-3) 
 * will give [7;4;1] *)
let listComp start ending increment =
    let rec compHelper comparison intList = match intList with [] -> []
        | (lastItem::rest) when comparison lastItem ending -> rest
        | (lastItem::rest) when lastItem == ending -> intList
        | (lastItem::rest) -> compHelper comparison ((lastItem + increment)::intList)
    in
    match increment with 0 -> [start]
    | inc when inc > 0 -> List.rev(compHelper (>) [start])
    | inc when inc < 0 -> List.rev(compHelper (<) [start])
    | _ -> []

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

(** Takes a number and creates a list of the elements. 1234 becomes [1;2;3;4] *)
let listNum n = 
    let sum = (List.fold_left (+) 0) in
    let rec listNumber number power finished = if number < power then
        (((number mod power) - (sum finished))/(power /10))::finished
    else
        listNumber number (power * 10) ( (((number mod power) - (sum finished))/(power / 10))::finished) in
    listNumber n 10 []

(* The main recursion here loops through the factors of a number, trying to combine
 * the first factor with each remaining factor to form a three-digit number
 * until it has exhusted the list. If there is still more than one factor left, 
 * it tries to combine the second factor with the remaining factors in the list
 * to create a three-digit number, and so on. 
 *
 * Note: Normally I would consult the internet when my code becomes this compilcated
 * for a cleaner solution. **)
let hasTwoThreeDigitFactors num = 
    let hasThreeDigits n = List.length (listNum n) == 3 in
    let rec compressFactors lst current index = 
        if (index >= List.length lst) && current == (List.length lst) then
            lst (* We've gone through the list and compressed as much as we can *)
        else
            if not (index >= List.length lst) then
                let newDivisor = (List.nth lst current) * (List.nth lst index) in
                if List.length (listNum newDivisor) <= 3 then
                    let prunedList = remove (remove lst (List.nth lst
                        current)) (List.nth lst index) in
                    compressFactors (newDivisor::prunedList) current (current + 1)
                else
                    compressFactors lst current (index + 1) (* try the next factor*)
            else (* if we've run through all of the remaining factors and
                    cannot compress this factor further *)
                compressFactors lst (current + 1) (current + 2) in
    let compressedFactors = compressFactors (factors num) 1 2 in
    (List.length compressedFactors == 2) && (List.fold_left (fun x y -> x && hasThreeDigits y) 
        true compressedFactors)

(** Takes a list and pairs it with its reverse, checking if each member matches
 * the member it's paired with; e,g, [1;2;3] goes to [(1,3); (2, 2); (3, 1)] and
 * fails, [1;2;1] goes to [(1,1); (2,2,); (1,1);] and passes *)
let isPalindrome lst =
    let pairs = List.combine lst (List.rev lst) in
    List.fold_left (fun x (first, second) -> x && (first == second)) true pairs 

let () =
    let maxMultipleOfThree = 998001 and minMultipleOfThree = 10000 in
    let possibilities = (listComp maxMultipleOfThree minMultipleOfThree (-1)) in
    let palindromesOnly = List.filter (fun x -> isPalindrome (listNum x)) possibilities in
    let result = List.hd (List.filter (fun x -> hasTwoThreeDigitFactors x) palindromesOnly) in
    begin
        print_string "After much thought, the highest palindrom composed of two\
 three-digit numbers is: ";
        print_int result;
    end
