library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity EqualityComparator5 is
    Port ( 	inA 		: in  	STD_LOGIC_VECTOR (4 downto 0);
					inB 		: in  	STD_LOGIC_VECTOR (4 downto 0);
					output	: out  STD_LOGIC);
end EqualityComparator5;
architecture Structural of EqualityComparator5 is
begin
	output<=(inA(0) xnor inB(0)) and (inA(1) xnor inB(1)) and (inA(2) xnor inB(2)) and (inA(3) xnor inB(3)) and (inA(4) xnor inB(4));
end Structural;