library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SeletorOperacao is
    port (
        A3, A2, A1, A0 : in UNSIGNED (3 downto 0);      -- Entradas: Números "A" e "B" de 4 algarismos separados em 4 entradas onde cada algarismo está em BCD.
        B3, B2, B1, B0 : in UNSIGNED (3 downto 0);
        seletor : in STD_LOGIC;                         -- Entrada "seletor" onde é selecionada qual operação aritmética será realizada entre os números.
        Z7, Z6, Z5, Z4, Z3, Z2, Z1, Z0 : out UNSIGNED (3 downto 0)  -- Saída: Número "Z" de 8 algarismos separados em 8 saídas onde cada algarismo está em BCD.
    );
end SeletorOperacao;

architecture Behavioral of SeletorOperacao is
    
    component SomadorCompleto_BCD is
        Port ( A0, A1, A2, A3 : in UNSIGNED (3 downto 0);
               B0, B1, B2, B3 : in UNSIGNED (3 downto 0);
               CarryIn : in UNSIGNED (3 downto 0);
               Z0, Z1, Z2, Z3, Z4 : out UNSIGNED (3 downto 0));
    end component;

    component MultiplicadorCompleto_BCD is
        Port ( A0, A1, A2, A3 : in UNSIGNED (3 downto 0);
               B0, B1, B2, B3 : in UNSIGNED (3 downto 0);
               Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7 : out UNSIGNED (3 downto 0)
               );
    end component;

    -- Sinais intermediários para receberem a saída do somador e do multiplicador
    signal Z0_soma, Z1_soma, Z2_soma, Z3_soma, Z4_soma : UNSIGNED (3 downto 0);
    signal Z0_mult, Z1_mult, Z2_mult, Z3_mult, Z4_mult, Z5_mult, Z6_mult, Z7_mult : UNSIGNED (3 downto 0);

begin

    --====================== INSTANCIAÇÃO DO SOMADOR E DO MULTIPLICADOR ============================
    -- *Saídas das operações são ligadas aos sinais intermediários e será definido qual irá para a saída "Z" deste código depois. 
    soma : SomadorCompleto_BCD port map (
                A0 => A0,
                A1 => A1,
                A2 => A2,
                A3 => A3,
                B0 => B0,
                B1 => B1,
                B2 => B2,
                B3 => B3,
                CarryIn => "0000",
                Z0 => Z0_soma,
                Z1 => Z1_soma,
                Z2 => Z2_soma,
                Z3 => Z3_soma,
                Z4 => Z4_soma
    );

    multiplicacao : MultiplicadorCompleto_BCD port map (
                A0 => A0,
                A1 => A1,
                A2 => A2,
                A3 => A3,
                B0 => B0,
                B1 => B1,
                B2 => B2,
                B3 => B3,
                Z0 => Z0_mult,
                Z1 => Z1_mult,
                Z2 => Z2_mult,
                Z3 => Z3_mult,
                Z4 => Z4_mult,
                Z5 => Z5_mult,
                Z6 => Z6_mult,
                Z7 => Z7_mult
    );


    -- Saída "Z" recebe os valores de soma ou multiplicação dependendo do valor do seletor.
    Z0 <= Z0_mult when seletor = '1' else Z0_soma;
    Z1 <= Z1_mult when seletor = '1' else Z1_soma;
    Z2 <= Z2_mult when seletor = '1' else Z2_soma;
    Z3 <= Z3_mult when seletor = '1' else Z3_soma;
    Z4 <= Z4_mult when seletor = '1' else Z4_soma;
    Z5 <= Z5_mult when seletor = '1' else "0000";
    Z6 <= Z6_mult when seletor = '1' else "0000";
    Z7 <= Z7_mult when seletor = '1' else "0000";

end Behavioral;
