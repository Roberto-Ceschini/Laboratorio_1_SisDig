library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplicador1Alg is
    Port ( A : in  UNSIGNED (3 downto 0);			--Entradas: Números A, B e CarryIn todos em BCD.
           B : in  UNSIGNED (3 downto 0);
           CarryIn : in  UNSIGNED (3 downto 0);
           Unidade : out  UNSIGNED (3 downto 0);	--Saídas: Unidade e Dezena do resultado da multiplicação em BCD.
           Dezena : out  UNSIGNED (3 downto 0));
end Multiplicador1Alg;

architecture Behavioral of Multiplicador1Alg is

	signal parcial, resto, quociente : UNSIGNED (7 downto 0);

begin
	
	parcial <= (A * B) + CarryIn; -- Sinal parcial recebe o resultado em binário da multiplicação com a adição do CarryIn
	
	resto <= parcial rem 10;		-- Pega o resto da divisão por 10 que será a saída de Unidade.
	quociente <= parcial / 10;		-- Pega o resultado (quociente) da divisão por 10 que será a saída de Dezena
		
	Unidade <= resto (3 downto 0);
	Dezena <= quociente (3 downto 0);

end Behavioral;

