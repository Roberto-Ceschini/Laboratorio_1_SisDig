library IEEE;
use IEEE.std_logic_1164.all;

entity somador_completo is

    port(

        numA, numB, cin : in std_logic; -- Entradas: numeroA, numeroB e carryIn
        cout, resultado : out std_logic -- Saidas: carryOut e Resultado

    );

    end somador_completo;

architecture comportamento of somador_completo is -- Funcao: realiza a operacao aritmetica numA + numB + carryIn, gerando como saídas o resultado da operacao e o carryOut

    begin

        resultado <= numA XOR numB XOR cin;
        cout <= (numA and numB) or (numA and cin) or (numB and cin);

    end comportamento;