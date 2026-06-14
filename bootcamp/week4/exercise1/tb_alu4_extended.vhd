library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_alu4_extended is
end tb_alu4_extended;

architecture sim of tb_alu4_extended is
    signal a : std_logic_vector(3 downto 0) := (others => '0');
    signal b  : std_logic_vector(3 downto 0) := (others => '0');
    signal op : std_logic_vector(2 downto 0) := (others => '0');
    signal result   : std_logic_vector(3 downto 0);
    signal zero     : std_logic;
    signal carry    : std_logic;
    signal negative : std_logic;
    constant PROP_DELAY : time := 10 ns;

begin
    uut : entity work.alu4_extended
        port map (
            a => a, 
            b => b, 
            op  => op, 
            result => result, 
            zero => zero, 
            carry => carry, 
            negative => negative
        );
    stimulus : process
    begin
        op <= "000";
        a  <= "0011"; b <= "0101"; wait for PROP_DELAY;
        assert result = "1000" and zero = '0' and carry = '0' and negative = '1'
            report "FAIL: ADD 3+5" severity error;

        a  <= "1111"; b <= "0001"; wait for PROP_DELAY;
        assert result = "0000" and zero = '1' and carry = '1' and negative = '0'
            report "FAIL: ADD 15+1 overflow wrap" severity error;

        op <= "001";
        a  <= "0101"; b <= "0011"; wait for PROP_DELAY;
        assert result = "0010" and zero = '0' and negative = '0'
            report "FAIL: SUB 5-3" severity error;

        a  <= "0011"; b <= "0101"; wait for PROP_DELAY;
        assert result = "1110" and zero = '0' and negative = '1'
            report "FAIL: SUB 3-5 negative result" severity error;

        op <= "010";
        a  <= "1100"; b <= "1010"; wait for PROP_DELAY;
        assert result = "1000" and zero = '0' and negative = '1'
            report "FAIL: AND" severity error;

        op <= "011";
        a  <= "1010"; b <= "0101"; wait for PROP_DELAY;
        assert result = "1111" and zero = '0' and negative = '1'
            report "FAIL: OR" severity error;

        op <= "100";
        a  <= "1010"; b <= "1100"; wait for PROP_DELAY;
        assert result = "0110" and zero = '0' and negative = '0'
            report "FAIL: XOR" severity error;

        op <= "101";
        a  <= "1010"; wait for PROP_DELAY;
        assert result = "0101" and zero = '0' and negative = '0'
            report "FAIL: NOT 1010" severity error;

        a  <= "1111"; wait for PROP_DELAY;
        assert result = "0000" and zero = '1' and negative = '0'
            report "FAIL: NOT 1111" severity error;

        op <= "110";
        a  <= "0011"; wait for PROP_DELAY;
        assert result = "1101" and zero = '0' and negative = '1'
            report "FAIL: NEGATE 3" severity error;

        a  <= "0000"; wait for PROP_DELAY;
        assert result = "0000" and zero = '1' and negative = '0'
            report "FAIL: NEGATE 0" severity error;

        op <= "111"; a <= "1111"; b <= "1111"; wait for PROP_DELAY;
        assert result = "0000" and zero = '1'
            report "FAIL: undefined op should output 0000" severity error;

        wait for PROP_DELAY;
        report "ALU extended testbench complete" severity note;
        wait;
    end process stimulus;
end sim;