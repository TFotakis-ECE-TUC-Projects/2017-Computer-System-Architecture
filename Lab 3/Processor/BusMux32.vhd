library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
entity BusMux32 is
    Port ( 	input		: in		Bus32;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control : in  	STD_LOGIC_VECTOR (4 downto 0));
end BusMux32;
architecture Structural of BusMux32 is
	component BusMux2
		Port ( 	input 	: in  	Bus2;
						output	: out  STD_LOGIC_VECTOR (31 downto 0);
						control	: in  	STD_LOGIC);
	end component;
	component BusMux16
    Port ( 	input		: in Bus16;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	signal outputLine: Bus2;
begin
	BusMux16_0	: BusMux16 	port map(	input(0)=> input(0), 		input(1)=>input(1), 		input(2)=>input(2), 		input(3)=>input(3), 
																						input(4)=> input(4), 		input(5)=>input(5), 		input(6)=>input(6), 		input(7)=>input(7), 
																						input(8)=> input(8), 		input(9)=>input(9),			input(10)=>input(10), 	input(11)=>input(11), 
																						input(12)=> input(12), 	input(13)=>input(13), 	input(14)=>input(14), 	input(15)=>input(15), 
																						output=>outputLine(0), control=>control(3 downto 0));
	
	BusMux16_1	: BusMux16 	port map(	input(0)=> 	input(16), 	input(1)=>input(17), 		input(2)=>input(18), 		input(3)=>input(19), 
																						input(4)=> 	input(20), 	input(5)=>input(21), 		input(6)=>input(22), 		input(7)=>input(23), 
																						input(8)=> 	input(24), 	input(9)=>input(25),		input(10)=>input(26), 	input(11)=>input(27), 
																						input(12)=>	input(28), 	input(13)=>input(29), 	input(14)=>input(30), 	input(15)=>input(31), 
																						output=>outputLine(1), control=>control(3 downto 0));
	
	BusMux2_0		: BusMux2		port map(input(0)=>outputLine(0), input(1)=>outputLine(1), output=>output, control=>control(4));
end Structural;