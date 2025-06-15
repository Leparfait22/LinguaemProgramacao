module Interpreter where 

import Lexer 

isValue :: Expr -> Bool 
isValue BTrue       = True 
isValue BFalse      = True  
isValue (Num _)     = True 
isValue (Lam _ _ _) = True
isValue (BTuple e1 e2) = isValue e1 && isValue e2
isValue _           = False 

subst :: String -> Expr -> Expr -> Expr
subst v e BTrue = BTrue 
subst v e BFalse = BFalse 
subst v e (Num x) = Num x 
subst v e (Add e1 e2) = Add (subst v e e1) (subst v e e2)
subst v e (And e1 e2) = And (subst v e e1) (subst v e e2)
subst v e (Mul e1 e2) = Mul (subst v e e1) (subst v e e2)
subst v e (BEq e1 e2) = BEq (subst v e e1) (subst v e e2)
subst v e (If e1 e2 e3) = If (subst v e e1) (subst v e e2) (subst v e e3)
subst v e (Var x) = if v == x then e else Var x 
subst v e (Lam x t b) = Lam x t (subst v e b)
subst v e (App e1 e2) = App (subst v e e1) (subst v e e2)
subst v e (Paren e1) = Paren (subst v e e1)
subst v e (BTuple e1 e2) = BTuple (subst v e e1) (subst v e e2)
subst v e (Fst e1) = Fst (subst v e e1)
subst v e (Snd e1) = Snd (subst v e e1)

step :: Expr -> Expr 
step (Add (Num n1) (Num n2)) = Num (n1 + n2)
step (Add (Num n1) e2) = Add (Num n1) (step e2)
step (Add e1 e2) = Add (step e1) e2 

step (Sub (Num n1) (Num n2)) = Num (n1 - n2)
step (Sub (Num n1) e2) = Sub (Num n1) (step e2)
step (Sub e1 e2) = Sub (step e1) e2

step (And BTrue e2) = e2 
step (And BFalse _) = BFalse 
step (And e1 e2) = And (step e1) e2 

step (Not BTrue) = BFalse
step (Not BFalse) = BTrue
step (Not e) = Not (step e)

step (Or BFalse e2) = e2
step (Or BTrue e2) = BTrue
step (Or e1 e2) = Or (step e1) e2

step (Mul (Num n1) (Num n2)) = Num (n1 * n2)
step (Mul (Num n1) e2) = Mul (Num n1) (step e2)
step (Mul e1 e2) = Mul (step e1) e2

step (BEq v1 v2)
  | isValue v1 && isValue v2 = if v1 == v2 then BTrue else BFalse
  | not (isValue v1) = BEq (step v1) v2
  | otherwise = BEq v1 (step v2)

step (BGt (Num n1) (Num n2)) = if n1 > n2 then BTrue else BFalse
step (BGt v1 v2)
  | not (isValue v1) = BGt (step v1) v2
  | otherwise        = BGt v1 (step v2)

step (If BTrue e1 _) = e1 
step (If BFalse _ e2) = e2
step (If e e1 e2) = If (step e) e1 e2 

step (App e1@(Lam x t b) e2) | isValue e2 = subst x e2 b
                             | otherwise  = App e1 (step e2)
step (App e1 e2) = App (step e1) e2 

step (Paren e) = e 

step (BTuple e1 e2)
  | not (isValue e1) = BTuple (step e1) e2
  | not (isValue e2) = BTuple e1 (step e2)
  | otherwise        = BTuple e1 e2

step (Fst (BTuple e1 e2))
  | isValue e1 && isValue e2 = e1
  | otherwise = Fst (step (BTuple e1 e2))
step (Fst e) = Fst (step e)

step (Snd (BTuple e1 e2))
  | isValue e1 && isValue e2 = e2
  | otherwise = Snd (step (BTuple e1 e2))
step (Snd e) = Snd (step e)

eval :: Expr -> Expr 
eval e | isValue e = e 
       | otherwise = eval (step e)
