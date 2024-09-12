library IEEE;
use IEEE.std_logic_1164.all;

entity porta_or is

    port(

        in1, in2 : in std_logic_vector (3 downto 0); 
        saida : out std_logic_vector (3 downto 0)
           
    );

    end porta_or;

architecture comportamento of porta_or is -- Funcao: faz o Or bit a bit das entradas in1 e in2

    begin

        saida (0) <= in1 (0) or in2 (0);
        saida (1) <= in1 (1) or in2 (1);
        saida (2) <= in1 (2) or in2 (2);
        saida (3) <= in1 (3) or in2 (3);

    end comportamento; 