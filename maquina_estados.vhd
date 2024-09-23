library IEEE;
use IEEE.std_logic_1164.all;

entity maquina_estados is 

    port (
        clck, rst, botao : in std_logic;
        switch : in std_logic_vector (3 downto 0);
        leds_direita, leds_esquerda : out std_logic_vector (3 downto 0);

    );

end maquina_estados;

architecture comportamento of maquina_estados is

    component ula is
        port (
            numA_ula, numB_ula : in std_logic_vector (3 downto 0); --Entradas: numeroA (4 bits) e numeroB (4 bits)
            seletor_ula : in std_logic_vector (2 downto 0); --Entrada: Seleciona a operacao que a ula deve realizar (4 bits)
            resultado_ula : out std_logic_vector (3 downto 0) --Saida: Resultado da operacao dada pelo seletor (4 bits)
        );
    end component;

    type estado is (receber_a, receber_b, receber_op, show_and, show_or, show_not, show_xor, show_soma, show_subtracao, show_multiplicacao, show_complemento_2);

    signal estadoAtual : estado;
    signal entrada_ula, num_a, num_b, operacao, resultado_ula : std_logic_vector (3 downto 0);

    begin

        u_ula : ula port map (
            numA_ula => num_a,
            numB_ula => num_b,
            seletor_ula => entrada_ula,
            resultado_ula => resultado_ula
        );

        controller: process (clck)
            begin 
            if clck'event and clck = '1' then
                if rst = '1' then 
                    estadoAtual <= receber_a;
                else
                    
                case estadoAtual is
                    when receber_a => --recebe o numero A
                        if botao = '1' then
                            num_a <= switch;
                            estadoAtual <= receber_b;
                        elsif botao = '0' then
                            estadoAtual <= receber_a;
                        end if;              
                        
                    when receber_b =>
                        if botao = '1' then
                            num_b <= switch;
                            estadoAtual <= receber_op;
                        elsif botao = '0' then
                            estadoAtual <= receber_b;
                    end if;              
                    
                    when receber_op =>
                        if botao = '1' then
                            operacao <= switch;
                            if operacao = '0000' then
                                estadoAtual <= show_and;
                    
                    when show_and =>
                                --contador
                                entrada_ula <= '000';
                                leds_direita <= resultado_ula;

                end if;              
                
                        estadoAtual <= receber_op;
                end case;

                end if;

            end if; 
        end process;           
                    

    end comportamento;
