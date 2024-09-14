library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity porta_not is
    Port (

        entrada_not : in  STD_LOGIC_VECTOR (3 downto 0); --Entrada_not: um vetor de 4 bits 
        saida_not : out  STD_LOGIC_VECTOR (3 downto 0)); -- Saida: um vetor de 4 bits, resultado da operacao logica NOT bit a bit da entrada_not

end porta_not;

architecture comportamento of porta_not is -- Funcao: Realizar a operacao logica NOT bit a bit da entrada_not (NOT entrada_not)

begin

saida_not (0) <= not entrada_not(0);  
saida_not (1) <= not entrada_not(1);
saida_not (2) <= not entrada_not(2);
saida_not (3) <= not entrada_not(3);

end comportamento;