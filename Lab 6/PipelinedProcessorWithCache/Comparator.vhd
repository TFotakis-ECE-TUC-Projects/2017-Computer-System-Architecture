library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Comparator is
    Port ( 	inA 		: in  	STD_LOGIC_VECTOR (4 downto 0);
					inB 		: in  	STD_LOGIC_VECTOR (4 downto 0);
					WrEn		: in		STD_LOGIC;
					output	: out  STD_LOGIC);
end Comparator;
architecture Behavioral of Comparator is
	component EqualityComparator5
		Port ( 	inA 		: in  	STD_LOGIC_VECTOR (4 downto 0);
						inB 		: in  	STD_LOGIC_VECTOR (4 downto 0);
						output	: out  STD_LOGIC);
	end component;
	signal comparatorOut: STD_LOGIC_VECTOR (1 downto 0);
begin
	equalityComparator5_0: EqualityComparator5 port map(inA=>inA, inB=>inB, output=>comparatorOut(0));
	equalityComparator5_1: EqualityComparator5 port map(inA=>"00000", inB=>inB, output=>comparatorOut(1));
	output<=comparatorOut(0) and (not comparatorOut(1)) and WrEn;
end Behavioral;