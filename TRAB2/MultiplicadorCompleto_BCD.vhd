library IEEE;
use IEEE.STD_lOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MultiplicadorCompleto_BCD is
    Port ( A0, A1, A2, A3 : in  UNSIGNED (3 downto 0);
           B0, B1, B2, B3 : in  UNSIGNED (3 downto 0);
           Z0, Z1, Z2, Z3, Z4 : out  UNSIGNED (3 downto 0)
           );
end MultiplicadorCompleto_BCD;

architecture Behavioral of MultiplicadorCompleto_BCD is

    type vetor_de_vetores is array (0 to 3) of UNSIGNED (3 downto 0);
    type vetor_de_vetores2 is array (0 to 3) of UNSIGNED (4 downto 0);
    type vetor_de_vetores3 is array (0 to 4) of UNSIGNED (3 downto 0);

	signal numeroA, numeroB, resultadoParcial : vetor_de_vetores;
    signal resultadoParcial1 : vetor_de_vetores2;
    signal c : vetor_de_vetores3;

	component Multiplicador1Alg is
    Port (  A : in UNSIGNED ( 3 downto 0 );
            B : in UNSIGNED ( 3 downto 0 );
            CarryIn : in UNSIGNED ( 3 downto 0 );
            Resultado : out UNSIGNED ( 3 downto 0 );
            CarryOut : out UNSIGNED ( 3 downto 0 )
    );
	end component;

begin
    numeroA <= (A0, A1, A2, A3);
    numeroB <= (B0, B1, B2, B3);
	c(0) <= "0000";

    gen_outer : for i in 0 to 3 generate
        gen_inner : for j in 0 to 3 generate
            inst: entity work.Multiplicador1Alg
                port map (  A => numeroA(i),
                            B => numeroB(j),
                            CarryIn => c(j),
                            Resultado => resultadoParcial(j),
                            CarryOut => c(j+1));
        end generate gen_inner;
        
        resultadoParcial1(i) <= (c(4) & resultadoParcial());
        c(0) <= "0000";

    end generate gen_outer;
end Behavioral;

