library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity somador1Alg is
    Port ( CarryIn : in UNSIGNED ( 3 downto 0 ) := "0000";
            A : in UNSIGNED ( 3 downto 0 ) := "0000";
            B : in UNSIGNED ( 3 downto 0 ) := "0000";
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
            if parcial > "01001" then
                Resultado <= parcial ( 3 downto 0 ) + "0110";
                CarryOut <= "0001";
            else
                Resultado <= parcial ( 3 downto 0 );
                CarryOut <= "0000";
            end if;
        end process;

end comportamento;