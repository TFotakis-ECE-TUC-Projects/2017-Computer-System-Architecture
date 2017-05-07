library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity IDEX_Register is
    Port ( 	input : in  STD_LOGIC_VECTOR (168 downto 0);
						output : out  STD_LOGIC_VECTOR (168 downto 0);
						clk : in  STD_LOGIC;
						reset : in STD_LOGIC);
end IDEX_Register;
architecture Behavioral of IDEX_Register is
begin
process(clk, reset)
begin
	if(reset='1') then output<=std_logic_vector(to_unsigned(0,169));
	elsif(rising_edge(clk)) then output<=input;
	end if;
end process;
end Behavioral;