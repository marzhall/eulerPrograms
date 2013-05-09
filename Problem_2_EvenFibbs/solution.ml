let fibb stop = 
    let rec fibblist n x stop = if n > stop then
            [] 
        else
            (n::(fibblist x (n+x) stop))
    in
    fibblist 1 1 stop

let sum = List.fold_left (+) 0

let () = 
    let evenFibbs = List.filter (fun x -> x mod 2 == 0) (fibb 4000001) in
    let result = sum evenFibbs in
    begin
        print_string "The sum of the even fibbonacci numbers up to 4 million is ";
        print_int result;
    end
