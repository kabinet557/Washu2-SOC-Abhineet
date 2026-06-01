library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_two_one_mux_en is
end tb_two_one_mux_en;

architecture sim of tb_two_one_mux_en is
	signal a, b, y,en,sel : std_logic;
begin
	uut : entity work.two_one_mux_en
        port map (
            a => a,
            b => b,
            y => y,
				sel =>sel,
				en => en
        );
	stimulus : process
    begin
			a<= '0'; b <= '0'; en <='0';sel <='1';
			wait for 10 ns;
        a <= '0'; b <= '1'; en <= '0';sel<='1';
        wait for 10 ns;

        a <= '1'; b <= '0';en <= '0';sel<='1';
        wait for 10 ns;

        a <= '1'; b <= '1';en <='0';sel<='1';
        wait for 10 ns;
		  a <= '0'; b <= '0'; en <='1';sel<='1';
        wait for 10 ns;

        a <= '0'; b <= '1'; en <= '1';sel<='1';
        wait for 10 ns;

        a <= '1'; b <= '0';en <= '1';sel<='1';
        wait for 10 ns;

        a <= '1'; b <= '1';en <='1';sel<='1';
        wait for 10 ns;
        wait;
    end process;
		  
end sim;