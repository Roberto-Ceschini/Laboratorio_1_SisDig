library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador_4_bits is
Port(   
    
    numA_vetor, numB_vetor : in  STD_LOGIC_VECTOR (3 downto 0); --Entradas: dois vetores de 4 bits, numero A e numero B
    resultado_vetor : out  STD_LOGIC_VECTOR (3 downto 0)); -- Saidas: um vetor de 4 bits, resultado da soma aritimetica das entradas (numA + numB)
    
end somador_4_bits;

architecture comportamento of somador_4_bits is -- Função: Realizar a Soma de dois numeros de 4 bits sem Overflow. Resultado máximo é o número 1111 binario >> 15 decimal

signal c1, c2, c3 : STD_LOGIC; --Ligacao entre carryIn e CarryOut internos do somador de 4 bits.

component somador_completo is --Componente somador completo de 1 bit
Port ( 
    numA, numB, cin : in  STD_LOGIC;
    resultado, cout : out  STD_LOGIC);
end component;

begin

--Somador de 4 bits gerado por 4 somadores completos de 1 bit
somador_1 : somador_completo PORT MAP (numA=>numA_Vector(0), numB=>numB_Vector(0), cin=> '0',
resultado=>resultado_Vector(0), cout=>c1);

somador_2 : somador_completo PORT MAP (numA=>numA_Vector(1), numB=>numB_Vector(1), cin=>c1,
resultado=>resultado_Vector(1), cout=>c2);

somador_3 : somador_completo PORT MAP (numA=>numA_Vector(2), numB=>numB_Vector(2), cin=>c2,
resultado=>resultado_Vector(2), cout=>c3);

somador_4 : somador_completo PORT MAP (numA=>numA_Vector(3),numB=>numB_Vector(3), cin=>c3,
resultado=>resultado_Vector(3));

end comportamento