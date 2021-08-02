# DigitalScript
Uma Linguagem simplificada de Descricao de Hardware Lógico.  
Obs: Não possui recurso para abstração.  
# Como Instalar
Instalar o ruby: https://rubyinstaller.org/ ou  'sudo apt-get install ruby-full' no linux.  
Instalar o ChunkyPng: '[sudo] gem install chunky_png'.  
# Sintaxe
Todo o código pode estar em letras maiusculas ou minusculas. <br />
Sinais de Entrada periódicos: <br />
&emsp;	Input <b>nome</b> <b>periodo</b> <b>duty-cicle</b> <br />
Sinais de Entrada predefinidos: <br />
&emsp;	Input_ <b>nome</b> <b>Valor1</b> <b>Valor2</b> <b>Valor3</b> <b>Valor4</b> ... <br />
Valores: <br />
&emsp;	1 ou 0 <br />
Expressões: <br />
&emsp;	Var <b>nome</b> <b>operaçao</b> <b>nome1</b> <b>nome2</b> ... <br />
Operações: <br />
&emsp;	not, and, or, xor, nand, nor <br />
Saídas a desenhar: <br />
&emsp;	Plot <b>nome1</b> <b>nome2</b> ... <br />
Tempo auto definido pela máquina como o mínimo múltiplo comum dos periódos dos sinais: <br />
&emsp; 	Time 0 <br />
Tempo predefinido <br />
&emsp;	Time <b>Valor</b> <br />
