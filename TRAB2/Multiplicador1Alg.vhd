library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplicador1Alg is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           CarryIn : in  STD_LOGIC_VECTOR (3 downto 0);
           Resultado : out  STD_LOGIC_VECTOR (3 downto 0);
           CarryOut : out  STD_LOGIC_VECTOR (3 downto 0));
end Multiplicador1Alg;

architecture Behavioral of Multiplicador1Alg is

	signal parcial : STD_LOGIC_VECTOR (7 downto 0);

begin
	
	parcial <= A * B;
	process (parcial)
	begin
		if parcial ( 3 downto 0 ) > 9 then
			Resultado <= parcial( 3 downto 0 ) + 6;
		else
			Resultado <= parcial( 3 downto 0 );
		end if;
		
		if parcial ( 7 downto 4 ) > 9 then
			CarryOut <= parcial( 7 downto 4 ) + 6;
		else
			CarryOut <= parcial( 7 downto 4 );
		end if;
		
	end process;

end Behavioral;

