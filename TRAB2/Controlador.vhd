library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controlador is
    port (  
        codigo_teclado : in std_logic_vector (7 downto 0);
        a0, a1, a2, a3, b0, b1, b2, b3 : out std_logic_vector (3 downto 0);
    );
end controlador;