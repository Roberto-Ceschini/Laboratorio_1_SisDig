library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity somador1Alg is
    Port ( CarryIn : in UNSIGNED ( 3 downto 0 );
            A : in UNSIGNED ( 3 downto 0 );
            B : in UNSIGNED ( 3 downto 0 );
            Resultado : out UNSIGNED ( 3 downto 0 );
            CarryOut : out UNSIGNED ( 3 downto 0 )
    );
end somador1Alg;


architecture comportamento of somador1Alg is

    signal parcial : UNSIGNED ( 4 downto 0 );

    begin
        parcial <= ('0' & A) + ('0' & B) + ('0' & CarryIn);
        process (parcial)
        begin
            if parcial > 9 then
                Resultado <= parcial ( 3 downto 0 ) + 6;
                CarryOut <= 1;
            else
                Resultado <= parcial ( 3 downto 0 );
                CarryOut <= 0;
            end if;
        end process;

end comportamento;