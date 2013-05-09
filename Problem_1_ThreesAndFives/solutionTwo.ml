(** A helper function for listComp; do not call directly *)
let rec compHelper intList ending increment = match intList with [] -> []
    | (lastItem::rest) when lastItem > ending -> rest
    | (lastItem::rest) when lastItem == ending -> intList
    | (lastItem::rest) -> compHelper ((lastItem + increment)::intList) ending increment

(** Take a starting integer, an ending integer, and an increment to create a
 * list of integers - note that this list is returned in reverse order.
 * Passing 3 10 3 will return [9;6;3] *)
let listComp start ending increment = compHelper [start] ending increment

(** Takes two lists in descending order (e.g., [5;4;3] and [3;2;1]) and merges
 * them uniquely, such as [5;4;3;2;1] *)
let rec uniqueMerge listOne listTwo = if listTwo == [] then listOne 
    else match listOne with [] -> listTwo
        | (head::rest) when head > List.hd listTwo -> head::(uniqueMerge rest listTwo)
        | (head::rest) when head == List.hd listTwo -> uniqueMerge listTwo rest 
        | (head::rest) when head < List.hd listTwo -> uniqueMerge listTwo listOne
        | (_::_) -> [] (* make the pattern matcher in the compiler happy *) 

let sum = List.fold_left (+) 0

let () = let threes = listComp 3 999 3 in
    let fives = listComp 5 999 5 in
    let total = sum (uniqueMerge threes fives) in
    begin
        print_int total;
    end;;
