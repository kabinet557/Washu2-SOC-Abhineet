library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod_counter is
	generic (
        N : integer := 10
    );
   port (
        clk   : in  std_logic;
        reset   : in  std_logic;
        enable : in  std_logic;
        count  : out std_logic_vector(7 downto 0);
		  tick: out std_logic
    );
end mod_counter;

architecture rtl of mod_counter is
signal counter: std_logic_vector(7 downto 0);
begin
    process (clk)
    begin
		if rising_edge(clk) then
        if reset = '1' then
            counter <= (others => '0');
        elsif enable = '1' then
                if unsigned(counter) = (N - 1) then
                    counter <= (others => '0');
                else
                    counter <= std_logic_vector(unsigned(counter) + 1);
                end if;
            end if;
		 end if;
    end process;
	 tick <= '1' when unsigned(counter) = (N - 1) else '0';
    count <= counter;
	 
end rtl;
