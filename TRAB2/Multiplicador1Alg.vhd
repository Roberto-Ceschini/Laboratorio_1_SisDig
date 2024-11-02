library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplicador1Alg is
    Port ( A : in  UNSIGNED (3 downto 0);          -- Entradas: Números A, B e CarryIn todos em BCD.
           B : in  UNSIGNED (3 downto 0);
           CarryIn : in  UNSIGNED (3 downto 0);
           Unidade : out  UNSIGNED (3 downto 0);   -- Saídas: Unidade e Dezena do resultado da multiplicação em BCD.
           Dezena : out  UNSIGNED (3 downto 0));
end Multiplicador1Alg;

architecture Behavioral of Multiplicador1Alg is

    signal parcial : UNSIGNED (7 downto 0);

begin

    parcial <= (A * B) + CarryIn; -- Sinal parcial recebe o resultado da multiplicação e adição em binário

    process(parcial)
    begin

        -- As saídas "Dezena" e "Unidade" são ajustadas de acordo com o valor de "parcial".
        if (parcial < 10) then
            Dezena <= "0000";
            Unidade <= to_unsigned(to_integer(parcial), 4);
        elsif (parcial < 20) then
            Dezena <= "0001";                                    -- Se o resultado estiver entre [10,20) a "Dezena" recebe "1" e é subtraído 10 de "parcial" 
            Unidade <= to_unsigned(to_integer(parcial) - 10, 4); -- para a "Unidade" ser armazenada corretamente. Segue com a mesma lógica para os demais IFs.
        elsif (parcial < 30) then                                
            Dezena <= "0010";
            Unidade <= to_unsigned(to_integer(parcial) - 20, 4);
        elsif (parcial < 40) then
            Dezena <= "0011";
            Unidade <= to_unsigned(to_integer(parcial) - 30, 4);
        elsif (parcial < 50) then
            Dezena <= "0100";
            Unidade <= to_unsigned(to_integer(parcial) - 40, 4);
        elsif (parcial < 60) then
            Dezena <= "0101";
            Unidade <= to_unsigned(to_integer(parcial) - 50, 4);
        elsif (parcial < 70) then
            Dezena <= "0110";
            Unidade <= to_unsigned(to_integer(parcial) - 60, 4);
        elsif (parcial < 80) then
            Dezena <= "0111";
            Unidade <= to_unsigned(to_integer(parcial) - 70, 4);
        elsif (parcial < 90) then
            Dezena <= "1000";
            Unidade <= to_unsigned(to_integer(parcial) - 80, 4);
		end if;
    end process;

end Behavioral;
