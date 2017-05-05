library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
entity BusMux8 is
    Port ( 	input		: in 	Bus8;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control : in  	STD_LOGIC_VECTOR (2 downto 0));
end BusMux8;
architecture Structural of BusMux8 is
	component BusMux2
		Port ( 	input 	: in  	Bus2;
						output	: out  STD_LOGIC_VECTOR (31 downto 0);
						control	: in  	STD_LOGIC);
	end component;
	component BusMux4
    Port ( 	input		: in Bus4;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control : in  STD_LOGIC_VECTOR (1 downto 0));
	end component;
	signal outputLine: Bus2;
begin
	BusMux4_0: BusMux4 port map(input(0)=> input(0), input(1)=>input(1), input(2)=>input(2), input(3)=>input(3), output=>outputLine(0), control=>control(1 downto 0));
	BusMux4_1: BusMux4 port map(input(0)=> input(4), input(1)=>input(5), input(2)=>input(6), input(3)=>input(7), output=>outputLine(1), control=>control(1 downto 0));
	BusMux2_0: BusMux2 port map(input(0)=>outputLine(0), input(1)=>outputLine(1), output=>output, control=>control(2));
end Structural;