library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Register8 is
    Port ( 	data 	: in  	STD_LOGIC_VECTOR (7 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (7 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end Register8;
architecture Structural of Register8 is
	component Register4 is
		Port ( data : in  	STD_LOGIC_VECTOR (3 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (3 downto 0);
					we 	: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
	end component;
begin
	register4_0: Register4 port map(data=>data(3 downto 0), dout=>dout(3 downto 0), we=>we, reset=>reset, clk=>clk);
	register4_1: Register4 port map(data=>data(7 downto 4), dout=>dout(7 downto 4), we=>we, reset=>reset, clk=>clk);	
end Structural;