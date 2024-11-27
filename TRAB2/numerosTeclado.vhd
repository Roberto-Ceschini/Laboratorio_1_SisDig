library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Numeros_teclado is
    Port (
        codigo_teclado : in STD_LOGIC_VECTOR(7 downto 0); -- Código do teclado (8 bits)
        a0, a1, a2, a3: out STD_LOGIC_VECTOR(3 downto 0); -- números em BCD
    );
end Numeros_teclado;

architecture Behavioral of Numeros_teclado is
    -- Tipo para armazenar os números em BCD
    type BCD_Array is array (0 to 3) of STD_LOGIC_VECTOR(3 downto 0);

    -- Sinal para guardar os números BCD
    signal numeros : BCD_Array := (others => (others => '0'));

    -- Contador para monitorar a posição atual
    signal contador : integer range 0 to 4 := 0;

begin

    process(codigo_teclado)
    begin
        if codigo_teclado = "11111111" then
            -- Código de parada: reseta os números e o contador
            numeros <= (others => (others => '0'));
            contador <= 0;
        else
            if contador < 4 then
                -- Preenche o array enquanto há espaço
                numeros(contador) <= codigo_teclado(3 downto 0);
                contador <= contador + 1;
            else
                -- Desloca os números para a esquerda e armazena o novo na última posição
                numeros(0) <= numeros(1);
                numeros(1) <= numeros(2);
                numeros(2) <= numeros(3);
                numeros(3) <= codigo_teclado(3 downto 0);
            end if;
        end if;
    end process;

    -- Saídas separadas para os números BCD
    a0 <= numeros(0);
    a1 <= numeros(1);
    a2 <= numeros(2);
    a3 <= numeros(3);

end Behavioral;
--vixi