library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux4to1_array is
    port (
        inputs     : in  std_logic_vector(3 downto 0); 
        sel        : in  std_logic_vector(1 downto 0);
        out_signal : out std_logic
    );
end mux4to1_array;

architecture behavioral of mux4to1_array is
begin
    out_signal <= inputs(to_integer(unsigned(sel)));
end behavioral;