{
module Parser where 

import Lexer
}

%name parser 
%tokentype { Token }
%error { parseError }

%token 
    num             { TokenNum $$ }
    true            { TokenTrue }
    false           { TokenFalse }
    '+'             { TokenAdd }
    '-'             { TokenSub }
    "&&"            { TokenAnd }
    '*'             { TokenMul }
    "=="            { TokenEq }
    '>'             { TokenGt }
    not             { TokenNot }
    "or"            { TokenOr }
    if              { TokenIf }
    then            { TokenThen }
    else            { TokenElse }
    var             { TokenVar $$ }
    '\\'            { TokenLam }
    ':'             { TokenColon }
    "->"            { TokenArrow }
    Number          { TokenTNum }
    Boolean         { TokenTBool }
    '('             { TokenLParen }
    ')'             { TokenRParen }
    ','             { TokenComma }   
    Fst             { TokenFst }
    Snd             { TokenSnd }

%nonassoc if then else 
%nonassoc '\\' 
%left '*'
%left "&&"
%left "=="
%left '>'
%left '+' '-'
%right not
%left "or"

%% 

Exp     : num                           { Num $1 }
        | true                          { BTrue }
        | false                         { BFalse }
        | Exp '+' Exp                   { Add $1 $3 }
        | not Exp                       { Not $2 }
        | Exp "or" Exp                  { Or $1 $3 }
        | Exp '-' Exp                   { Sub $1 $3 }
        | Exp '*' Exp                   { Mul $1 $3 }
        | Exp "&&" Exp                  { And $1 $3 }
        | Exp "==" Exp                  { BEq $1 $3 }
        | Exp '>' Exp                   { BGt $1 $3 }
        | if Exp then Exp else Exp      { If $2 $4 $6 }
        | var                           { Var $1 }
        | '\\' var ':' Type "->" Exp    { Lam $2 $4 $6 }
        | Exp Exp                       { App $1 $2 }
        | '(' Exp ',' Exp ')'           { BTuple $2 $4 }  
        | '(' Exp ')'                   { Paren $2 }
        | Fst Exp                       { Fst $2 }
        | Snd Exp                       { Snd $2 }

Type    : Boolean                       { TBool }
        | Number                        { TNum }
        | '(' Type "->" Type ')'        { TFun $2 $4 }

{ 

parseError :: [Token] -> a 
parseError _ = error "Erro sintático!"

}
