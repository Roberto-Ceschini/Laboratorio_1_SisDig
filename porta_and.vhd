library IEEE;
use IEEE.std_logic_1164.all;

entity porta_and is

    port(

        in1, in2 : in std_logic_vector (3 downto 0);
        saida : out std_logic_vector (3 downto 0)

    );
    
    end porta_and;

architecture comportamento of porta_and is --Funcao: Faz o and bit a bit das entradas in1 e in2

    begin

        saida (0) <= in1 (0) and in2 (0);
        saida (1) <= in1 (1) and in2 (1); 
        saida (2) <= in1 (2) and in2 (2); 
        saida (3) <= in1 (3) and in2 (3);  
 
    end comportamento;