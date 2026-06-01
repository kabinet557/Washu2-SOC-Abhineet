library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate is
    port (
        a : in  std_logic;
		  b : in std_logic;
        y : out std_logic
    );
end xor_gate;

architecture rtl of xor_gate is
	signal a1 : std_logic;
	signal a2 : std_logic;
	signal n1 : std_logic;
	signal n2 : std_logic;
begin
	g1 : entity work.not_gate
		port map ( a => a , y => n1);
	g2 : entity work.not_gate
		port map ( a => b, y=> n2 );
	g3 : entity work.and_gate
		port map (  a=>a, b=> n2, y=>a1);
	g4: entity work.and_gate
		port map ( a=>b, b=>n1, y=>a2);
	g5: entity work.or_gate
		port map (a=>a1, b=>a2, y=>y);
end rtl;