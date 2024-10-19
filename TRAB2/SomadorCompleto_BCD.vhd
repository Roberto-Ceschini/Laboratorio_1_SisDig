library IEEE;
use IEEE.STD_lOGIC_1164.ALL;


entity SomadorCompleto_BCD is
    Port ( A0, A1, A2, A3 : in  STD_LOGIC_VECTOR (3 downto 0);
           B0, B1, B2, B3 : in  STD_LOGIC_VECTOR (3 downto 0);
           Z0, Z1, Z2, Z3, Z4 : out  STD_LOGIC_VECTOR (3 downto 0));
end SomadorCompleto_BCD;


architecture Behavioral of SomadorCompleto_BCD is
	signal c0, c1, c2 : STD_LOGIC_VECTOR ( 3 downto 0);
	
	component somador_1_Alg_BCD is
    Port ( CarryIn : in STD_LOGIC_VECTOR ( 3 downto 0 );
            A : in STD_LOGIC_VECTOR ( 3 downto 0 );
            B : in STD_LOGIC_VECTOR ( 3 downto 0 );
            Resultado : out STD_LOGIC_VECTOR ( 3 downto 0 );
            CarryOut : out STD_LOGIC_VECTOR ( 3 downto 0 )
    );
	end component;

begin

	somador1 : somador_1_Alg_BCD port map (
						CarryIn => "0000", 
						A => A0,
						B => B0,
						Resultado => Z0,
						CarryOut => c0);
	
	somador2 : somador_1_Alg_BCD port map (
						CarryIn => c0, 
						A => A1,
						B => B1,
						Resultado => Z1,
						CarryOut => c1);
						
	somador3 : somador_1_Alg_BCD port map (
						CarryIn => c1, 
						A => A2,
						B => B2,
						Resultado => Z2,
						CarryOut => c2);
				
	somador4 : somador_1_Alg_BCD port map (
						CarryIn => c2, 
						A => A3,
						B => B3,
						Resultado => Z3,
						CarryOut => Z4);

end Behavioral;

