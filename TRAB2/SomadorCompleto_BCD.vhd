library IEEE;
use IEEE.STD_lOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity SomadorCompleto_BCD is
    Port ( A0, A1, A2, A3 : in  UNSIGNED (3 downto 0);		-- Entradas: Números de 4 algarismos A0..A3 e B0..B3 e um CarryIn, todos em BCD.
           B0, B1, B2, B3 : in  UNSIGNED (3 downto 0);
		   CarryIn : in UNSIGNED (3 downto 0);
           Z0, Z1, Z2, Z3, Z4 : out  UNSIGNED (3 downto 0)); -- Saídas: Resultado da soma em BCD separado em 5 variáveis Z0..Z4.
end SomadorCompleto_BCD;


architecture Behavioral of SomadorCompleto_BCD is
	signal carry0, carry1, carry2 : UNSIGNED ( 3 downto 0); -- Sinais de carry para fazer a conexão de carrys entre as somas individuais.
	
	component somador1Alg is
    Port ( CarryIn : in UNSIGNED ( 3 downto 0 );
            A : in UNSIGNED ( 3 downto 0 );
            B : in UNSIGNED ( 3 downto 0 );
            Unidade : out UNSIGNED ( 3 downto 0 );
            Dezena : out UNSIGNED ( 3 downto 0 )
    );
	end component;

begin		-- A soma é feita algarismo a algarismo com a instância do somador simples, e propagação de carry entre eles. O resultado já é armazenado direto nas saídas Zs.

	somador1 : somador1Alg port map (
						CarryIn => CarryIn,
						A => A0,
						B => B0,
						Unidade => Z0,
						Dezena => carry0);
	
	somador2 : somador1Alg port map (
						CarryIn => carry0, 
						A => A1,
						B => B1,
						Unidade => Z1,
						Dezena => carry1);
						
	somador3 : somador1Alg port map (
						CarryIn => carry1, 
						A => A2,
						B => B2,
						Unidade => Z2,
						Dezena => carry2);
				
	somador4 : somador1Alg port map (
						CarryIn => carry2, 
						A => A3,
						B => B3,
						Unidade => Z3,
						Dezena => Z4);

end Behavioral;

