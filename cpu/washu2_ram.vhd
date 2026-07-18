library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity washu2_ram is
    port (
        clk : in std_logic;
        we : in std_logic;
        addr : in std_logic_vector(11 downto 0);
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
    );
end washu2_ram;

architecture rtl of washu2_ram is

    type ram_type is array (0 to 4095) of std_logic_vector(15 downto 0);

    signal ram_mem : ram_type := (
        0 => x"2005",
        1 => x"7040",
        2 => x"A005",
        3 => x"B006",
        4 => x"2FFF",
        5 => x"0000",
        6 => x"8041",
        7 => x"6042",
        8 => x"D043",
        9 => x"2EEE",
        10 => x"0000",
        11 => x"2000",
        12 => x"5042",
        13 => x"7044",
        14 => x"0000",
        64 => x"0005",
        65 => x"000E",
        66 => x"0050",
        67 => x"000B",
        68 => x"0001",
        80 => x"0000",
        others => x"0000"
    );

    signal data_out_reg : std_logic_vector(15 downto 0) := (others => '0');

begin

    mem_proc : process (clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                ram_mem(to_integer(unsigned(addr))) <= data_in;
            end if;
            data_out_reg <= ram_mem(to_integer(unsigned(addr)));
        end if;
    end process mem_proc;

    data_out <= data_out_reg;

end rtl;
