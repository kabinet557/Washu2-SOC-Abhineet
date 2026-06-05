library IEEE;
use IEEE.STD_LOGIC1164.ALL;
entity seq_det_101_nonoverlap is
    port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        data     : in  std_logic;
        detected : out std_logic
    );
end seq_det_101_nonoverlap;

architecture rt1 of seq_det_101_nonoverlap is
	type state_type is(S_reset,S1,S10,s101);
	signal current_state : state_type;
	signal next_state : state_type;
begin
	state_reg :process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then 
				current_state <=S_reset;
			else
				current_state<=next_state;
			end if;
		end if;
	end process state_reg;
	
	comb : process(current_state, data)
	begin
		next_state <= current_state;
		detected <='0';
		case current_state is
			when S_reset =>
				if data ='1' then
					next_state <= S1;
				end if;
			when S1 =>
				if data ='0' then
					next_state<=S10;
				else
					next_state <=S1;
				end if;
			when S10 =>
				if data='1' then
					next_state <= S101;
				else
					next_state <= S_reset;
				end if;
			when S101 =>
				detected <= '1';
				if data ='1' then
					next_state <=S1;
				else
					next_state <= S_reset;
				end if;
			end case;
		end process comb;
	end rt1;
				
		
