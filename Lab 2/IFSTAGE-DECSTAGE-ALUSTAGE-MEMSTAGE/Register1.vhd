library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Register1 is
    Port ( 	data 	: in  	STD_LOGIC;
					dout 	: out  STD_LOGIC;
					we 	: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end Register1;
architecture Structural of Register1 is
	component Mux2
		Port (input 	: in  	STD_LOGIC_VECTOR (1 downto 0);
					output : out  STD_LOGIC;
					control : in  	STD_LOGIC);
	end component;	
	component DFlipFlop
    Port (	D 		: in  	STD_LOGIC;
					reset	: in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC;
					Q 		: out  STD_LOGIC);
	end component;
	component debouncebutton
    Port ( 	clk 		: in std_logic;
					rst 		: in std_logic;
					input 		: in std_logic;
					output 	: out std_logic);
	end component;
	signal mux2out, DFlipFlopOut, weDebounced: STD_LOGIC;
begin
	mux2_0: Mux2 port map(input(0)=>DFlipFlopOut, input(1)=>data, output=>mux2out, control=>weDebounced);
	DFlipFlop0: DFlipFlop port map(D=>mux2out, reset=>reset, clk=>clk, Q=>DFlipFlopOut);
	debounce: debouncebutton port map(clk=>clk, rst=>reset, input=>we, output=>weDebounced);
	dout<=DFlipFlopOut;
end Structural;