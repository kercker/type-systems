open Expr
open Infer


let core =
	let declaration_list = [
			"head : forall[a] list[a] -> a" ;
			"tail : forall[a] list[a] -> list[a]" ;
			"nil : forall[a] list[a]" ;
			"single : forall[a] a -> list[a]" ;
			"cons : forall[a] (a, list[a]) -> list[a]" ;
			"cons_curry : forall[a] a -> list[a] -> list[a]" ;
			"map : forall[a b] (a -> b, list[a]) -> list[b]" ;
			"map_curry : forall[a b] (a -> b) -> list[a] -> list[b]" ;
			"one : int" ;
			"zero : int" ;
			"succ : int -> int" ;
			"plus : (int, int) -> int" ;
			"eq : forall[a] (a, a) -> bool" ;
			"eq_curry : forall[a] a -> a -> bool" ;
			"not : bool -> bool" ;
			"true : bool" ;
			"false : bool" ;
			"pair : forall[a b] (a, b) -> pair[a, b]" ;
			"pair_curry : forall[a b] a -> b -> pair[a, b]" ;
			"first : forall[a b] pair[a, b] -> a" ;
			"second : forall[a b] pair[a, b] -> b" ;
			"id : forall[a] a -> a" ;
			"const : forall[a b] a -> b -> a" ;
			"apply : forall[a b] (a -> b, a) -> b" ;
			"apply_curry : forall[a b] (a -> b) -> a -> b" ;
			"rev_apply : forall[a b] (a, a -> b) -> b" ;
			"rev_apply_curry : forall[a b] a -> (a -> b) -> b" ;
			"choose : forall[a] (a, a) -> a" ;
			"choose_curry : forall[a] a -> a -> a" ;
			"ids : list[forall[a] a -> a]" ;
			"poly : (forall[a] a -> a) -> pair[int, bool]" ;
		]
	in
	List.fold_left
		(fun env declaration_str ->
			let expr = Parser.expr_eof Lexer.token (Lexing.from_string declaration_str) in
			match expr with
				| Ann(Var name, ([], ty)) -> Env.extend env name ty
				| _ -> raise (Failure "expected a variable annotated by a complete type"))
		Env.empty declaration_list
