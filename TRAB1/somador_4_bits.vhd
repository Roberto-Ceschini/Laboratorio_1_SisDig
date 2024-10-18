library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador_4_bits is
Port(   
    
    numA_somador, numB_somador : in  STD_LOGIC_vECTOR (3 downto 0); --Entradas: numero A (4 bits) e numero B (4 bits)
    resultado_somador : out  STD_LOGIC_vECTOR (3 downto 0)); -- Saidas: resultado da soma aritimetica das entradas (4 bits)
    
end somador_4_bits;

architecture comportamento of somador_4_bits is -- Funcao: Realizar a Soma de dois numeros de 4 bits sem Overflow. Resultado máximo é o número 1111 binario >> 15 decimal

signal c1, c2, c3 : STD_LOGIC; --Ligacao entre carryIn e CarryOut internos do somador de 4 bits.

component somador_completo is --Componente somador completo de 1 bit
Port ( 

    bit_numA, bit_numB, cin : in std_logic; -- Entradas: numeroA (1 bit), numeroB (1 bit) e carryIn (1 bit)
    cout, bit_resultado : out std_logic); --Saidas: carryOut (1 bit) e bit_Resultado (1 bit)

end component;

begin

--Somador de 4 bits gerado por 4 somadores completos de 1 bit
somador_1 : somador_completo PORT MAP (bit_numA=>numA_somador(0), bit_numB=>numB_somador(0), cin=> '0',
bit_resultado=>resultado_somador(0), cout=>c1);

somador_2 : somador_completo PORT MAP (bit_numA=>numA_somador(1), bit_numB=>numB_somador(1), cin=>c1,
bit_resultado=>resultado_somador(1), cout=>c2);

somador_3 : somador_completo PORT MAP (bit_numA=>numA_somador(2), bit_numB=>numB_somador(2), cin=>c2,
bit_resultado=>resultado_somador(2), cout=>c3);

somador_4 : somador_completo PORT MAP (bit_numA=>numA_somador(3),bit_numB=>numB_somador(3), cin=>c3,
bit_resultado=>resultado_somador(3));

end comportamento;