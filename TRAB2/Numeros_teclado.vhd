library IEEE;
use IEEE.STD_lOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Numeros_teclado is
    Port (
			clk, reset, ps2c, ps2d, rd_key_code, seletor: in std_logic;
        --codigo_teclado : in STD_LOGIC_VECTOR(7 downto 0); -- Código do teclado (8 bits)
        lz0, lz1, lz2, lz3, lz4, lz5, lz6, lz7 : out UNSIGNED (3 downto 0):="0000"      -- Saídas como UNSIGNED
    );
end Numeros_teclado;

architecture Behavioral of Numeros_teclado is
    
	 type estados is (receber_A0, receber_A1, receber_A2, receber_A3,
							receber_B0, receber_B1, receber_B2, receber_B3,
							mostrar_res);
	
	 signal estado : estados := receber_A0;
	 
	 signal limpar_teclado : std_logic;
	 signal teclado_vazio : std_logic; 
	 signal codigo_teclado : std_logic_vector (7 downto 0);
	 signal a0, a1, a2, a3, b0, b1, b2, b3 : UNSIGNED (3 downto 0):="0000";
	 signal z0, z1, z2, z3, z4, z5, z6, z7 : UNSIGNED (3 downto 0);
	 
	 begin
	 
	 teclado : entity work.kb_code(arch)
		port map ( clk => clk, reset => limpar_teclado, ps2d => ps2d, ps2c => ps2c,
						number_code => codigo_teclado, kb_buf_empty => teclado_vazio);
						
	 seletor1 : entity work.SeletorOperacao(behavioral)
		port map ( A3 => a3, A2 => a2, A1 => a1 , A0 => a0, 
        B3 => b3, B2 => b2, B1 => b1, B0 => b0, 
        seletor => seletor,
        Z7 => z7, Z6 => z6, Z5 => z5, Z4 => z4, Z3 => z3, Z2 => z2, Z1 => z1, Z0 => z0 
    );
	 
	 process (clk, reset)
	 begin
		if (clk'event and clk = '1') then
			limpar_teclado <= '0';
			case estado is
				when receber_A0 =>
					if codigo_teclado = "00001101" then --enter
						limpar_teclado <= '1';
						estado <= receber_B0;
					elsif teclado_vazio = '0' then
						a3 <= a2;
						a2 <= a1;
						a1 <= a0;
						a0 <= UNSIGNED(codigo_teclado(3 downto 0));					
						limpar_teclado <= '1';
						estado <= receber_A1;
					end if;
				
				when receber_A1 =>
					if codigo_teclado = "00001101" then --enter
						limpar_teclado <= '1';
						estado <= receber_B0;
					elsif teclado_vazio = '0' then
						a3 <= a2;
						a2 <= a1;
						a1 <= a0;
						a0 <= UNSIGNED(codigo_teclado(3 downto 0));
						limpar_teclado <= '1';
						estado <= receber_A2;
					end if;
					
				when receber_A2 =>
					if codigo_teclado = "00001101" then --enter
						limpar_teclado <= '1';
						estado <= receber_B0;
					elsif teclado_vazio = '0' then
						a3 <= a2;
						a2 <= a1;
						a1 <= a0;
						a0 <= UNSIGNED(codigo_teclado(3 downto 0));
						limpar_teclado <= '1';
						estado <= receber_A3;
					end if;
				
				when receber_A3 =>
					if codigo_teclado = "00001101" then --enter
						limpar_teclado <= '1';
						estado <= receber_B0;
					elsif teclado_vazio = '0' then
						a3 <= a2;
						a2 <= a1;
						a1 <= a0;
						a0 <= UNSIGNED(codigo_teclado(3 downto 0));					
						limpar_teclado <= '1';
					end if;
				
				when receber_B0 =>
					if codigo_teclado = "00001101" then --enter
						limpar_teclado <= '1';
						estado <= mostrar_res;
					elsif teclado_vazio = '0' then
						b3 <= b2;
						b2 <= b1;
						b1 <= b0;
						b0 <= UNSIGNED(codigo_teclado(3 downto 0));					
						limpar_teclado <= '1';
						estado <= receber_B1;
					end if;
				
				when receber_B1 =>
					if codigo_teclado = "00001101" then --enter
						limpar_teclado <= '1';
						estado <= mostrar_res;
					elsif teclado_vazio = '0' then
						b3 <= b2;
						b2 <= b1;
						b1 <= b0;
						b0 <= UNSIGNED(codigo_teclado(3 downto 0));										
						limpar_teclado <= '1';
						estado <= receber_B2;
					end if;
					
				when receber_B2 =>
					if codigo_teclado = "00001101" then --enter
						limpar_teclado <= '1';
						estado <= mostrar_res;
					elsif teclado_vazio = '0' then
						b3 <= b2;
						b2 <= b1;
						b1 <= b0;
						b0 <= UNSIGNED(codigo_teclado(3 downto 0));															
						limpar_teclado <= '1';
						estado <= receber_B3;
					end if;
					
				when receber_B3 =>
					if codigo_teclado = "00001101" then --enter
						limpar_teclado <= '1';
						estado <= mostrar_res;
					elsif teclado_vazio = '0' then
						b3 <= b2;
						b2 <= b1;
						b1 <= b0;
						b0 <= UNSIGNED(codigo_teclado(3 downto 0));													
						limpar_teclado <= '1';
					end if;
				when mostrar_res =>
					if codigo_teclado = "00001101" then --enter
							limpar_teclado <= '1';
							b3 <= "0000";
							b2 <= "0000";
							b1 <= "0000";
							b0 <= "0000";
							a3 <= "0000";
							a2 <= "0000";
							a1 <= "0000";
							a0 <= "0000";
							estado <= receber_A0;
							
					else
					
						lz0 <= z0;
						lz1 <= z1;
						lz2 <= z2;
						lz3 <= z3;
						lz4 <= z4;
						lz5 <= z5;
						lz6 <= z6;
						lz7 <= z7;
						
					end if;
				
			end case;
		end if;
			
	end process;
end Behavioral;
