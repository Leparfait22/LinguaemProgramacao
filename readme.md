## FUncionalidades Implementadas 

BTuple 

--Operadores Aritmeticas
Mul
Sub
--Operadores Lógicas
Not
Or

Fst
Snd
--Operadores Relacionais 
BGt
BEq

TokenComa


## Testar as funcionalidades 

Tuplas :
eval (Fst (BTuple (Num 3) (Num 5))) → 3

Mul:
eval (Mul (Num 3) (Num 4)) → Num 12

Sub:
eval (Sub (Num 10) (Num 4)) → Num 6

Not:
eval (Not BTrue) → BFalse

eval (Not BFalse) → BTrue
Or:
eval (Or BTrue BFalse) → BTrue

eval (Or BFalse BFalse) → BFalse

Fst:
eval (Fst (BTuple (Num 3) (Num 5))) → Num 3

Snd:
eval (Snd (BTuple (Num 3) (Num 5))) → Num 5

BGt:
eval (BGt (Num 5) (Num 3)) → BTrue

eval (BGt (Num 2) (Num 4)) → BFalse

BEq:
eval (BEq (Num 5) (Num 5)) → BTrue

eval (BEq (Num 5) (Num 2)) → BFalse

eval (BEq BTrue BFalse) → BFalse

eval (BEq BTrue BTrue) → BTrue