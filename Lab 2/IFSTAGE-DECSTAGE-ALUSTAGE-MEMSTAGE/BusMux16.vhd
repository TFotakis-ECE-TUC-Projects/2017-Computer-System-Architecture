library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
entity BusMux16 is
    Port ( 	input		: in		Bus16;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control : in  	STD_LOGIC_VECTOR (3 downto 0));
end BusMux16;
architecture Structural of BusMux16 is
	component BusMux2
		Port ( 	input 	: in  	Bus2;
						output	: out  STD_LOGIC_VECTOR (31 downto 0);
						control	: in  	STD_LOGIC);
	end component;
	component BusMux8
    Port ( 	input: in Bus8;
					output : out  STD_LOGIC_VECTOR (31 downto 0);
					control : in  STD_LOGIC_VECTOR (2 downto 0));
	end component;
	signal outputLine: Bus2;
begin
	BusMux8_0: BusMux8 port map(	input(0)=> input(0), input(1)=>input(1), input(2)=>input(2), input(3)=>input(3), 
																			input(4)=> input(4), input(5)=>input(5), input(6)=>input(6), input(7)=>input(7), 
																			output=>outputLine(0), control=>control(2 downto 0));
	BusMux8_1: BusMux8 port map(	input(0)=> input(8), input(1)=>input(9), input(2)=>input(10), input(3)=>input(11), 
																			input(4)=> input(12), input(5)=>input(13), input(6)=>input(14), input(7)=>input(15),  
																			output=>outputLine(1), control=>control(2 downto 0));
	BusMux2_0: BusMux2 port map(input(0)=>outputLine(0), input(1)=>outputLine(1), output=>output, control=>control(3));
end Structural;