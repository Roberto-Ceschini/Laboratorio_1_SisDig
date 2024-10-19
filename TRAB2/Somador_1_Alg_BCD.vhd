library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity somador_1_Alg_BCD is
    Port ( CarryIn : in STD_LOGIC_VECTOR ( 3 downto 0 );
            A : in STD_LOGIC_VECTOR ( 3 downto 0 );
            B : in STD_LOGIC_VECTOR ( 3 downto 0 );
            Resultado : out STD_LOGIC_VECTOR ( 3 downto 0 );
            CarryOut : out STD_LOGIC_VECTOR ( 3 downto 0 )
    );
end somador_1_Alg_BCD;


architecture comportamento of somador_1_Alg_BCD is

    signal parcial : STD_LOGIC_VECTOR ( 4 downto 0 );

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