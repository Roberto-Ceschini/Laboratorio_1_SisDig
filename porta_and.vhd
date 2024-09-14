library IEEE;
use IEEE.std_logic_1164.all;

entity porta_and is

    port(

        in1_and, in2_and : in std_logic_vector (3 downto 0); --Entradas: dois vetores de 4 bits
        saida_and : out std_logic_vector (3 downto 0) --Saida: um vetor de 4 bits, resultado da operacao logica AND bit a bit das entradas

    );
    
    end porta_and;

architecture comportamento of porta_and is --Funcao: Realizar a operacao logica AND bit a bit das entradas (in1_and AND in2_and)

    begin

        saida_and (0) <= in1_and (0) and in2_and (0);
        saida_and (1) <= in1_and (1) and in2_and (1); 
        saida_and (2) <= in1_and (2) and in2_and (2); 
        saida_and (3) <= in1_and (3) and in2_and (3);  
 
    end comportamento;