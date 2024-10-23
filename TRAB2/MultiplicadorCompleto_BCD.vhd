library IEEE;
use IEEE.STD_lOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MultiplicadorCompleto_BCD is
    Port ( A0, A1, A2, A3 : in  UNSIGNED (3 downto 0);                  -- Entradas: 2 números de 4 algarismos A0..A3 e B0..B3 todos em BCD.
           B0, B1, B2, B3 : in  UNSIGNED (3 downto 0);
           Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7 : out  UNSIGNED (3 downto 0)  -- Saídas: Resultado da soma em BCD separado em 5 variáveis Z0..Z4.
           );
end MultiplicadorCompleto_BCD;


architecture Behavioral of MultiplicadorCompleto_BCD is

    type array_auxiliar is array (0 to 4) of UNSIGNED (3 downto 0);
    type array_auxiliar2 is array (0 to 3) of UNSIGNED (3 downto 0);

    -- ============== DEFINIÇÃO DE TIPOS IMPORTANTES ==================
    type vetor_de_8_BCDs is array (0 to 7) of UNSIGNED (3 downto 0);
    type vetor_de_4_BCDs is array (0 to 3) of UNSIGNED (3 downto 0);
    type matriz_4x5_BCDs is array (0 to 3) of array_auxiliar;
    type matriz_4x4_BCDs is array (0 to 3) of array_auxiliar2;
    type matriz_4x8_BCDs is array (0 to 3) of vetor_de_8_BCDs;

    -- ================ DEFINIÇÃO DE SINAIS IMPORTANTES =================
	signal numeroA, numeroB : vetor_de_4_BCDs; -- Vetores para armazenar os números A e B da entrada.
    signal resultadoMultiplicacoes : matriz_4x4_BCDs; -- Matriz para armazenar os resultados das multiplicações de algarismos. 
    signal carrysMult : matriz_4x5_BCDs; -- Matriz para armazenar e propagar os carrys das multiplicações.
    signal numerosDaSoma : matriz_4x8_BCDs; -- Matriz onde serão organizados os resultados das multiplicações individuais para realizar a soma deles depois.
    signal somaParcial1, somaParcial2, somaFinal : vetor_de_8_BCDs; -- Vetores para armazenar os resultados parciais e final das somas.
    signal carrySoma1, carrySoma2 , carrySoma3 : UNSIGNED (3 downto 0); -- BCDs para armazenar e propagar os carrys das somas.


	component Multiplicador1Alg is
    Port (  A : in UNSIGNED ( 3 downto 0 );
            B : in UNSIGNED ( 3 downto 0 );
            CarryIn : in UNSIGNED ( 3 downto 0 );
            Unidade : out UNSIGNED ( 3 downto 0 );
            Dezena : out UNSIGNED ( 3 downto 0 )
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
                                                                -- ========================== MULTIPLICAÇÕES ====================================                                                      
    numeroA <= (A0, A1, A2, A3);                                -- Primeiro é armazenado as entradas nos vetores dos números e então começa dois
    numeroB <= (B0, B1, B2, B3);                                -- loops para pegar individualmente cada algarismo e fazer a sua multiplicação
    numerosA : for i in 0 to 3 generate                         -- individual pela instanciação da multiplicação simples. É feita a multiplicação 
    carrysMult(i)(0) <= "0000";                                 -- de cada numeroA com os 4 numeroB ( isso resulta em números de 5 alg ) e esses 
        numerosB : for j in 0 to 3 generate                     -- resultados são armazenados em cada linha de resultadoMultiplcacoes sendo os últimos
            multiplicacoes: Multiplicador1Alg                   -- algarismos sendo armazenados nas últimas colunas do carrysMult.
                port map (  A => numeroA(i),
                            B => numeroB(j),
                            CarryIn => carrysMult(i)(j),
                            Unidade => resultadoMultiplicacoes(i)(j),
                            Dezena => carrysMult(i)(j+1));
        end generate numerosB;
    end generate numerosA;

    -- Nessas próximas linhas é feita a organização de cada resultado com um Shift Left manual de forma que tenhamos 4 números de 8 algarismos para a soma.
    numerosDaSoma(0)(5 to 7) <= ("0000", "0000", "0000");
    numerosDaSoma(0)(4) <= carrysMult(0)(4);
    numerosDaSoma(0)(3) <= resultadoMultiplicacoes(0)(3);
    numerosDaSoma(0)(2) <= resultadoMultiplicacoes(0)(2);
    numerosDaSoma(0)(1) <= resultadoMultiplicacoes(0)(1);
    numerosDaSoma(0)(0) <= resultadoMultiplicacoes(0)(0);

    numerosDaSoma(1)(6 to 7) <= ("0000", "0000");
    numerosDaSoma(1)(5) <= carrysMult(1)(4);
    numerosDaSoma(1)(4) <= resultadoMultiplicacoes(1)(3);
    numerosDaSoma(1)(3) <= resultadoMultiplicacoes(1)(2);
    numerosDaSoma(1)(2) <= resultadoMultiplicacoes(1)(1);
    numerosDaSoma(1)(1) <= resultadoMultiplicacoes(1)(0);
    numerosDaSoma(1)(0) <= "0000";

    numerosDaSoma(2)(7) <= "0000";
    numerosDaSoma(2)(6) <= carrysMult(2)(4);
    numerosDaSoma(2)(5) <= resultadoMultiplicacoes(2)(3);
    numerosDaSoma(2)(4) <= resultadoMultiplicacoes(2)(2);
    numerosDaSoma(2)(3) <= resultadoMultiplicacoes(2)(1);
    numerosDaSoma(2)(2) <= resultadoMultiplicacoes(2)(0);
    numerosDaSoma(2)(0 to 1) <= ("0000", "0000");

    numerosDaSoma(3)(7) <= carrysMult(3)(4);
    numerosDaSoma(3)(6) <= resultadoMultiplicacoes(3)(3);
    numerosDaSoma(3)(5) <= resultadoMultiplicacoes(3)(2);
    numerosDaSoma(3)(4) <= resultadoMultiplicacoes(3)(1);
    numerosDaSoma(3)(3) <= resultadoMultiplicacoes(3)(0);
    numerosDaSoma(3)(0 to 2) <= ("0000", "0000", "0000");

    -- Agora é feita a soma de cada um desses números em 2 partes ( primeiro os 4 algarismos menos significativos e depois os 4 mais significativos )
    -- O Resutado de cada soma completa de 8 algarismos é armazenado em uma soma parcial que é utilizada pra fazer a soma com o próximo número de numerosDaSoma.
    -- A última soma já é transmitida direto pra saída Z.
    soma11 : SomadorCompleto_BCD
            port map (  A0 => numerosDaSoma(0)(0),
                        A1 => numerosDaSoma(0)(1),
                        A2 => numerosDaSoma(0)(2),
                        A3 => numerosDaSoma(0)(3),
                        B0 => numerosDaSoma(1)(0),
                        B1 => numerosDaSoma(1)(1),
                        B2 => numerosDaSoma(1)(2),
                        B3 => numerosDaSoma(1)(3),
                        CarryIn => "0000",
                        Z0 => somaParcial1(0),
                        Z1 => somaParcial1(1),
                        Z2 => somaParcial1(2),
                        Z3 => somaParcial1(3),
                        Z4 => carrySoma1);

    soma12 : SomadorCompleto_BCD
            port map (  A0 => numerosDaSoma(0)(4),
                        A1 => numerosDaSoma(0)(5),
                        A2 => numerosDaSoma(0)(6),
                        A3 => numerosDaSoma(0)(7),
                        B0 => numerosDaSoma(1)(4),
                        B1 => numerosDaSoma(1)(5),
                        B2 => numerosDaSoma(1)(6),
                        B3 => numerosDaSoma(1)(7),
                        CarryIn => carrySoma1,
                        Z0 => somaParcial1(4),
                        Z1 => somaParcial1(5),
                        Z2 => somaParcial1(6),
                        Z3 => somaParcial1(7));

    soma21 : SomadorCompleto_BCD
            port map (  A0 => somaParcial1(0),
                        A1 => somaParcial1(1),
                        A2 => somaParcial1(2),
                        A3 => somaParcial1(3),
                        B0 => numerosDaSoma(2)(0),
                        B1 => numerosDaSoma(2)(1),
                        B2 => numerosDaSoma(2)(2),
                        B3 => numerosDaSoma(2)(3),
                        CarryIn => "0000",
                        Z0 => somaParcial2(0),
                        Z1 => somaParcial2(1),
                        Z2 => somaParcial2(2),
                        Z3 => somaParcial2(3),
                        Z4 => carrySoma2);

    soma22 : SomadorCompleto_BCD
            port map (  A0 => somaParcial1(4),
                        A1 => somaParcial1(5),
                        A2 => somaParcial1(6),
                        A3 => somaParcial1(7),
                        B0 => numerosDaSoma(2)(4),
                        B1 => numerosDaSoma(2)(5),
                        B2 => numerosDaSoma(2)(6),
                        B3 => numerosDaSoma(2)(7),
                        CarryIn => carrySoma2,
                        Z0 => somaParcial2(4),
                        Z1 => somaParcial2(5),
                        Z2 => somaParcial2(6),
                        Z3 => somaParcial2(7));


    soma31 : SomadorCompleto_BCD
            port map (  A0 => somaParcial2(0),
                        A1 => somaParcial2(1),
                        A2 => somaParcial2(2),
                        A3 => somaParcial2(3),
                        B0 => numerosDaSoma(3)(0),
                        B1 => numerosDaSoma(3)(1),
                        B2 => numerosDaSoma(3)(2),
                        B3 => numerosDaSoma(3)(3),
                        CarryIn => "0000",
                        Z0 => Z0,
                        Z1 => Z1,
                        Z2 => Z2,
                        Z3 => Z3,
                        Z4 => carrySoma3);

    soma32 : SomadorCompleto_BCD
            port map (  A0 => somaParcial2(4),
                        A1 => somaParcial2(5),
                        A2 => somaParcial2(6),
                        A3 => somaParcial2(7),
                        B0 => numerosDaSoma(3)(4),
                        B1 => numerosDaSoma(3)(5),
                        B2 => numerosDaSoma(3)(6),
                        B3 => numerosDaSoma(3)(7),
                        CarryIn => carrySoma3,
                        Z0 => Z4,
                        Z1 => Z5,
                        Z2 => Z6,
                        Z3 => Z7);

end Behavioral;

