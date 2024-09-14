library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity porta_xor is
    Port ( 

        in1_xor, in2_xor : in  STD_LOGIC_VECTOR (3 downto 0); --Entrada: dois vetores de 4 bits
        saida : out  STD_LOGIC_VECTOR (3 downto 0));  -- Saidas: um vetor de 4 bits, resultado da operacao logica XOR bit a bit das entradas

end porta_xor;

architecture Behavioral of porta_xor is --Funcao: Realizar a operacao logica XOR bit a bit das entradas (in1_xor XOR in2_xor)

begin

saida (0) <= in1_xor(0) xor in2_xor(0);
saida (1) <= in1_xor(1) xor in2_xor(1);
saida (2) <= in1_xor(2) xor in2_xor(2);
saida (3) <= in1_xor(3) xor in2_xor(3);

end Behavioral;