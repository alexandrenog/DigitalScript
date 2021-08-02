# DigitalScript
Uma Linguagem simplificada de Descricao de Hardware Lógico.  
Obs: Não possui recurso para abstração.  
# Como Instalar
Instalar o ruby: https://rubyinstaller.org/ ou  'sudo apt-get install ruby-full' no linux.  
Instalar o ChunkyPng: '[sudo] gem install chunky_png'.  
# Sintaxe
Todo o código pode estar em letras maiusculas ou minusculas. <br />
Sinais de Entrada periódicos: <br />
	Input &lt;nome&gt; &lt;periodo&gt; &lt;duty-cicle&gt; <br />
Sinais de Entrada predefinidos: <br />
	Input_ &lt;nome&gt; &lt;Valor1&gt; &lt;Valor2&gt; &lt;Valor3&gt; &lt;Valor4&gt; ... <br />
Valores: <br />
	1 ou 0 <br />
Expressões: <br />
	Var &lt;nome&gt; &lt;operaçao&gt; &lt;nome1&gt; &lt;nome2&gt; ... <br />
Operações: <br />
	not, and, or, xor, nand, nor <br />
Saídas a desenhar: <br />
	Plot &lt;nome1&gt; &lt;nome2&gt; ... <br />
Tempo auto definido pela máquina como o mínimo múltiplo comum dos periódos dos sinais: <br />
 	Time 0 <br />
Tempo definido <br />
	Time &lt;Valor&gt; <br />
