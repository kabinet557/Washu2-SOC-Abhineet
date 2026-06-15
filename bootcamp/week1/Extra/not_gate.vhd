library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_gate is
    port (
        a : in  std_logic;
        y : out std_logic
    );
end not_gate;

architecture rtl of not_gate is
begin
    y <= not a;
end rtl;