library IEEE;
use IEEE.std_logic_1164.all;

entity maquina_estados is 

    port (
        clk, rst, botao : in std_logic;
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

    component prolongador_clock is
        port (
            clk : in std_logic;
            timer : out std_logic_vector (2 downto 0);
        );
    end component;

    type estado is (receber_a, receber_b, receber_op, show_and, show_or, show_not, show_xor, show_soma, show_subtracao, show_multiplicacao, show_complemento_2);

    signal estadoAtual : estado;
    signal entrada_ula, num_a, num_b, operacao, resultado_ula : std_logic_vector (3 downto 0);
    signal entrada_ula : std_logic_vector (2 downto 0);
    signal timer : std_logic_vector (2 downto 0);

    begin

        u_ula : ula port map (
            numA_ula => num_a,
            numB_ula => num_b,
            seletor_ula => entrada_ula,
            resultado_ula => resultado_ula
        );

         : prolongador_clock port map (
            clk => clk,
            timer => timer
        );

        controller: process (clk)
        begin 
            if clck'event and clck = '1' then
                if rst = '1' then 
                    estadoAtual <= receber_a;
                else
                    
                    case estadoAtual is
                        when receber_a => --Estado recebe o numero A
                            if botao = '1' then
                                num_a <= switch;
                                estadoAtual <= receber_b;
                            elsif botao = '0' then
                                estadoAtual <= receber_a;
                            end if;              

                        when receber_b => --Estado recebe o numero B
                            if botao = '1' then
                                num_b <= switch;
                                estadoAtual <= receber_op;
                            elsif botao = '0' then
                                estadoAtual <= receber_b;
                            end if;              

                        when receber_op => --Estado recebe operacao
                            if botao = '1' then
                                operacao <= switch;
                                if operacao = '0000' then
                                    estadoAtual <= show_and;
                                elsif operacao = '0001' then
                                    estadoAtual <= show_or;
                                elsif operacao = '0010' then
                                    estadoAtual <= show_not;
                                elsif operacao = '0011' then
                                    estadoAtual <= show_xor; 
                                elsif operacao = '0100' then
                                    estadoAtual <= show_soma;
                                elsif operacao = '0101' then
                                    estadoAtual <= show_multiplicacao;
                                elsif operacao = '0110' then
                                    estadoAtual <= show_subtracao;
                                elsif operacao = '0111' then
                                    estadoAtual <= show_complemento_2;   
                                end if;    
                            end if;   
                            
                        when show_and =>
                            entrada_ula <= '000';
                            if timer = '000' then
                                leds_direita <= num_a;
                                leds_esquerda <= '1000';
                            elsif timer = '001' then
                                leds_direita <= num_b;
                                leds_esquerda <= '0100';
                            elsif timer = '010' then
                                leds_direita <= '0000';
                                leds_esquerda <= '0010';
                            elsif timer = '011' then
                                leds_direita <= resultado_ula;
                                leds_esquerda <= '0001';
                            elsif timer = '100' then
                                estado_atual <= show_or;
                            end if;

                        when show_or =>
                            entrada_ula <= '001';
                            leds_direita <= resultado_ula;
                            estado_atual <= show_not;

                        when show_not =>
                            entrada_ula <= '010';
                            leds_direita <= resultado_ula;
                            estado_atual <= show_xor;
                    
                        when show_xor =>
                            entrada_ula <= '011';
                            leds_direita <= resultado_ula;
                            estado_atual <= show_soma;

                        when show_soma =>
                            entrada_ula <= '100';
                            leds_direita <= resultado_ula;
                            estado_atual <= show_multiplicacao;

                        when show_multiplicacao =>
                            entrada_ula <= '101';
                            leds_direita <= resultado_ula;
                            estado_atual <= show_subtracao;

                        when show_subtracao =>
                            entrada_ula <= '110';
                            leds_direita <= resultado_ula;
                            estado_atual <= show_complemento_2;

                        when show_complemento_2 =>
                            entrada_ula <= '111';
                            leds_direita <= resultado_ula;
                            estado_atual <= show_and;
                    end case;

                end if;

            end if; 
        end process;           

    end comportamento;

   --resultado_ula <= 
   --saida_and when "000", OP0
    -- saida_or when "001", OP1
    --saida_not when "010", --Not do numA_ula OP2
    --saida_xor when "011", OP3
    -- resultado_somador when "100", OP4
    --resultado_multiplicador when "101", OP5
    -- resultado_subtrador when "110", OP6
    -- saida_complementador when "111", --complemento do numB_ula OP7
    -- "0000" when others
    ---01010
