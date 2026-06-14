library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu4_extended is
    port (
        a : in  std_logic_vector(3 downto 0);
        b : in  std_logic_vector(3 downto 0);
        op : in  std_logic_vector(2 downto 0);
        result : out std_logic_vector(3 downto 0);
        zero : out std_logic;
        carry : out std_logic;
        negative : out std_logic 
    );
end alu4_extended;

architecture rt1 of alu4_extended is
    signal result_int : std_logic_vector(3 downto 0);
    constant ALU_ADD : std_logic_vector(2 downto 0) := "000";
    constant ALU_SUB : std_logic_vector(2 downto 0) := "001";
    constant ALU_AND : std_logic_vector(2 downto 0) := "010";
    constant ALU_OR : std_logic_vector(2 downto 0) := "011";
    constant ALU_XOR : std_logic_vector(2 downto 0) := "100";
    constant ALU_NOT : std_logic_vector(2 downto 0) := "101";
    constant ALU_NEGATE : std_logic_vector(2 downto 0) := "110";

begin
    alu_logic : process(a, b, op)
    variable adder_5bit : unsigned(4 downto 0);
    begin
        result_int <= (others => '0');
        carry      <= '0'; 
        case op is
            when ALU_ADD =>
                adder_5bit := ('0' & unsigned(a)) + ('0' & unsigned(b));
                result_int <= std_logic_vector(adder_5bit(3 downto 0));
                carry      <= adder_5bit(4);       
                
            when ALU_SUB =>
                result_int <= std_logic_vector(unsigned(a) - unsigned(b));                
            when ALU_AND =>
                result_int <= a and b;
                
            when ALU_OR =>
                result_int <= a or b;
                
            when ALU_XOR =>
                result_int <= a xor b;
                
            when ALU_NOT =>
                result_int <= not a;
                
            when ALU_NEGATE =>
                result_int <= std_logic_vector(-signed(a));
                
            when others =>
                result_int <= "0000";
        end case;
    end process alu_logic;
    result   <= result_int;
    zero     <= '1' when result_int = "0000" else '0';
    negative <= result_int(3);

end rt1;
