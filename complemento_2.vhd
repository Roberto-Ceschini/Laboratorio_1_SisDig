library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity complemento_2 is
    Port (
        entrada_complementador : in  STD_LOGIC_VECTOR (3 downto 0); -- Entrada do complemento a 2. Valor maximo 0111 binario >> 7 decimal (4 bits)
        saida_complementador: out  STD_LOGIC_VECTOR (3 downto 0) -- Saida do complemento a 2 (4 bits)
    );
end complemento_2;

architecture comportamento of complemento_2 is
    -- Componente "porta_not", realiza a operacao logica NOT bit a bit da entrada
    component porta_not is
        Port (
            entrada_not : in  STD_LOGIC_VECTOR (3 downto 0); -- Entrada do NOT (4 bits)
            saida_not : out  STD_LOGIC_VECTOR (3 downto 0)   -- Saída do NOT (4 bits)
        );
    end component;

    -- Componente "somador_4_bits", realiza a soma de dois numeros de 4 bits
    component somador_4_bits is
        Port(
            numA_somador, numB_somador : in  STD_LOGIC_VECTOR (3 downto 0); -- Entradas do somador (4 bits)
            resultado_somador : out  STD_LOGIC_VECTOR (3 downto 0)          -- Resultado da soma (4 bits)
        );
    end component;

    signal num_invertido : std_logic_vector(3 downto 0); -- Resultado intermediario do complemento a 2

begin
    -- Inverte o numero
    inversor : porta_not 
        port map (entrada_not => entrada_complementador, saida_not => num_invertido);

    -- Soma +1 ao numero invertido
    somador : somador_4_bits 
        port map (numA_somador => "0001", numB_somador => num_invertido, resultado_somador => saida_complementador);

end comportamento;
