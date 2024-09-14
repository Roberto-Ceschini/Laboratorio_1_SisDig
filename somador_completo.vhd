library IEEE;
use IEEE.std_logic_1164.all;

entity somador_completo is

    port(

        bit_numA, bit_numB, cin : in std_logic; -- Entradas: numeroA (1 bit), numeroB (1 bit) e carryIn (1 bit)
        cout, bit_resultado : out std_logic -- Saidas: carryOut (1 bit) e Resultado (1 bit)

    );

    end somador_completo;

architecture comportamento of somador_completo is -- Funcao: realiza a operacao aritmetica numeroA + numeroB + carryIn, gerando como saídas o resultado da operacao e o carryOut

    begin

        bit_resultado <= bit_numA XOR bit_numB XOR cin;
        cout <= (bit_numA and bit_numB) or (bit_numA and cin) or (bit_numB and cin);

    end comportamento;