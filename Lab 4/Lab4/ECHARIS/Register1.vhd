library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Register1 is
    Port ( 	data 	: in  	STD_LOGIC;
					dout 	: out  STD_LOGIC;
					we 		: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 		: in  	STD_LOGIC);
end Register1;
architecture Structural of Register1 is
	component Mux2
		Port (input 		: in  	STD_LOGIC_VECTOR (1 downto 0);
					output 	: out  STD_LOGIC;
					control	: in  	STD_LOGIC);
	end component;	
	component DFlipFlop
    Port (	D 		: in  	STD_LOGIC;
					reset	: in  	STD_LOGIC;
					clk 		: in  	STD_LOGIC;
					Q 		: out  STD_LOGIC);
	end component;
--	component debouncebutton
--    Port ( clk 			: in 	std_logic;
--					rst 			: in 	std_logic;
--					input 	: in 	std_logic;
--					output 	: out 	std_logic);
--	end component;
	signal mux2out, DFlipFlopOut : STD_LOGIC;
--	signal weDebounced, flag: STD_LOGIC;
begin
	mux2_0: Mux2 port map(input(0)=>DFlipFlopOut, input(1)=>data, output=>mux2out, control=>we);
--	mux2_0: Mux2 port map(input(0)=>DFlipFlopOut, input(1)=>data, output=>mux2out, control=>weDebounced);
	DFlipFlop0: DFlipFlop port map(D=>mux2out, reset=>reset, clk=>clk, Q=>DFlipFlopOut);
--	debounce: debouncebutton port map(clk=>clk, rst=>reset, input=>we, output=>weDebounced);
	dout<=DFlipFlopOut;
	
--	process(clk, we, reset)
--	begin
--		if reset='1' then
--			weDebounced<='0';
--			flag<='0';
--		elsif rising_edge(clk) then
--			if we='1' then
--				if flag='0' then
--					weDebounced<='1';
--					flag<='1';
--				else
--					weDebounced<='0';
--				end if;
--			else
--				flag<='0';
--				weDebounced<='0';
--			end if;
--		end if;
--	end process;

--	process(clk,reset)
--	 begin
--		if reset='1' then 
--			dout<='0';
--		elsif rising_edge(clk) then
--			if rising_edge(we) then
--				dout<=data;
--			else
--				dout<=dout;
--			end if;
--		end if;
--	 end process;
end Structural;