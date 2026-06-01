library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mod_counter is
end tb_mod_counter;

architecture sim of tb_mod_counter is

    signal clk    : std_logic := '0';
    signal reset  : std_logic := '1';
    signal enable : std_logic := '0';
    signal count  : std_logic_vector(7 downto 0);
	 signal tick : std_logic := '0';

    constant CLK_PERIOD : time := 10 ns;

begin
    clk <= not clk after CLK_PERIOD / 2;
    uut : entity work.mod_counter
		  generic map( N=>4
		  )
        port map (
            clk    => clk,
            reset  => reset,
            enable => enable,
            count  => count,
				tick =>tick
        );    
	 stimulus : process
    begin
        reset  <= '1';
        enable <= '0';
        wait for 5 * CLK_PERIOD;
        reset  <= '0';
        enable <= '1';
        wait for 12 * CLK_PERIOD;
        enable <= '0';
        wait for 6 * CLK_PERIOD;
        enable <= '1';
        wait for 4 * CLK_PERIOD;
        wait;
    end process;

end sim;