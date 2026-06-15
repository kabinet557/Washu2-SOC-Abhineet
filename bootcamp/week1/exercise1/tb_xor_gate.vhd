library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- A testbench entity has no ports
entity tb_xor_gate is
end tb_xor_gate;

architecture sim of tb_xor_gate is
    -- Component declaration for the Unit Under Test (UUT)
    component xor_gate is
        port (
            a : in  std_logic;
            b : in  std_logic;
            y : out std_logic
        );
    end component;

    -- Signals to connect to the UUT
    signal t_a : std_logic := '0';
    signal t_b : std_logic := '0';
    signal t_y : std_logic;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: xor_gate
        port map (
            a => t_a,
            b => t_b,
            y => t_y
        );

    -- Stimulus process to apply the inputs
    stim_proc: process
    begin
        -- Case 1: 0 XOR 0 = 0
        t_a <= '0'; t_b <= '0';
        wait for 10 ns;

        -- Case 2: 0 XOR 1 = 1
        t_a <= '0'; t_b <= '1';
        wait for 10 ns;

        -- Case 3: 1 XOR 0 = 1
        t_a <= '1'; t_b <= '0';
        wait for 10 ns;

        -- Case 4: 1 XOR 1 = 0
        t_a <= '1'; t_b <= '1';
        wait for 10 ns;

        -- End the simulation
        wait;
    end process;

end sim;