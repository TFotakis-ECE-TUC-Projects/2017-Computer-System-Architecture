library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mux32 is
    Port ( input : in  	STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC;
           control : in  	STD_LOGIC_VECTOR (4 downto 0));
end Mux32;
architecture Structural of Mux32 is
	component Mux2
		Port (input 	: in  	STD_LOGIC_VECTOR (1 downto 0);
				output 	: out  STD_LOGIC;
				control 	: in  	STD_LOGIC);
	end component;
	
	component Mux16
    Port ( input 	: in  	STD_LOGIC_VECTOR (15 downto 0);
           output 	: out  STD_LOGIC;
           control 	: in  	STD_LOGIC_VECTOR (3 downto 0));
	end component;
	signal mux8out: STD_LOGIC_VECTOR (1 downto 0);
begin
	mux16_0: Mux16 	port map(input=>input(15 downto 0), 	output=>mux8out(0), 	control=>control(3 downto 0));
	mux16_1: Mux16 	port map(input=>input(31 downto 16), 	output=>mux8out(1), 	control=>control(3 downto 0));
	mux2_0 : Mux2 		port map(input=>mux8out, 							output=>output, 				control=>control(4));
end Structural;