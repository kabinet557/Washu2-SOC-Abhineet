library IEEE;
use IEEE.STD_LOGIC1164.ALL;
entity vendingmachine is
	port(
		clk: in std_logic;
		reset : in std_logic;
		coin5 : in std_logic;
		coin10 : in std_logic;
		dispense: out std_logic;
		change : out std_logic
	);
end vendingmachine;

architecture rt1 of vendingmachine is
	type state_type is (S_0,S_5,S_10);
	signal current_state : state_type;
	signal next_state : state_type;
begin
	state_reg: process(clk)
	begin
		if rising_edge(clk) then
		if reset ='1' then 
			current_state <= S_0;
		else
			current_state<=next_state;
			end if;
		end if;
	end process state_reg;
	
	comb_logic : process(current_state,coin5,coin10)
	begin
		next_state <= current_state;
		dispense <= '0';
		change <= '0';
		case current_state is
			when S_0 => 
				if coin5='1' then
					next_state <= S_5;
				elsif coin10 ='1' then
					next_state <= S_10;
				end if;
			when S_5 =>
				if coin5='1' then
					next_state <= S_10;
				elsif coin10 ='1' then
					dispense <='1';
					next_state <= S_0;
				end if;
			when S_10 =>
				if coin5='1' then
					dispense <='1';
					next_state <= S_0;
				elsif coin10 ='1' then
					dispense <='1';
					change <='1';
					next_state <= S_0;
				end if;
			end case;
		end process comb_logic;
end rt1;
					
	

