require_relative 'DigitalScript'
logic %{
Time 0
Input D 13 7
Input CLK 11 7
Var Db NOT D
Var N1 NAND D CLK
Var N2 NAND Db CLK
Var Q NAND N1 Qb
Var Qb NAND N2 Q
Plot D CLK Q
}
run "flip_flop_d"