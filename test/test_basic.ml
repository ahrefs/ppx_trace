open Alcotest

module Trace_syntax = struct
  type code_path = {
     file_path : string;
     main_module_name : string;
     submodule_path : string list;
     enclosing_module : string;
     enclosing_value : string option;
     value : string option;
   }

  let span ~name:_ ~code_path:_ ~stdlib_name:_ f = f ()
end

let%span greet name = "Hello, " ^ name ^ "!"

let run () = ()

let test_basic =
   test_case "Functions with different return types" `Quick (fun () ->
       let%span greet name = "Hello, " ^ name ^ "!" in
       let%span add x y = x + y in
       let result = greet "Elliott" ^ " " ^ string_of_int (add 1 2) in
       (check string) "" "Hello, Elliott! 3" result)


let tests = [ ("basic", [ test_basic ]) ]
