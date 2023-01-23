open Frontend

(* A variant type for any value created/stored/used in the course of
 * interpreting a Scheme-- program.
 *)
(* TODO: give each constructor the correct OCaml type for its carried data. *)
type valtype =
    | ValueString of string
    | ValueNumber of float
    | ValueBool of bool
    | ValueCode of ast_node
    | ValueNone of unit

(* print_value
 * Print a valtype with a useful representation, followed by a newline.
 *   Strings and numbers should be printed as usual.
 *   Booleans should be printed as "True" or "False".
 *   Code should be printed using the function provided in frontend.ml.
 *   None should be printed as "None".
 *
 * Arguments:
 *  - value: A valtype containing the value to print.
 * Returns:
 *  - Unit (none)
 *)
let print_value (value : valtype) =
    begin
        (* TODO: use pattern matching here to print value based on its constructor type. *)
        match value with
        | ValueString value -> print_string value
        | ValueNumber value -> print_float value
        | ValueBool value -> if value then print_string "True" else print_string "False"
        | ValueCode value -> print_ast value
        | ValueNone value -> print_string "None"
        | _ -> failwith "Invalid"
    end ;
    print_newline ()

(* Creating a Map (what Python calls a "dictionary") to store variable values,
 * mapping variable names (string) to values (valtype).
 *
 * "VarMap" is the class, and "varmap" is the object, essentially.
 *)
module VarMap = Map.Make(String)
(* Create varmap. *)
let varmap = ref VarMap.empty
(* Hack to get varmap to map to value type... there's almost certainly a better way *)
let _ = varmap := VarMap.add "__dummyvar__" (ValueNone ()) !varmap

(* get_var
 * Get the value of a variable stored in varmap.
 * Arguments:
 *  - var: A string containing the variable name to look up.
 * Returns:
 *  - The value (valtype) of the given variable stored in varmap.
 * Crashes with an error if the variable does not exist in the map.
 *)
let get_var (var : string) =
    try
        VarMap.find var !varmap
    with Not_found -> failwith ("Error: Undefined variable " ^ var)

(* set_var
 * Set the value of a variable in varmap.
 * Arguments:
 *  - var: A string containing the variable name to set.
 *  - value: A valtype of the value to store.
 * Returns:
 *  - Nothing.
 *)
let set_var (var : string) (value : valtype) =
    (* Uncomment the following line to get some debug output for every call to set_var. *)
    (* print_string ("Set " ^ var ^ ": ") ; print_value value ; *)
    varmap := VarMap.add var value !varmap


(* float_of_value
 * Convert a ValueNumber to a float.
 * Arguments:
 *  - floatval: A ValueNumber (from the valtype variant)
 *    Uses pattern matching in the parameter, hence deactivating the incomplete match warning (-8)
 * Returns:
 *  - The float value of the given ValueNumber.
 *) 
let[@warning "-8"] float_of_Value (ValueNumber floatval) = floatval


(* check_num_args
 * Check that a given keyword has been given the correct number of arguments.
 * Uses assert to crash if an invalid number of arguments has been given.
 *
 * Arguments:
 *  - kw: A string containing the keyword.
 *  - args: A list of ast_node; the arguments given for that keyword.
 * Returns:
 *  - Nothing.
 *)
let check_num_args (kw : string) (args : ast_node list) =
    (* TODO: assert that the number of arguments is correct for any given keyword. *)
    match kw with
    | "+" | "-" | "*" | "/" | "let" -> assert (List.length args = 2)
    | "<" |">" | "==" -> assert (List.length args = 2)
    | "print" | "lambda" | "call" -> assert (List.length args >= 1)
    | "run" -> assert (List.length args >= 1)
    | "if" -> assert (List.length args >= 3)
    | _ -> failwith "Not a valid keyword"


(* The evaluate* functions are all defined *together* using 'let rec' for the first
 * and 'and' for each later function.  We have to use 'and' here because the functions
 * are *mutually* recursive, meaning they have cyclic dependencies (none can be defined
 * without the others).
 *)


(* evaluate
 * Evaluate a given AST node, returning its value.
 *
 * Arguments:
 *  - node: An ast_node.
 * Returns:
 *  - A valtype containing the value of the given node when evaluated in the
 *    context of the interpreted program.
 *)
let rec evaluate (node : ast_node) =
    (* TODO: Actually this function is complete and correct.
     * However, I wanted to draw your attention to how pattern matching is used
     * here to destructure the expression case.  The pattern there is doing a
     * lot of work!  It's separately extracting the keyword and the arguments,
     * and it is even pulling the keyword *string* value out of the Atom
     * Keyword type it is inside.
     *
     * The atom case is less complex, but it is informative.  Notice how it
     * both matches the Atom constructor *and* extracts the atomtype value from
     * inside the Atom constructor.
     *
     * Pattern matching can do a lot!  (Okay, you can remove this comment once
     * you have read and understood it.  But do understand it first.)
     *)
    match node with
    | Atom x -> evaluate_atom x
    | Expr (Atom (Keyword kw) :: args) -> evaluate_expr kw args
    | _ -> failwith ("Invalid AST node:\n" ^ (string_of_ast node))

(* evaluate_atom
 * Evaluate a given atom, returning its value.
 *
 * Arguments:
 *  - atom: An atomtype (must be Number, String, or Identifier -- not Keyword)
 * Returns:
 *  - A valtype containing the value of the given atom.
 *    Identifiers must be looked up in the varmap structure defined above.
 *)
and evaluate_atom (atom : atomtype) =
    (* TODO: Implement this function.
     *
     * Note: It only works for Number, String, or Identifier, and it must exit
     * with an error (using failwith) for any other type of atom.
     *)
     match atom with
     | Number atom -> ValueNumber atom
     | String atom -> ValueString atom
     | Identifier atom -> get_var atom
     | _ -> failwith "Invalid atom type"


(* evaluate_expr
 * Evaluate a given expression (as a keyword string and a list of ast_node arguments),
 * returning its value.
 *
 * Uses check_num_args to assert that the number of arguments provided is valid
 * in all cases.
 *
 * Uses evaluate_binary_op specifically for any keywords that are binary operators.
 *
 * Arguments:
 *  - kw: A string containing the Scheme-- keyword for this expression (see Assignment 2).
 *  - args: A list of nodes from the AST (with the ast_node type), one for each argument
 *          of the given expression.
 * Returns:
 *  - A valtype containing the value of the given expression after evaluating it in the
 *    context of the interpreted program.
 *)
and evaluate_expr (kw : string) (args : ast_node list) =
    (* TODO: Implement each keyword in the "match kw with" pattern matching.
     *
     * Tips:
     *  1) If you need to write an expression that does multiple things and returns
     *     a final value, use the ';' operator.  For example,
     *
     *         do_something val ; ValueNone ()
     *
     *     will call 'do_something val', and then it will evaluate to the ValueNone value.
     *
     *  2) To "break" a value out of a variant constructor, you can use a let expression
     *     with pattern matching.  It will probably be an incomplete match, though, so
     *     you can suppress the warning from the compiler (which is warning 8) as follows.
     *     In this example, 'var' holds a ValueNumber value, and 'val' ends up holding the
     *     actual float value that the ValueNumber was carrying.
     *
     *         let[@warning "-8"] ValueNumber val = var
     *
     *     I've done one tricky one for you in the "let" case (it had nested types).
     *     Any others should be simpler.
     *
     *  3) Don't forget to send every binary operator expression to evaluate_binary_op!
     *     Remember you can write multiple matches at once by separating them with |.
     *     For example, this matches "A", "B", or "C" and does the same thing in each case:
     *
     *         | "A" | "B" | "C" -> print_string "Yup!"
     *)
    check_num_args kw args ;
    match kw with
    | "let" ->
        let[@warning "-8"] Atom (Identifier varname) = List.hd args in set_var varname (evaluate (List.nth args (((List.length args) - 1))));
        ValueNone ()
    | "+" | "-" | "*" | "/" | ">" | "<" | "==" -> evaluate_binary_op kw args
    | "print" -> print_value (evaluate (List.hd args)); ValueNone ()
    | "lambda" -> ValueCode (List.hd args)
    | "call" -> let[@warning "-8"] ValueCode value = evaluate (List.hd args) in evaluate value
    | "run" -> let [@warning "-8"] list_run = List.map evaluate args in List.nth list_run ((List.length args) - 1)
    | "if" -> let[@warning "-8"] ValueBool first = evaluate (List.hd args) in
                if
                    first then evaluate (List.nth args ((List.length args) - 2))
                else
                    evaluate (List.nth args ((List.length args ) - 1));
    
    | _ -> failwith ("Invalid keyword: " ^ kw)

