# DigitalScript
Uma Linguagem simplificada de Descricao de Hardware Lógico.  
Obs: Não possui recurso para abstração.  
# Como Instalar
Instalar o ruby: https://rubyinstaller.org/ ou  'sudo apt-get install ruby-full' no linux.  
Instalar o ChunkyPng: '[sudo] gem install chunky_png'.  
# Sintaxe
Todo o código pode estar em letras maiusculas ou minusculas.
Sinais de Entrada periódicos:
	Input <nome> <periodo> <duty-cicle>
Sinais de Entrada predefinidos:
	Input_ <nome> <Valor1> <Valor2> <Valor3> <Valor4> ...
Valores:
	1 ou 0
Expressões:
	Var <nome> <operaçao> <nome1> <nome2> ...
Operações:
	not, and, or, xor, nand, nor
Saídas a desenhar:
	Plot <nome1> <nome2> ...
Tempo auto definido pela máquina como o mínimo múltiplo comum dos periódos dos sinais:
 	Time 0
Tempo definido
	Time <Valor>
