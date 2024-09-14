library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity porta_xor is
    Port ( 

        in1, in2 : in  STD_LOGIC_VECTOR (3 downto 0); --Entrada: dois vetores de 4 bits
        saida : out  STD_LOGIC_VECTOR (3 downto 0));  -- Saidas: um vetor de 4 bits, resultado da operacao logica XOR bit a bit das entradas

end porta_xor;

architecture Behavioral of porta_xor is --Funcao: Realizar a operacao logica XOR bit a bit das entradas (in1 XOR in2)

begin

saida (0) <= in1(0) xor in2(0);
saida (1) <= in1(1) xor in2(1);
saida (2) <= in1(2) xor in2(2);
saida (3) <= in1(3) xor in2(3);

end Behavioral;