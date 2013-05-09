let largestPF number = 
    let rec primeFactor number biggest current = 
        if number < current then
            biggest
        else
            match (number mod current) with
              0 -> primeFactor (number/current) current current
            | _ -> primeFactor number biggest (current + 1)
    in primeFactor number 1 2

let () = 
    begin
        print_string "The largest prime factor of 600851475143 is: (drumroll please...)\n";
        print_int (largestPF 600851475143);
    end
