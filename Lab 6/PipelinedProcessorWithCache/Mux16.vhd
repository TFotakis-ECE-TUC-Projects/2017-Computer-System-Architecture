library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mux16 is
    Port ( input : in  	STD_LOGIC_VECTOR (15 downto 0);
           output : out  	STD_LOGIC;
           control : in  	STD_LOGIC_VECTOR (3 downto 0));
end Mux16;
architecture Structural of Mux16 is
	component Mux2
		Port (input 	: in  	STD_LOGIC_VECTOR (1 downto 0);
				output 	: out  STD_LOGIC;
				control 	: in  	STD_LOGIC);
	end component;
	
	component Mux8
    Port ( input 	: in  	STD_LOGIC_VECTOR (7 downto 0);
           output 	: out  STD_LOGIC;
           control 	: in  	STD_LOGIC_VECTOR (2 downto 0));
	end component;
	signal mux8out: STD_LOGIC_VECTOR (1 downto 0);
begin
	mux8_0: Mux8 port map(input=>input(7 downto 0), 		output=>mux8out(0), 	control=>control(2 downto 0));
	mux8_1: Mux8 port map(input=>input(15 downto 8), 	output=>mux8out(1), 	control=>control(2 downto 0));
	mux2_0: Mux2 port map(input=>mux8out, 							output=>output, 				control=>control(3));
end Structural;