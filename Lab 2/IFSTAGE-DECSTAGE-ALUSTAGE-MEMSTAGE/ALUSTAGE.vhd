library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity ALUSTAGE is
    Port (RF_A 				: in  	STD_LOGIC_VECTOR (31 downto 0);
				RF_B 					: in  	STD_LOGIC_VECTOR (31 downto 0);
				Immed 			: in  	STD_LOGIC_VECTOR (31 downto 0);
				ALU_Bin_sel	: in  	STD_LOGIC;
				ALU_func 		: in  	STD_LOGIC_VECTOR (3 downto 0);
				ALU_out 			: out  STD_LOGIC_VECTOR (31 downto 0));
end ALUSTAGE;
architecture Structural of ALUSTAGE is
	component ALU
		 Port (A 			: in  	STD_LOGIC_VECTOR (31 downto 0);
					B 			: in  	STD_LOGIC_VECTOR (31 downto 0);
					Op 			: in  	STD_LOGIC_VECTOR (3 downto 0);
					output 	: out  STD_LOGIC_VECTOR (31 downto 0);
					Zero 		: out  STD_LOGIC;
					Cout 		: out  STD_LOGIC;
					Ovf 		: out  STD_LOGIC);
	end component;

	component BusMux2
    Port ( 	input 	: in  	Bus2;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC);
	end component;
	signal muxOut : STD_LOGIC_VECTOR (31 downto 0);
begin
	ALU_0: ALU port map(A=>RF_A, B=>muxOut, Op=>ALU_func, output=>ALU_out);
	BusMux2_0: BusMux2 port map(input(0)=>RF_B, input(1)=>Immed, output=>muxOut, control=>ALU_Bin_sel);
end Structural;