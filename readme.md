## Funcionalidades Implementadas 

BTuple 

* Operadores Aritmeticas
Mul<br>
Sub<br>

* Operadores Lógicas
Not<br>
Or<br>

Fst<br>
Snd<br>
* Operadores Relacionais 
BGt<br>
BEq<br>

TokenComa


## Testar as funcionalidades 

Tuplas :<br>
eval (Fst (BTuple (Num 3) (Num 5))) → 3<br>

Mul:<br>
eval (Mul (Num 3) (Num 4)) → Num 12<br>

Sub:<br>
eval (Sub (Num 10) (Num 4)) → Num 6<br>

Not:<br>
eval (Not BTrue) → BFalse<br>
eval (Not BFalse) → BTrue<br>

Or:<br>
eval (Or BTrue BFalse) → BTrue<br>
eval (Or BFalse BFalse) → BFalse<br>

Fst:<br>
eval (Fst (BTuple (Num 3) (Num 5))) → Num 3<br>

Snd:<br>
eval (Snd (BTuple (Num 3) (Num 5))) → Num 5<br>

BGt:<br>
eval (BGt (Num 5) (Num 3)) → BTrue<br>
eval (BGt (Num 2) (Num 4)) → BFalse<br>

BEq:<br>
eval (BEq (Num 5) (Num 5)) → BTrue<br>
eval (BEq (Num 5) (Num 2)) → BFalse<br>
eval (BEq BTrue BFalse) → BFalse<br>
eval (BEq BTrue BTrue) → BTrue<br>