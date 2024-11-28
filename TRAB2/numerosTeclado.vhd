library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Numeros_teclado is
    Port (
        codigo_teclado : in STD_LOGIC_VECTOR(7 downto 0); -- Código do teclado (8 bits)
        a0, a1, a2, a3: out UNSIGNED (3 downto 0)       -- Saídas como UNSIGNED
    );
end Numeros_teclado;

architecture Behavioral of Numeros_teclado is
    -- Tipo para armazenar os números em UNSIGNED
    type BCD_Array is array (0 to 3) of UNSIGNED(3 downto 0);

    -- Sinal para guardar os números em UNSIGNED
    signal numeros : BCD_Array := (others => (others => '0')); 

    -- Contador para monitorar a posição atual
    signal contador : integer range 0 to 4 := 0;
    signal auxiliar : std_logic;

begin

    process(codigo_teclado)
    begin
        if codigo_teclado = "11111111" then
            auxiliar <= '1';

        elsif auxiliar = '0' then

            -- Desloca os números para a esquerda e armazena o novo no menos significativo
            numeros(0) <= numeros(1);
            numeros(1) <= numeros(2);
            numeros(2) <= numeros(3);
            numeros(3) <= UNSIGNED(codigo_teclado(3 downto 0)); -- Novo número entra na posição menos significativa
            
        end if;
    end process;

    -- Saídas separadas para os números em UNSIGNED
    a0 <= numeros(3);
    a1 <= numeros(2);
    a2 <= numeros(1);
    a3 <= numeros(0);

end Behavioral;
