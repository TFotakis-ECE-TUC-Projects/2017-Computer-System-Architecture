library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mux8 is
    Port ( input : in  	STD_LOGIC_VECTOR (7 downto 0);
           output : out  	STD_LOGIC;
           control : in  	STD_LOGIC_VECTOR (2 downto 0));
end Mux8;
architecture Structural of Mux8 is
	component Mux2
		Port (input 	: in  	STD_LOGIC_VECTOR (1 downto 0);
				output 	: out  STD_LOGIC;
				control 	: in  	STD_LOGIC);
	end component;	
	
	component Mux4
		Port (input		: in  	STD_LOGIC_VECTOR (3 downto 0);
				output 	: out  STD_LOGIC;
				control 	: in  	STD_LOGIC_VECTOR (1 downto 0));
	end component;	
	signal mux4out: STD_LOGIC_VECTOR (1 downto 0);
begin
	mux4_0: Mux4 port map(input=>input(3 downto 0), 	output=>mux4out(0), 	control=>control(1 downto 0));
	mux4_1: Mux4 port map(input=>input(7 downto 4), 	output=>mux4out(1), 	control=>control(1 downto 0));
	mux2_0: Mux2 port map(input=>mux4out, 						output=>output, 				control=>control(2));
end Structural;