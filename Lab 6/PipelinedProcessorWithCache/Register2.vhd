library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Register2 is
    Port ( 	data 	: in  	STD_LOGIC_VECTOR (1 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (1 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end Register2;
architecture Structural of Register2 is
	component Register1 is
		Port ( data : in  	STD_LOGIC;
					dout 	: out  STD_LOGIC;
					we 	: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
	end component;
begin
	register1_0: Register1 port map(data=>data(0), dout=>dout(0), we=>we, reset=>reset, clk=>clk);
	register1_1: Register1 port map(data=>data(1), dout=>dout(1), we=>we, reset=>reset, clk=>clk);	
end Structural;