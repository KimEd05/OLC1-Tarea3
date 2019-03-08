package tarea3.analizadores;

import java_cup.runtime.Symbol;
import java.util.LinkedList;
import tarea3.Token;
import tarea3.TokenError;

%% 

%{
    public static LinkedList<Token> tablaSimbolos = new LinkedList<Token>();
    public static LinkedList<TokenError> tablaErrores = new LinkedList<TokenError>();
%}

/* Directivas */
%cupsym sym 
%class Scanner
%cup
%public
%full
%8bit
%unicode
%line
%column
%char
%ignorecase

/* Expresiones regulares */
blanco = [ |\t|\n|\f|\r]+
cadena = [\"] [^\"]* [\"]

%%

/* Caracteres */
"("                 { tablaSimbolos.add(new Token(0, yytext(), yyline, yycolumn));
                      return new Symbol(sym.para, yyline, yycolumn, yytext()); }
")"                 { tablaSimbolos.add(new Token(1, yytext(), yyline, yycolumn));
                      return new Symbol(sym.parc, yyline, yycolumn, yytext()); }
"."                 { tablaSimbolos.add(new Token(2, yytext(), yyline, yycolumn));
                      return new Symbol(sym.punto, yyline, yycolumn, yytext()); }
";"                 { tablaSimbolos.add(new Token(3, yytext(), yyline, yycolumn));
                      return new Symbol(sym.puntoycoma, yyline, yycolumn, yytext()); }

/* Palabras reservadas */ 
"imprimir"          { tablaSimbolos.add(new Token(4, yytext(), yyline, yycolumn));
                      return new Symbol(sym.imprimir, yyline, yycolumn, yytext()); }

/* Elementos léxicos */
{cadena}            { tablaSimbolos.add(new Token(5, yytext(), yyline, yycolumn));
                      return new Symbol(sym.cadena, yyline, yycolumn, yytext()); }
{blanco}            { /*Ignore case*/ }

/* Errores */
.                   { tablaErrores.add(new TokenError(yytext(), yyline, yycolumn, "Léxico", "Elemento Léxico desconocido"));
                      System.err.println("Elemento léxico desconocido: " + yytext() + ", Línea: " + (yyline + 1) + ", Columna: " + (yycolumn + 1)); }
