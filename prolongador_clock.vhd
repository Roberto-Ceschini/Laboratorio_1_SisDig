library IEEE;
use IEEE.std_logic_1164.all;

entity prolongador_clock is
    port(
        clk : in std_logic;
        timer : out std_logic_vector(2 downto 0)
    );
end prolongador_clock;

architecture Behavioral of prolongador_clock is

    signal contador: integer := 1;
    signal contador2: integer range 0 to 4 := 0;

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if contador = 100000000 then
                contador <= 1;
                contador2 <= contador2 + 1;
            elsif contador2 = 4 then
                contador2 <= 0;
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;

    -- Atribuição da saída "timer" de acordo com o valor de contador2
    process(contador2)
    begin
        case contador2 is
            when 0 =>
                timer <= "000"; -- Mostrar número A
            when 1 =>
                timer <= "001"; -- Mostrar número B
            when 2 =>
                timer <= "010"; -- Mostrar Operacao
            when 3 =>
                timer <= "011"; -- Mostrar Resultado
            when 4 =>
                timer <= "100"; -- Mudar Estado
            when others =>
                timer <= "000";  -- Condição de fallback (não deveria acontecer)
        end case;
    end process;

end Behavioral;
