library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ram8x8 is
    port (
        clk : in  std_logic;
		  reset : in std_logic; 
        we : in  std_logic;
        addr : in  std_logic_vector(2 downto 0);
        data_in : in  std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        valid : out std_logic
    );
end ram8x8;

architecture rt1 of ram8x8 is
	type ram_type is array(0 to 7) of std_logic_vector(7 downto 0);
	signal ram_mem : ram_type := (others =>(others => '0'));
	begin
		mem_proc : process(clk)
		begin
			if rising_edge(clk) then
				if reset = '1' then
					data_out <= (others => '0');
					valid <= '0';
				else
					if we = '1' then
						ram_mem(to_integer(unsigned(addr)))<= data_in;
						valid <= '0';
					else
						data_out <= ram_mem(to_integer(unsigned(addr)));
						valid <= '1';
					end if;
				end if;
			end if;
		end process mem_proc;
	end rt1;
					
		
