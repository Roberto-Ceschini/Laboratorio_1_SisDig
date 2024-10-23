library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity somador1Alg is
    Port ( CarryIn : in UNSIGNED ( 3 downto 0 ); -- Entradas: Números A, B e um CarryIn, todos em BCD.
            A : in UNSIGNED ( 3 downto 0 );
            B : in UNSIGNED ( 3 downto 0 );
            Unidade : out UNSIGNED ( 3 downto 0 ); -- Saídas: Unidade e Dezena do resultado da soma em BCD.
            Dezena : out UNSIGNED ( 3 downto 0 )
    );
end somador1Alg;


architecture comportamento of somador1Alg is

    signal parcial : UNSIGNED ( 4 downto 0 );

    begin
        parcial <= ('0' & A) + ('0' & B) + ('0' & CarryIn); -- Realiza a soma entre as 3 entradas e armazena o resultado em uma parcial.
        process (parcial)
        begin
            if parcial > "01001" then                       -- Verifica o valor do resultado da soma pra separar corretamente em Unidade e Dezena.
                Unidade <= parcial ( 3 downto 0 ) + "0110";
                Dezena <= "0001";
            else
                Unidade <= parcial ( 3 downto 0 );
                Dezena <= "0000";
            end if;
        end process;

end comportamento;