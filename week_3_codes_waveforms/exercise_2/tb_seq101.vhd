library IEEE
library IEEE.STD_LOGIC_1164.ALL

entity tb_seq101 is
end tb_seq101;

architecture sim of tb_seq101 is
	signal data : std_logic;
	signal detected : std_logic;
	signal reset: std_logic;
	signal clk : std_logic :='0';
	constant CLK_PERIOD : time := 10 ns;
	
begin
	clk <= not clk after CLK_PERIOD/2;
	uut : entity work.seq_det_101_nonoverlap
		port map(
			clk =>clk,
			reset =>reset,
			data => data,
			detected => detected
			);
	stimulus : process
	begin
		  reset <= '1';
        data  <= '0';
        wait for CLK_PERIOD * 2;
        
        reset <= '0';
        wait until falling_edge(clk);

        data <= '1'; wait for CLK_PERIOD; 
        data <= '0'; wait for CLK_PERIOD; 
        data <= '0'; wait for CLK_PERIOD; 
        data <= '1'; wait for CLK_PERIOD; 
        data <= '0'; wait for CLK_PERIOD; 
        data <= '1'; wait for CLK_PERIOD; 
        data <= '1'; wait for CLK_PERIOD; 
        data <= '0'; wait for CLK_PERIOD; 
        data <= '1'; wait for CLK_PERIOD; 
        data <= '0'; wait for CLK_PERIOD; 
        data <= '1'; wait for CLK_PERIOD; 

        data <= '1'; wait for CLK_PERIOD;
        data <= '0'; wait for CLK_PERIOD;
        data <= '1'; wait for CLK_PERIOD;

        data <= '0'; wait for CLK_PERIOD;
        data <= '1'; wait for CLK_PERIOD;
        data <= '1'; wait for CLK_PERIOD;
        data <= '1'; wait for CLK_PERIOD;
        data <= '0'; wait for CLK_PERIOD;
        data <= '0'; wait for CLK_PERIOD;
        data <= '1'; wait for CLK_PERIOD;
        data <= '0'; wait for CLK_PERIOD;
        data <= '1'; wait for CLK_PERIOD;
        data <= '0'; wait for CLK_PERIOD;
        data <= '0'; wait for CLK_PERIOD;

        data <= '0';
        wait;
    end process stimulus;

end architecture sim;
			
	
