library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mux4 is
    Port (input : in  		STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC;
				control : in  	STD_LOGIC_VECTOR (1 downto 0));
end Mux4;
architecture Structural of Mux4 is
	component Mux2
		Port (input 	: in  	STD_LOGIC_VECTOR (1 downto 0);
					output : out  STD_LOGIC;
					control : in  	STD_LOGIC);
	end component;	
	signal mux2out: STD_LOGIC_VECTOR (1 downto 0);
begin
	mux2_0: Mux2 port map(input(0)=>input(0), input(1)=>input(1), 	output=>mux2out(0), 	control=>control(0));
	mux2_1: Mux2 port map(input(0)=>input(2), input(1)=>input(3), 	output=>mux2out(1), 	control=>control(0));
	mux2_2: Mux2 port map(input=>mux2out, 													output=>output, 				control=>control(1));
end Structural;