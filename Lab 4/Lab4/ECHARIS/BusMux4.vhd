library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
entity BusMux4 is
    Port ( 	input		: in 	Bus4;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control : in  	STD_LOGIC_VECTOR (1 downto 0));
end BusMux4;
architecture Structural of BusMux4 is
	component BusMux2
		Port ( 	input 	: in  	Bus2;
						output	: out  STD_LOGIC_VECTOR (31 downto 0);
						control	: in  	STD_LOGIC);
	end component;
	signal outputLine: Bus2;
begin
	BusMux2_0: BusMux2 port map(input(0)=>input(0), input(1)=>input(1), output=>outputLine(0), control=>control(0));
	BusMux2_1: BusMux2 port map(input(0)=>input(2), input(1)=>input(3), output=>outputLine(1), control=>control(0));
	BusMux2_2: BusMux2 port map(input(0)=>outputLine(0), input(1)=>outputLine(1), output=>output, control=>control(1));
end Structural;