library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplicador1Alg is
    Port ( A : in  UNSIGNED (3 downto 0);
           B : in  UNSIGNED (3 downto 0);
           CarryIn : in  UNSIGNED (3 downto 0);
           Resultado : out  UNSIGNED (3 downto 0);
           CarryOut : out  UNSIGNED (3 downto 0));
end Multiplicador1Alg;

architecture Behavioral of Multiplicador1Alg is

	signal parcial, resto, quociente : UNSIGNED (7 downto 0);

begin
	
	parcial <= (A * B) + CarryIn;
	
	resto <= parcial rem 10;
	quociente <= parcial / 10;
		
	Resultado <= resto (3 downto 0);
	CarryOut <= quociente (3 downto 0);

end Behavioral;