(* evaluate_binary_op
 * Evaluate a given binary operator expression (as a keyword string and a list
 * of ast_node arguments), returning its value.
 *
 * Arguments:
 *  - kw: A string containing the Scheme-- keyword for this expression (must be a binary operator).
 *  - args: A list of nodes from the AST (with the ast_node type), one for each argument
 *          of the given expression.
 * Returns:
 *  - A valtype containing the value of the given expression after evaluating it in the
 *    context of the interpreted program.
 *)
and evaluate_binary_op (kw : string) (args : ast_node list) =
    match kw with
    | "+" -> ValueNumber((float_of_Value(evaluate (List.hd args))) +. (float_of_Value (evaluate(List.nth args 1))))
    | "-" -> ValueNumber((float_of_Value(evaluate (List.hd args))) -. (float_of_Value (evaluate(List.nth args 1))))
    | "*" -> ValueNumber((float_of_Value(evaluate (List.hd args))) *. (float_of_Value (evaluate(List.nth args 1))))
    | "/" -> ValueNumber((float_of_Value(evaluate (List.hd args))) /. (float_of_Value (evaluate(List.nth args 1))))
    | "<" -> ValueBool (((evaluate (List.hd args))) < ( (evaluate(List.nth args 1))))
    | ">" -> ValueBool(((evaluate (List.hd args))) > ( (evaluate(List.nth args 1))))
    | "==" -> ValueBool(((evaluate (List.hd args))) = ( (evaluate(List.nth args 1))))
    | _ -> failwith "Invalid binary operator"
    (* TODO: Implement this function. You will need to use float_of_Value to convert
     * valtype values to floats to do any arithmetic operations.
     *)
    


(* Main code -- parse, print, and evaluate a program from a file specified on the command line *)
let ast = parse_file Sys.argv.(1)
let _ = print_endline "[33mProgram:[m"
let _ = print_ast ast
let _ = print_endline "[32mOutput:[m"
let _ = evaluate ast

