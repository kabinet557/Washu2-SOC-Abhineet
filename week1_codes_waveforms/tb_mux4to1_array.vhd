library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_mux4to1_array is
-- Testbenches do not have ports
end tb_mux4to1_array;

architecture sim of tb_mux4to1_array is

    -- Component Declaration for the Unit Under Test (UUT)
    component mux4to1_array is
        port (
            inputs     : in  std_logic_vector(3 downto 0); 
            sel        : in  std_logic_vector(1 downto 0);
            out_signal : out std_logic
        );
    end component;

    -- Signal Declarations to connect to the UUT
    signal t_inputs     : std_logic_vector(3 downto 0) := "0000";
    signal t_sel        : std_logic_vector(1 downto 0) := "00";
    signal t_out_signal : std_logic;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: mux4to1_array
        port map (
            inputs     => t_inputs,
            sel        => t_sel,
            out_signal => t_out_signal
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: Route input index 0
        t_inputs <= "1010"; -- index 3='1', 2='0', 1='1', 0='0'
        t_sel    <= "00";   -- Select index 0
        wait for 10 ns;
        -- Expected: t_out_signal = '0'

        -- Test Case 2: Route input index 1
        t_sel    <= "01";   -- Select index 1
        wait for 10 ns;
        -- Expected: t_out_signal = '1'

        -- Test Case 3: Route input index 2
        t_sel    <= "10";   -- Select index 2
        wait for 10 ns;
        -- Expected: t_out_signal = '0'

        -- Test Case 4: Route input index 3
        t_sel    <= "11";   -- Select index 3
        wait for 10 ns;
        -- Expected: t_out_signal = '1'

        -- Test Case 5: Change inputs to all '1's and test selection
        t_inputs <= "1111";
        t_sel    <= "01";
        wait for 10 ns;
        -- Expected: t_out_signal = '1'
        
        -- Test Case 6: Change inputs to all '0's and test selection
        t_inputs <= "0000";
        t_sel    <= "11";
        wait for 10 ns;
        -- Expected: t_out_signal = '0'

        -- End the simulation
        wait;
    end process;

end sim;