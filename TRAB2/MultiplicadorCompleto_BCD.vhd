library IEEE;
use IEEE.STD_lOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MultiplicadorCompleto_BCD is
    Port ( A0, A1, A2, A3 : in  UNSIGNED (3 downto 0);
           B0, B1, B2, B3 : in  UNSIGNED (3 downto 0);
           Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7 : out  UNSIGNED (3 downto 0)
           );
end MultiplicadorCompleto_BCD;

architecture Behavioral of MultiplicadorCompleto_BCD is

    type array_auxiliar is array (0 to 4) of UNSIGNED (3 downto 0);
    type array_auxiliar2 is array (0 to 3) of UNSIGNED (3 downto 0);
    type array_auxiliar3 is array (0 to 7) of UNSIGNED (3 downto 0);

    type vetor_de_vetores is array (0 to 3) of UNSIGNED (3 downto 0);
    type CoisaDoida is array (0 to 3) of array_auxiliar;
    type CoisaDoida2 is array (0 to 3) of array_auxiliar2;
    type loucura is array (0 to 3) of array_auxiliar3;

	signal numeroA, numeroB : vetor_de_vetores;
    signal resultadoParcial : CoisaDoida2;
    signal c : CoisaDoida;
    signal numeros_da_soma : loucura;
    signal aux, aux1, aux2 : array_auxiliar3;
    signal seila, seila2, seila3 : UNSIGNED (3 downto 0);

	component Multiplicador1Alg is
    Port (  A : in UNSIGNED ( 3 downto 0 );
            B : in UNSIGNED ( 3 downto 0 );
            CarryIn : in UNSIGNED ( 3 downto 0 );
            Resultado : out UNSIGNED ( 3 downto 0 );
            CarryOut : out UNSIGNED ( 3 downto 0 )
    );
	end component;

    component SomadorCompleto_BCD is
        Port ( A0, A1, A2, A3 : in  UNSIGNED (3 downto 0);
               B0, B1, B2, B3 : in  UNSIGNED (3 downto 0);
               CarryIn : in UNSIGNED (3 downto 0);
               Z0, Z1, Z2, Z3, Z4 : out  UNSIGNED (3 downto 0)
    );
    end component;

