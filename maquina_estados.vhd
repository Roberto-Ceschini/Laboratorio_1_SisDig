library IEEE;
use IEEE.std_logic_1164.all;

entity maquina_estados is 

    port (
        clk, rst, botao : in std_logic;
        switch : in std_logic_vector (3 downto 0);
        leds_direita : out std_logic_vector (3 downto 0) := "0000";
        leds_esquerda : out std_logic_vector (3 downto 0)
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
            aux : in std_logic;
            clk : in std_logic;
            timer : out std_logic_vector (2 downto 0)
        );
    end component;

    --Define os estados da maquina de estados
    type estado is (receber_a, receber_b, receber_op, show_and, show_or, show_not, show_xor, show_soma, show_subtracao, show_multiplicacao, show_complemento_2);

    --SINAIS
    signal estadoAtual : estado; 
    signal num_a, num_b, operacao, resultado_ula : std_logic_vector (3 downto 0);
    signal entrada_ula : std_logic_vector (2 downto 0);
    signal timer : std_logic_vector (2 downto 0);
    signal aux : std_logic := '0';


    begin

        u_ula : ula port map (
            numA_ula => num_a,
            numB_ula => num_b,
            seletor_ula => entrada_ula,
            resultado_ula => resultado_ula
        );

         contador : prolongador_clock port map (
            aux => aux,
            clk => clk,
            timer => timer
        );

        controller: process (clk)
        begin 
            if clk'event and clk = '1' then
                if rst = '1' then 
                    estadoAtual <= receber_a;
                    aux <= '0';
                else
                    
                    case estadoAtual is
                        when receber_a => --Estado recebe o numero A
                            leds_esquerda <= "1000";
                            if botao = '1' then
                                num_a <= switch;
                                estadoAtual <= receber_b;
                            elsif botao = '0' then
                                estadoAtual <= receber_a;
                            end if;
                        
                        --when intermediario1 =>
                        --        if botao = '0' then
                        --            estadoAtual <= receber_b; SE FOR TIRAR O COMENTARIO DISSO, ADD OS ESTADOS LA EM CIMA
--                          end if;

                        when receber_b => --Estado recebe o numero B
                                leds_esquerda <= "0100";
                            if botao = '1' then
                                num_b <= switch;
                                estadoAtual <= receber_op;
                            elsif botao = '0' then
                                estadoAtual <= receber_b;
                            end if;   
                        
                      --  when intermediario2 =>
                       --     if botao = '0' then
