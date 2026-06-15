library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity two_one_mux_en is
    port (
        a   : in  std_logic;
        b   : in  std_logic;
        sel : in  std_logic;
		  en : in std_logic;
        y   : out std_logic
    );
end two_one_mux_en;

architecture rtl of two_one_mux_en is
begin
    y <= '0' when en ='0' else ((not sel) and a) or (sel and b);  
end rtl;