begin
    numeroA <= (A0, A1, A2, A3);
    numeroB <= (B0, B1, B2, B3);
    gen_outer : for i in 0 to 3 generate
    c(i)(0) <= "0000";
        gen_inner : for j in 0 to 3 generate
            inst: Multiplicador1Alg
                port map (  A => numeroA(i),
                            B => numeroB(j),
                            CarryIn => c(i)(j),
                            Resultado => resultadoParcial(i)(j),
                            CarryOut => c(i)(j+1));
        end generate gen_inner;
    end generate gen_outer;

    numeros_da_soma(0)(5 to 7) <= ("0000", "0000", "0000");
    numeros_da_soma(0)(4) <= c(0)(4);
    numeros_da_soma(0)(3) <= resultadoParcial(0)(3);
    numeros_da_soma(0)(2) <= resultadoParcial(0)(2);
    numeros_da_soma(0)(1) <= resultadoParcial(0)(1);
    numeros_da_soma(0)(0) <= resultadoParcial(0)(0);

    numeros_da_soma(1)(6 to 7) <= ("0000", "0000");
    numeros_da_soma(1)(5) <= c(1)(4);
    numeros_da_soma(1)(4) <= resultadoParcial(1)(3);
    numeros_da_soma(1)(3) <= resultadoParcial(1)(2);
    numeros_da_soma(1)(2) <= resultadoParcial(1)(1);
    numeros_da_soma(1)(1) <= resultadoParcial(1)(0);
    numeros_da_soma(1)(0) <= "0000";

    numeros_da_soma(2)(7) <= "0000";
    numeros_da_soma(2)(6) <= c(2)(4);
    numeros_da_soma(2)(5) <= resultadoParcial(2)(3);
    numeros_da_soma(2)(4) <= resultadoParcial(2)(2);
    numeros_da_soma(2)(3) <= resultadoParcial(2)(1);
    numeros_da_soma(2)(2) <= resultadoParcial(2)(0);
    numeros_da_soma(2)(0 to 1) <= ("0000", "0000");

    numeros_da_soma(3)(7) <= c(3)(4);
    numeros_da_soma(3)(6) <= resultadoParcial(3)(3);
    numeros_da_soma(3)(5) <= resultadoParcial(3)(2);
    numeros_da_soma(3)(4) <= resultadoParcial(3)(1);
    numeros_da_soma(3)(3) <= resultadoParcial(3)(0);
    numeros_da_soma(3)(0 to 2) <= ("0000", "0000", "0000");


    soma11 : SomadorCompleto_BCD
            port map (  A0 => numeros_da_soma(0)(0),
                         A1 => numeros_da_soma(0)(1),
                         A2 => numeros_da_soma(0)(2),
                         A3 => numeros_da_soma(0)(3),
                         B0 => numeros_da_soma(1)(0),
                         B1 => numeros_da_soma(1)(1),
                         B2 => numeros_da_soma(1)(2),
                         B3 => numeros_da_soma(1)(3),
                         CarryIn => "0000",
                         Z0 => aux(0),
                         Z1 => aux(1),
                         Z2 => aux(2),
                         Z3 => aux(3),
                         Z4 => seila);

    soma12 : SomadorCompleto_BCD
            port map (  A0 => numeros_da_soma(0)(4),
                        A1 => numeros_da_soma(0)(5),
                        A2 => numeros_da_soma(0)(6),
                        A3 => numeros_da_soma(0)(7),
                        B0 => numeros_da_soma(1)(4),
                        B1 => numeros_da_soma(1)(5),
                        B2 => numeros_da_soma(1)(6),
                        B3 => numeros_da_soma(1)(7),
                        CarryIn => seila,
                        Z0 => aux(4),
                        Z1 => aux(5),
                        Z2 => aux(6),
                        Z3 => aux(7));

    soma21 : SomadorCompleto_BCD
    port map (      A0 => aux(0),
                    A1 => aux(1),
                    A2 => aux(2),
                    A3 => aux(3),
                    B0 => numeros_da_soma(2)(0),
                    B1 => numeros_da_soma(2)(1),
                    B2 => numeros_da_soma(2)(2),
                    B3 => numeros_da_soma(2)(3),
                    CarryIn => "0000",
                    Z0 => aux1(0),
                    Z1 => aux1(1),
                    Z2 => aux1(2),
                    Z3 => aux1(3),
                    Z4 => seila2);

    soma22 : SomadorCompleto_BCD
    port map (  A0 => aux(4),
                A1 => aux(5),
                A2 => aux(6),
                A3 => aux(7),
                B0 => numeros_da_soma(2)(4),
                B1 => numeros_da_soma(2)(5),
                B2 => numeros_da_soma(2)(6),
                B3 => numeros_da_soma(2)(7),
                CarryIn => seila2,
                Z0 => aux1(4),
                Z1 => aux1(5),
                Z2 => aux1(6),
                Z3 => aux1(7));


    soma31 : SomadorCompleto_BCD
    port map (  A0 => aux1(0),
                A1 => aux1(1),
                A2 => aux1(2),
                A3 => aux1(3),
                B0 => numeros_da_soma(3)(0),
                B1 => numeros_da_soma(3)(1),
                B2 => numeros_da_soma(3)(2),
                B3 => numeros_da_soma(3)(3),
                CarryIn => "0000",
                Z0 => aux2(0),
                Z1 => aux2(1),
                Z2 => aux2(2),
                Z3 => aux2(3),
                Z4 => seila3);

    soma32 : SomadorCompleto_BCD
    port map (  A0 => aux1(4),
                A1 => aux1(5),
                A2 => aux1(6),
                A3 => aux1(7),
                B0 => numeros_da_soma(3)(4),
                B1 => numeros_da_soma(3)(5),
                B2 => numeros_da_soma(3)(6),
                B3 => numeros_da_soma(3)(7),
                CarryIn => seila3,
                Z0 => aux2(4),
                Z1 => aux2(5),
                Z2 => aux2(6),
                Z3 => aux2(7));

    Z0 <= aux2(0);
    Z1 <= aux2(1);
    Z2 <= aux2(2);
    Z3 <= aux2(3);
    Z4 <= aux2(4);
    Z5 <= aux2(5);
    Z6 <= aux2(6);
    Z7 <= aux2(7);

 end Behavioral;