--                          estadoAtual <= receber_op;
                     --       end if;

                        when receber_op => --Estado recebe operacao
                            leds_esquerda <= "0010";
                            if botao = '1' then
                                operacao <= switch;

                                if operacao = "0000" then
                                    estadoAtual <= show_and; --Operacao inicial AND

                                elsif operacao = "0001" then --Operacao inicial OR
                                    estadoAtual <= show_or;

                                elsif operacao = "0010" then --Operacao inicial NOT
                                    estadoAtual <= show_not;

                                elsif operacao = "0011" then --Operacao inicial XOR
                                    estadoAtual <= show_xor; 

                                elsif operacao = "0100" then --Operacao inicial SOMADOR
                                    estadoAtual <= show_soma;

                                elsif operacao = "0101" then --Operacao inicial MULTIPLICADOR
                                    estadoAtual <= show_multiplicacao;

                                elsif operacao = "0110" then --Operacao inicial SUBTRADOR
                                    estadoAtual <= show_subtracao;

                                elsif operacao = "0111" then --Operacao inicial COMPLEMENTO_2
                                    estadoAtual <= show_complemento_2;   
                                end if;    
                            end if;   
                            
                        when show_and => 
                            aux <= '1';
                            entrada_ula <= "000"; --seleciona a operacao AND na ula

                            if timer = "000" then --mostra o numero A por 2 segundos
                                leds_direita <= num_a;
                                leds_esquerda <= "1000";

                            elsif timer = "001" then --mostra o numero B por 2 segundos
                                leds_direita <= num_b;
                                leds_esquerda <= "0100";

                            elsif timer = "010" then --mostra a operacao por 2 segundos
                                leds_direita <= "0000"; 
                                leds_esquerda <= "0010";

                            elsif timer = "011" then --mostra o resultado da ula por 2 segundos
                                leds_direita <= resultado_ula;
                                leds_esquerda <= "0001";

                            elsif timer = "100" then --muda o estado
                                estadoAtual <= show_or;
                            end if;

                        when show_or =>
                            aux <= '1';
                            entrada_ula <= "001"; --seleciona a operacao OR na ula

                            if timer = "000" then --mostra o numero A por 2 segundos
                                leds_direita <= num_a;
                                leds_esquerda <= "1000";

                            elsif timer = "001" then --mostra o numero B por 2 segundos
                                leds_direita <= num_b;
                                leds_esquerda <= "0100";

                            elsif timer = "010" then --mostra a operacao por 2 segundos
                                leds_direita <= "0001"; 
                                leds_esquerda <= "0010";

                            elsif timer = "011" then --mostra o resultado da ula por 2 segundos
                                leds_direita <= resultado_ula;
                                leds_esquerda <= "0001";

                            elsif timer = "100" then --muda o estado
                                estadoAtual <= show_not;
                            end if;

                        when show_not =>
                            aux <= '1';
                            entrada_ula <= "010"; --seleciona a operacao NOT na ula

                            if timer = "000" then --mostra o numero A por 2 segundos
                                leds_direita <= num_a;
                                leds_esquerda <= "1000";

                            elsif timer = "001" then --mostra o numero B por 2 segundos
                                leds_direita <= num_b;
                                leds_esquerda <= "0100";

                            elsif timer = "010" then --mostra a operacao por 2 segundos
                                leds_direita <= "0010"; 
                                leds_esquerda <= "0010";

                            elsif timer = "011" then --mostra o resultado da ula por 2 segundos
                                leds_direita <= resultado_ula;
                                leds_esquerda <= "0001";

                            elsif timer = "100" then --muda o estado
                                estadoAtual <= show_xor;
                            end if;
                        
                        when show_xor =>
                            aux <= '1';
                            entrada_ula <= "011"; --seleciona a operacao XOR na ula

                            if timer = "000" then --mostra o numero A por 2 segundos
                                leds_direita <= num_a;
                                leds_esquerda <= "1000";

                            elsif timer = "001" then --mostra o numero B por 2 segundos
                                leds_direita <= num_b;
                                leds_esquerda <= "0100";

                            elsif timer = "010" then --mostra a operacao por 2 segundos
                                leds_direita <= "0011"; 
                                leds_esquerda <= "0010";

                            elsif timer = "011" then --mostra o resultado da ula por 2 segundos
                                leds_direita <= resultado_ula;
                                leds_esquerda <= "0001";

                            elsif timer = "100" then --muda o estado
                                estadoAtual <= show_soma;
                            end if;

                        when show_soma =>
                            aux <= '1';
                            entrada_ula <= "100"; --seleciona a operacao SOMA na ula

                            if timer = "000" then --mostra o numero A por 2 segundos
                                leds_direita <= num_a;
                                leds_esquerda <= "1000";

                            elsif timer = "001" then --mostra o numero B por 2 segundos
                                leds_direita <= num_b;
                                leds_esquerda <= "0100";

                            elsif timer = "010" then --mostra a operacao por 2 segundos
                                leds_direita <= "0100"; 
                                leds_esquerda <= "0010";

                            elsif timer = "011" then --mostra o resultado da ula por 2 segundos
                                leds_direita <= resultado_ula;
                                leds_esquerda <= "0001";

                            elsif timer = "100" then --muda o estado
                                estadoAtual <= show_multiplicacao;
                            end if;

                        when show_multiplicacao =>
                            aux <= '1';
                            entrada_ula <= "101"; --seleciona a operacao MULTIPLICACAO na ula

                            if timer = "000" then --mostra o numero A por 2 segundos
                                leds_direita <= num_a;
                                leds_esquerda <= "1000";

                            elsif timer = "001" then --mostra o numero B por 2 segundos
                                leds_direita <= num_b;
                                leds_esquerda <= "0100";

                            elsif timer = "010" then --mostra a operacao por 2 segundos
                                leds_direita <= "0101"; 
                                leds_esquerda <= "0010";

                            elsif timer = "011" then --mostra o resultado da ula por 2 segundos
                                leds_direita <= resultado_ula;
                                leds_esquerda <= "0001";

                            elsif timer = "100" then --muda o estado
                                estadoAtual <= show_subtracao;
                            end if;

                        when show_subtracao =>
                            aux <= '1';
                            entrada_ula <= "110"; --seleciona a operacao SUBTRACAO na ula

                                if timer = "000" then --mostra o numero A por 2 segundos
                                    leds_direita <= num_a;
                                    leds_esquerda <= "1000";

                                elsif timer = "001" then --mostra o numero B por 2 segundos
                                    leds_direita <= num_b;
                                    leds_esquerda <= "0100";

                                elsif timer = "010" then --mostra a operacao por 2 segundos
                                    leds_direita <= "0110"; 
                                    leds_esquerda <= "0010";

                                elsif timer = "011" then --mostra o resultado da ula por 2 segundos
                                    leds_direita <= resultado_ula;
                                    leds_esquerda <= "0001";

                                elsif timer = "100" then --muda o estado
                                    estadoAtual <= show_complemento_2;
                                end if;

                        when show_complemento_2 =>
                            aux <= '1';
                            entrada_ula <= "111"; --seleciona a operacao COMPLEMENTO_2 na ula

                            if timer = "000" then --mostra o numero A por 2 segundos
                                leds_direita <= num_a;
                                leds_esquerda <= "1000";

                            elsif timer = "001" then --mostra o numero B por 2 segundos
                                leds_direita <= num_b;
                                leds_esquerda <= "0100";

                            elsif timer = "010" then --mostra a operacao por 2 segundos
                                leds_direita <= "0111"; 
                                leds_esquerda <= "0010";

                            elsif timer = "011" then --mostra o resultado da ula por 2 segundos
                                leds_direita <= resultado_ula;
                                leds_esquerda <= "0001";

                            elsif timer = "100" then --muda o estado
                                estadoAtual <= show_and;
                            end if;

                    end case;

                end if;

            end if; 
        end process;           

    end comportamento;
