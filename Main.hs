module Main where 

import Lexer 
import Parser 
import Interpreter
import TypeChecker

-- Para testar o interpretador no Linux é possível rodar:
-- ghci Interpreter.hs  Lexer.hs  Parser.hs 
-- e depois executar os testes com:

-- BeeCrowd 1004 – Produto Simples
--Leia dois valores inteiros. A seguir, calcule o produto entre estes dois valores e atribua esta operação à variável PROD. A seguir mostre a variável PROD com mensagem correspondente.  

-- eval(Mul (Num 3) (Num 9)) -> 27
-- eval(Mul (Num (-30)) (Num 10)) -> -300
-- eval(Mul (Num 0) (Num 9)) -> 0
---------------------------------------------------------------------------
-- BeeCrowd 1007 – Diferença
-- Leia quatro valores inteiros A, B, C e D. A seguir, calcule a diferença do produto de A e B pelo produto de C e D segundo a fórmula: DIFERENCA = (A * B) - (C * D).

--eval(Sub (Mul (Num 5) (Num 6)) (Mul (Num (7)) (Num 8))) -> -26
--eval(Sub (Mul (Num 0) (Num 0)) (Mul (Num (7)) (Num 8))) -> -56
--eval(Sub (Mul (Num 5) (Num 6)) (Mul (Num (-7)) (Num 8))) -> 86

---------------------------------------------------------------------------
-- BeeCrowd 1001 - Extremamente Básico
-- Leia 2 valores inteiros e armazene-os nas variáveis A e B. Efetue a soma de A e B atribuindo o seu resultado na variável X. Imprima X conforme exemplo apresentado abaixo. Não apresente mensagem alguma além daquilo que está sendo especificado e não esqueça de imprimir o fim de linha após o resultado, caso contrário, você receberá "Presentation Error".

-- eval (Add (Fst (BTuple (Num 10) (Num 9))) (Snd (BTuple (Num 10) (Num 9)))) -> 19
-- eval (Add (Fst (BTuple (Num (-10)) (Num 4))) (Snd (BTuple (Num (-10)) (Num 4)))) -> -6
-- eval (Add (Fst (BTuple (Num 15) (Num (-7)))) (Snd (BTuple (Num 15) (Num (-7))))) -> 8



main = getContents >>= print . eval . typecheck . parser . lexer 