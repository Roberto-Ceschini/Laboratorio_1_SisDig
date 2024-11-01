library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ula is
    port (
        A3, A2, A1, A0 : in UNSIGNED (3 downto 0);
        B3, B2, B1, B0 : in UNSIGNED (3 downto 0);
        seletor_ula : in STD_LOGIC;
        Z7, Z6, Z5, Z4, Z3, Z2, Z1, Z0 : out UNSIGNED (3 downto 0)
    );
end ula;

architecture Behavioral of ula is

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

    signal Z0_soma, Z1_soma, Z2_soma, Z3_soma, Z4_soma : UNSIGNED (3 downto 0);
    signal Z0_mult, Z1_mult, Z2_mult, Z3_mult, Z4_mult, Z5_mult, Z6_mult, Z7_mult : UNSIGNED (3 downto 0);

begin

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

    -- Seleção das saídas com base no seletor_ula, um `with select` para cada saída
    with seletor_ula select
        Z0 <= Z0_soma when '0',
              Z0_mult when '1',
              "0000" when others;

    with seletor_ula select
        Z1 <= Z1_soma when '0',
              Z1_mult when '1',
              "0000" when others;

    with seletor_ula select
        Z2 <= Z2_soma when '0',
              Z2_mult when '1',
              "0000" when others;

    with seletor_ula select
        Z3 <= Z3_soma when '0',
              Z3_mult when '1',
              "0000" when others;

    with seletor_ula select
        Z4 <= Z4_soma when '0',
              Z4_mult when '1',
              "0000" when others;

    with seletor_ula select
        Z5 <= Z5_mult when '1',
              "0000" when others;

    with seletor_ula select
        Z6 <= Z6_mult when '1',
              "0000" when others;

    with seletor_ula select
        Z7 <= Z7_mult when '1',
              "0000" when others;

end Behavioral;
