library IEEE;
use IEEE.std_logic_1164.all;

entity multiplicador is 
    port (
        numA_multiplicador, numB_multiplicador : in std_logic_vector (3 downto 0); -- Entradas_MULTIPLICADOR: numeroA (4 bits), numeroB (4 bits)
        resultado_multiplicador : out std_logic_vector (3 downto 0) -- Saida_MULTIPLICADOR: Resultado da operacao (4 bits)
    );
end multiplicador;

architecture comportamento of multiplicador is 

    -- Definindo os componentes utilizados
    component somador_4_bits is
        Port(   
            numA_somador, numB_somador : in std_logic_vector (3 downto 0); -- Entradas_SOMADOR (4 bits)
            resultado_somador : out std_logic_vector (3 downto 0) -- Saida_SOMADOR (4 bits)
        );
    end component;

    component porta_and is
        port(
            in1_and, in2_and : in std_logic_vector (3 downto 0); -- Entradas_AND (4 bits)
            saida_and : out std_logic_vector (3 downto 0) -- Saida_AND (4 bits)
        );
    end component;

    -- Sinais intermediários do multiplicador
    signal parcial_0, parcial_1, parcial_2, parcial_3, parcial_4, parcial_5 : std_logic_vector (3 downto 0);

begin
-- Multiplicacao do bit menos significativo de B com A (sem deslocamento)
and_0 : porta_and 
    port map (
        in1_and => numA_multiplicador,
        in2_and(3 downto 0) => (others => numB_multiplicador(0)), -- Copia o bit 0 de B para todos os bits
        saida_and => parcial_0
    );

-- Multiplicacao do bit B1 de B com A (deslocado 1 bit a esquerda)
and_1 : porta_and 
    port map (
        in1_and(3 downto 1) => numA_multiplicador(2 downto 0), -- Desloca o numero A 1 bit para a esquerda
        in1_and(0) => '0',
        in2_and(3 downto 0) => (others => numB_multiplicador(1)), -- Copia o bit 1 de B para todos os bits
        saida_and => parcial_1
    );

-- Multiplicacao do bit B2 de B com A (deslocado 2 bits a esquerda)
and_2 : porta_and 
    port map (
        in1_and(3 downto 2) => numA_multiplicador(1 downto 0), -- Desloca o numero A 2 bits para a esquerda
        in1_and(1 downto 0) => (others => '0'),
        in2_and(3 downto 0) => (others => numB_multiplicador(2)),
        saida_and => parcial_2
    );

-- Multiplicacao do bit B3 de B com A (deslocado 3 bits a esquerda)
and_3 : porta_and 
    port map (
        in1_and(3) => numA_multiplicador(0), -- Desloca o numero A 3 bits para a esquerda
        in1_and(2 downto 0) => (others => '0'),
        in2_and(3 downto 0) => (others => numB_multiplicador(3)),
        saida_and => parcial_3
    );

    
    -- Soma dos resultados parciais: parcial_0 + parcial_1 = parcial_4
    soma_1 : somador_4_bits 
        port map (
            numA_somador => parcial_0,
            numB_somador => parcial_1,
            resultado_somador => parcial_4
        );
    
    -- Soma dos resultados parciais: parcial_2 + parcial_3 = parcial_5
    soma_2 : somador_4_bits 
        port map (
            numA_somador => parcial_2,
            numB_somador => parcial_3,
            resultado_somador => parcial_5
        );
    
    -- Soma final: parcial_4 + parcial_5 = resultado_multiplicador
    resultado : somador_4_bits 
        port map (
            numA_somador => parcial_4,
            numB_somador => parcial_5,
            resultado_somador => resultado_multiplicador
        );

end comportamento;
