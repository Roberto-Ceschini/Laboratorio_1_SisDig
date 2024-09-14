library IEEE;
use IEEE.std_logic_1164.all;

entity porta_or is

    port(

        in1_not, in2_not : in std_logic_vector (3 downto 0); --Entrada: dois vetores de 4 bits
        saida_not : out std_logic_vector (3 downto 0) --Saida_not: um vetor de 4 bits, resultado da operacao logica OR bit a bit das entradas
           
    );

    end porta_or;

architecture comportamento of porta_or is -- Funcao: Realizar a operacao logica OR bit a bit das entradas (in1_not OR in2_not)

    begin

        saida_not (0) <= in1_not (0) or in2_not (0);
        saida_not (1) <= in1_not (1) or in2_not (1);
        saida_not (2) <= in1_not (2) or in2_not (2);
        saida_not (3) <= in1_not (3) or in2_not (3);

    end comportamento; 