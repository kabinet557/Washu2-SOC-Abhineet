library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ram8x8 is
end tb_ram8x8;

architecture sim of tb_ram8x8 is

    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal we : std_logic := '0';
    signal addr : std_logic_vector(2 downto 0) := (others => '0');
    signal data_in  : std_logic_vector(7 downto 0) := (others => '0');
    signal data_out : std_logic_vector(7 downto 0);
    signal valid : std_logic;
    constant CLK_PERIOD : time := 10 ns;

begin
    clk <= not clk after CLK_PERIOD / 2;
    uut : entity work.ram8x8
        port map (
            clk => clk,
            reset => reset,
            we => we,
            addr => addr,
            data_in => data_in,
            data_out => data_out,
            valid => valid
        );
    stimulus : process
    begin
        reset <= '1';
        we <= '0';
        wait for 2 * CLK_PERIOD;
        reset <= '0';
        wait for CLK_PERIOD;
        
        wait until rising_edge(clk);
        we <= '1'; addr <= "000"; data_in <= x"AA";

        wait until rising_edge(clk);
        we <= '1'; addr <= "001"; data_in <= x"BB";

        wait until rising_edge(clk);
        we <= '1'; addr <= "010"; data_in <= x"CC";

        wait until rising_edge(clk);
        we <= '1'; addr <= "011"; data_in <= x"DD";

        wait until rising_edge(clk);
        we <= '0'; addr <= "000"; 

        wait until rising_edge(clk);
        addr <= "001";
        wait for 1 ns; 
        assert data_out = x"AA" and valid = '1' report "FAIL: read addr 0" severity error;

        wait until rising_edge(clk);
        addr <= "010";
        wait for 1 ns;
        assert data_out = x"BB" and valid = '1' report "FAIL: read addr 1" severity error;

        wait until rising_edge(clk);
        addr <= "011";
        wait for 1 ns;
        assert data_out = x"CC" and valid = '1' report "FAIL: read addr 2" severity error;

        wait until rising_edge(clk);
        wait for 1 ns;
        assert data_out = x"DD" and valid = '1' report "FAIL: read addr 3" severity error;

        wait until rising_edge(clk);
        wait for 1 ns;
        assert valid = '0' report "FAIL: valid should clear after read ends" severity error;

        wait until rising_edge(clk);
        we <= '1'; addr <= "000"; data_in <= x"FF";
        
        wait for 1 ns;
        assert valid = '0' report "FAIL: valid should be '0' during write" severity error;

        wait until rising_edge(clk);
        we <= '0'; addr <= "000";

        wait until rising_edge(clk);
        wait for 1 ns;
        assert data_out = x"FF" and valid = '1' report "FAIL: read after overwrite addr 0" severity error;

        wait for 5 * CLK_PERIOD;
        report "RAM testbench completely passed" severity note;
        wait;
      
    end process stimulus;

end sim;