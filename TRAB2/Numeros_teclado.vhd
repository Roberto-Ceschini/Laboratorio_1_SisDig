library IEEE;
use IEEE.STD_lOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Numeros_teclado is
    Port (
        codigo_teclado : in STD_LOGIC_VECTOR(7 downto 0); -- Código do teclado (8 bits)
        a0, a1, a2, a3, b0, b1, b2, b3: out UNSIGNED (3 downto 0)       -- Saídas como UNSIGNED
    );
end Numeros_teclado;

architecture Behavioral of Numeros_teclado is
    -- Tipo para armazenar os números em UNSIGNED
    type BCD_Array is array (0 to 7) of UNSIGNED(3 downto 0);

    -- Sinal para guardar os números em UNSIGNED
    signal numeros : BCD_Array := (others => (others => '0')); 

    -- Contador para monitorar a posição atual
    signal contador_enter : integer := 0;
    signal auxiliar : std_logic:='0';

begin

    process(codigo_teclado) -- 0000 0000 0000 0000
    begin
        if codigo_teclado = "11111111" then
            auxiliar <= '1';
            contador_enter <= contador_enter + 1;

        elsif contador_enter = 0 then

            -- Desloca os números para a esquerda e armazena o novo no menos significativo
            numeros(0) <= numeros(1);
            numeros(1) <= numeros(2);
            numeros(2) <= numeros(3);
            numeros(3) <= UNSIGNED(codigo_teclado(3 downto 0)); -- Novo número entra na posição menos significativa

        elsif contador_enter = 1 then 
            numeros(4) <= numeros(5);
            numeros(5) <= numeros(6);
            numeros(6) <= numeros(7);
            numeros(7) <= UNSIGNED(codigo_teclado(3 downto 0)); -- Novo número entra na posição menos significativa    
            
        end if;
    end process;

    -- Saídas separadas para os números em UNSIGNED
    a0 <= numeros(3);
    a1 <= numeros(2);
    a2 <= numeros(1);
    a3 <= numeros(0);

end Behavioral;
