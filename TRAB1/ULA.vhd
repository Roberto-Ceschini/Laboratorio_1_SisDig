library IEEE;
use IEEE.std_logic_1164.all;

entity ula is
    port (
        numA_ula, numB_ula : in std_logic_vector (3 downto 0); --Entradas: numeroA (4 bits) e numeroB (4 bits)
        seletor_ula : in std_logic_vector (2 downto 0); --Entrada: Seleciona a operacao que a ula deve realizar (3 bits)
        resultado_ula : out std_logic_vector (3 downto 0) --Saida: Resultado da operacao dada pelo seletor (4 bits)
    );
end ula;

architecture comportamento of ULA is --Funcao: ULA.

    --sinais intermediários
    signal saida_and, saida_or, saida_not, saida_xor, saida_complementador : std_logic_vector(3 downto 0);
    signal resultado_somador, resultado_multiplicador, resultado_subtrador : std_logic_vector(3 downto 0);

    -- Componente porta_and
    component porta_and is
        port (
            in1_and, in2_and : in std_logic_vector(3 downto 0);
            saida_and : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Componente porta_or
    component porta_or is
        port (
            in1_or, in2_or : in std_logic_vector(3 downto 0);
            saida_or : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Componente porta_not
    component porta_not is
        port (
            entrada_not : in std_logic_vector(3 downto 0);
            saida_not : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Componente porta_xor
    component porta_xor is
        port (
            in1_xor, in2_xor : in std_logic_vector(3 downto 0);
            saida_xor : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Componente somador_4_bits
    component somador_4_bits is
        port (
            numA_somador, numB_somador : in std_logic_vector(3 downto 0);
            resultado_somador : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Componente multiplicador
    component multiplicador is
        port (
            numA_multiplicador, numB_multiplicador : in std_logic_vector(3 downto 0);
            resultado_multiplicador : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Componente subtrador
    component subtrador is
        port (
            numA_subtrador, numB_subtrador : in std_logic_vector(3 downto 0);
            resultado_subtrador : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Componente complemento_2
    component complemento_2 is
        port (
            entrada_complementador : in std_logic_vector(3 downto 0);
            saida_complementador : out std_logic_vector(3 downto 0)
        );
    end component;

begin

    -- Instanciação dos componentes
    u_and : porta_and
        port map (
            in1_and => numA_ula,
            in2_and => numB_ula,
            saida_and => saida_and
        );

    u_or : porta_or
        port map (
            in1_or => numA_ula,
            in2_or => numB_ula,
            saida_or => saida_or
        );

    u_not : porta_not
        port map (
            entrada_not => numA_ula,
            saida_not => saida_not
        );

    u_xor : porta_xor
        port map (
            in1_xor => numA_ula,
            in2_xor => numB_ula,
            saida_xor => saida_xor
        );

    u_somador : somador_4_bits
        port map (
            numA_somador => numA_ula,
            numB_somador => numB_ula,
            resultado_somador => resultado_somador
        );

    u_multiplicador : multiplicador
        port map (
            numA_multiplicador => numA_ula,
            numB_multiplicador => numB_ula,
            resultado_multiplicador => resultado_multiplicador
        );

    u_subtrador : subtrador
        port map (
            numA_subtrador => numA_ula,
            numB_subtrador => numB_ula,
            resultado_subtrador => resultado_subtrador
        );
    
    u_complementador : complemento_2
        port map (
            entrada_complementador => numB_ula,
            saida_complementador => saida_complementador
        );

    -- Seleção do resultado com base no seletor_ula
    with seletor_ula select

        resultado_ula <= saida_and when "000",
                         saida_or when "001",
                         saida_not when "010", --Not do numA_ula
                         saida_xor when "011",
                         resultado_somador when "100",
                         resultado_multiplicador when "101",
                         resultado_subtrador when "110",
                         saida_complementador when "111", --complemento do numB_ula
                         "0000" when others;

end comportamento;
