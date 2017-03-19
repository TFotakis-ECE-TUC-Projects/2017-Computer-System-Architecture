library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
entity BusMux2 is
    Port ( 	input 	: in  	Bus2;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC);
end BusMux2;
architecture Structural of BusMux2 is
	component Mux2
		Port(	input 	: in  	STD_LOGIC_VECTOR (1 downto 0);
					output	: out  STD_LOGIC;
					control	: in  	STD_LOGIC);
	end component;	
begin
	Mux2Gen : for i in 0 to 31 generate
		mux2_i: Mux2 port map(input(0)=>input(0)(i), 	input(1)=>input(1)(i), 	output=>output(i), 	control=>control);
	end generate Mux2Gen;
end Structural;