// Copyright 2013 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// This is an example of a goyacc program.
// To build it:
// goyacc -p "expr" expr.y (produces y.go)
// go build -o expr y.go
// expr
// > <type an expression>

%{

package main

import (

	"fmt"

	"math/big"

)



%}

%union {
	num *big.Rat
}

%type	<num>	expr expr1 expr2 expr3

%token '+' '-' '*' '/' '(' ')'

%token	<num>	NUM



%%

top:
	expr
	{
		if $1.IsInt() {
			fmt.Println("=",$1.Num().String())
			total = total.Add(total,$1.Num())
		} else {
			fmt.Println($1.String())
		}
	}

expr1:
	expr2
|	expr1 '*' expr2
	{
		$$ = $1.Mul($1, $3)
	}


expr2:
	expr3
|	expr2 '+' expr3
	{
		$$ = $1.Add($1, $3)
	}

expr3:
	NUM
|	'(' expr ')'
	{
		$$ = $2
	}


%%
