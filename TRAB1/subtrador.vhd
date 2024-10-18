library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subtrador is

    port (
        numA_subtrador, numB_subtrador : in std_logic_vector (3 downto 0); --Entradas: NumeroA (4 bits), numeroB (4 bits). Valor MAXIMO para o numeroB 0111 binario >> 7 decimal
        resultado_subtrador : out std_logic_vector (3 downto 0) --Saida: Resultado (4 bits)
    );

end subtrador;

architecture comportamento of subtrador is --Funcao: Realizar a operacao aritmetica de subtracao entre o numeroA e o numeroB (numA - numB)

    --Inicio pre-ambulo
    component complemento_2 is 
        Port (
            entrada_complementador : in  STD_LOGIC_VECTOR (3 downto 0); -- Entrada do complemento a 2 (4 bits)
            saida_complementador : out  STD_LOGIC_VECTOR (3 downto 0) -- Saida do complemento a 2 (4 bits)
        );
    end component;

    component somador_4_bits is
        Port(   
            
            numA_somador, numB_somador : in  std_logic_vector (3 downto 0); --Entrada do somador (4 bits)
            resultado_somador : out  std_logic_vector (3 downto 0)); -- Saida do somador (4 bits)
            
        end component;

    signal numB_negativo : std_logic_vector (3 downto 0); --Resultado intermediario do subtrador

    --Fim pre-ambulo

    begin

        --Complementa o numero B
        complementar_numB : complemento_2 port map (entrada_complementador => numB_subtrador, saida_complementador => numB_negativo);
        
        --Subtrai Numero A do numero B
        subtrair : somador_4_bits port map (numA_somador => numA_subtrador, numB_somador => numB_negativo, resultado_somador => resultado_subtrador);
    
    end comportamento;