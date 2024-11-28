library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controlador is
    port (  
        codigo_teclado : in std_logic_vector (7 downto 0); -- entradas do teclado
        clk : in std_logic;
        operacao : in std_logic;
        a0, a1, a2, a3, b0, b1, b2, b3 : out UNSIGNED (3 downto 0); --numeros A e B (serao exibidos no display)
        z0, z1, z2, z3, z4, z5, z6, z7 : out UNSIGNED (3 downto 0) -- saida dos resultados
    );

end controlador;

architecture comportamento of controlador is

    begin

end comportamento;