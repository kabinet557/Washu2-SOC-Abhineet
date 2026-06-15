library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity two_one_mux is
    port (
        a   : in  std_logic;
        b   : in  std_logic;
        sel : in  std_logic;
        y   : out std_logic
    );
end two_one_mux;

architecture rtl of two_one_mux is
begin
    y <= ((not sel) and a) or (sel and b);  
end rtl;