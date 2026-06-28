library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_mini_cpu_ex1 is
end tb_mini_cpu_ex1;

architecture sim of tb_mini_cpu is

    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal done : std_logic;

    signal dbg_acc : std_logic_vector(7 downto 0);
    signal dbg_pc : std_logic_vector(4 downto 0);
    signal dbg_ir : std_logic_vector(7 downto 0);
    signal dbg_state : std_logic_vector(2 downto 0);
    constant CLK_PERIOD : time := 10 ns;

begin
    clk <= not clk after CLK_PERIOD / 2;
    uut : entity work.mini_cpu
        port map (
            clk => clk,
            reset => reset,
            done => done,
            dbg_acc => dbg_acc,
            dbg_pc => dbg_pc,
            dbg_ir => dbg_ir,
            dbg_state => dbg_state
        );

    stimulus : process
    begin
        reset <= '1';
        wait for 2 * CLK_PERIOD;
        reset <= '0';
        wait until done = '1' for 30 * CLK_PERIOD;
        assert done = '1'
            report "FAIL: done never asserted"
            severity error;

        wait for CLK_PERIOD;

        assert dbg_acc = x"14"
            report "Accumulator has wrong value, expected x14"
            severity error;

        assert dbg_pc = "00101"
            report "PC did not stop at halt address"
            severity error;

        assert dbg_state = "100"
            report "CPU is not in halt state"
            severity error;

        wait for 5 * CLK_PERIOD;

        assert done = '1'
            report "CPU got out of halt state"
            severity error;

        assert dbg_acc = x"14"
            report "Accumulator changed values in halt state"
            severity error;

        reset <= '1';
        wait for 2 * CLK_PERIOD;
        reset <= '0';
        wait for CLK_PERIOD;

        assert dbg_pc = "00000"
            report "PC isn't 0 after reset"
            severity error;

        assert done = '0'
            report "Done isn't 0 after reset"
            severity error;

        assert dbg_state = "000"
            report "CPU isn't in fetch 1 state after reset"
            severity error;

        wait for 3 * CLK_PERIOD;
        report "Testbench complete" severity note;
        wait;
    end process stimulus;

end sim;