library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter8 is
    port (
        clk   : in  std_logic;
        reset   : in  std_logic;
        enable : in  std_logic;
        count  : out std_logic_vector(7 downto 0)
    );
end counter8;

architecture rtl of counter8 is
signal counter: std_logic_vector(7 downto 0);
begin
    process (clk)
    begin
		if rising_edge(clk) then
        if reset = '1' then
            counter <= (others => '0');
        elsif enable = '1' then
				counter <= std_logic_vector(unsigned(counter) + 1);
        end if;
		 end if;
    end process;

    count <= counter;
	 
end rtl;
