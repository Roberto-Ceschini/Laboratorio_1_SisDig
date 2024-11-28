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



type estado_type is (receber_A, receber_B, mostrar_res);
signal estado, proximo_estado : estado_type;
signal numeroIntermediario, a3, a2, a1, a0, b3, b2, b1, b0, z3, z2, z1, z0 : UNSIGNED (3 downto 0);

begin

numeros : entity work.Numeros_teclado(comportamento)
    port map (codigo_teclado => codigo_teclado, a0 => numeroIntermediario(3), a1 => numeroIntermediario(2), a2 => numerointermediario(1), a3 => numerointermediario(0));

seletor : entity work.SeletorOperacao(Behavioral)
    port map (A3 => a3, A2 => a2, A1 => a1, A0 => a0, 
                B3 => b3, B2 => b2, B1 => b1, B0 => b0,
                seletor => operacao,
                Z7 => z7, Z6 => z6, Z5 => z5, Z4 => z4, Z3 => z3, Z2 => z2, Z1 => z1, Z0 => z0);


    process(codigo_teclado)
        begin
            if codigo_teclado = "11111111" then
                estado <= proximo_estado;
            end if;
        end process;
        
    process(estado)
        begin
            case estado is
                when receber_A =>
                    a3 <= numeroIntermediario(0)
                    a2 <= numeroIntermediario(1)
                    a1 <= numeroIntermediario(2)
                    a0 <= numeroIntermediario(3)
                    proximo_estado <= receber_B;
                
                when receber_B =>
                    b3 <= numeroIntermediario(0)
                    b2 <= numeroIntermediario(1)
                    b1 <= numeroIntermediario(2)
                    b0 <= numeroIntermediario(3)
                    proximo_estado <= mostrar_res
        
                when mostrar_res =>
                    z0 <= z0
                    z1 <= z1
                    z2 <= z2
                    z3 <= z3
                    z4 <= z4
                    z5 <= z5
                    z6 <= z6
                    z7 <= z7
            end case;
    end process;

                    
end comportamento;