library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_half_adder is
end tb_half_adder;

architecture sim of tb_half_adder is

    signal a : std_logic := '0';
    signal b : std_logic := '0';  
    signal sum : std_logic;
    signal carry : std_logic;
    constant step : time := 10 ns;

begin
    uut : entity work.half_adder
        port map (
            a     => a,
            b     => b,
            sum   => sum,
            carry => carry
        );
    stimulus : process
    begin
        a <= '0';
        b <= '0';
        wait for step;

        a <= '0';
        b <= '1';
        wait for step;

        a <= '1';
        b <= '0';
        wait for step;

        a <= '1';
        b <= '1';
        wait for step;

        wait;
    end process;

end sim;