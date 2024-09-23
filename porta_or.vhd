library IEEE;
use IEEE.std_logic_1164.all;

entity porta_or is

    port(

        in1_or, in2_or : in std_logic_vector (3 downto 0); --Entrada: dois vetores de 4 bits
        saida_or : out std_logic_vector (3 downto 0) --Saida_or: um vetor de 4 bits, resultado da operacao logica OR bit a bit das entradas
           
    );

    end porta_or;

architecture comportamento of porta_or is -- Funcao: Realizar a operacao logica OR bit a bit das entradas (in1_or OR in2_or)

    begin

        saida_or (0) <= in1_or (0) or in2_or (0);
        saida_or (1) <= in1_or (1) or in2_or (1);
        saida_or (2) <= in1_or (2) or in2_or (2);
        saida_or (3) <= in1_or (3) or in2_or (3);

    end comportamento; 