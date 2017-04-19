library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity SignExtender is
    Port ( 	 Din		: in  STD_LOGIC_VECTOR (7 downto 0);
						Dout 	: out  STD_LOGIC_VECTOR (31 downto 0));
end SignExtender;
architecture Structural of SignExtender is
begin
				SignExtention: for i in 0 to 23 generate
					Dout(8+i)<=Din(7);
				end generate;
				Dout(7 downto 0)<=Din;
end Structural;