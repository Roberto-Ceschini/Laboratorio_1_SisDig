library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity porta_not is
    Port (

        entrada : in  STD_LOGIC_VECTOR (3 downto 0); --Entrada: um vetor de 4 bits 
        saida : out  STD_LOGIC_VECTOR (3 downto 0)); -- Saida: um vetor de 4 bits, resultado da operacao logica NOT bit a bit da entrada

end porta_not;

architecture comportamento of porta_not is -- Funcao: Realizar a operacao logica NOT bit a bit da entrada (NOT entrada)

begin

saida (0) <= not entrada(0);  
saida (1) <= not entrada(1);
saida (2) <= not entrada(2);
saida (3) <= not entrada(3);

end comportamento;