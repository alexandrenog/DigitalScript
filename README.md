# DigitalScript
Uma Linguagem simplificada de Descricao de Hardware Lógico.  
Obs: Não possui recurso para abstração.  
# Como Instalar
Instalar o ruby: https://rubyinstaller.org/ ou  'sudo apt-get install ruby-full' no linux.  
Instalar o ChunkyPng: '[sudo] gem install chunky_png'.  
# Sintaxe
Todo o código pode estar em letras maiusculas ou minusculas. <br />
Sinais de Entrada periódicos: <br />
	Input <nome> <periodo> <duty-cicle> <br />
Sinais de Entrada predefinidos: <br />
	Input_ <nome> <Valor1> <Valor2> <Valor3> <Valor4> ... <br />
Valores: <br />
	1 ou 0 <br />
Expressões: <br />
	Var <nome> <operaçao> <nome1> <nome2> ... <br />
Operações: <br />
	not, and, or, xor, nand, nor <br />
Saídas a desenhar: <br />
	Plot <nome1> <nome2> ... <br />
Tempo auto definido pela máquina como o mínimo múltiplo comum dos periódos dos sinais: <br />
 	Time 0 <br />
Tempo definido <br />
	Time <Valor> <br />
