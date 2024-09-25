library IEEE;
use IEEE.std_logic_1164.all;

entity prolongador_clock is

    port(

        clk : in std_logic;
        clk_prolongado : out std_logic;
        );

    end prolongador_clock;

architecture Behavioral of prolongador_clock is

signal contador: integer: = 0;
signal sinal_clk: std_logic: = '0';

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if contador = 99999999 then
                sinal_clk = not sinal_clk;
                contador <= 0;
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;

    clk_prolongado <= sinal_clk;

end Behavioral;
