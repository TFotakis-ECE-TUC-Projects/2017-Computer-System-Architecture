library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity CONTROL is
    Port (Instr 							: in  	STD_LOGIC_VECTOR (31 downto 0);
					ALU_Zero					: in		STD_LOGIC;
					Reset 							: in  	STD_LOGIC;
					Clk 									: in  	STD_LOGIC;
					PC_sel 						: out  STD_LOGIC;
					PC_LdEn 					: out  STD_LOGIC;
					RF_WrEn 					: out  STD_LOGIC;
					RF_WrData_sel 	: out  STD_LOGIC_VECTOR (1 downto 0);
					RF_B_sel 					: out  STD_LOGIC;
					ALU_Bin_sel 			: out  STD_LOGIC;
					ALU_func 				: out 	STD_LOGIC_VECTOR (3 downto 0);
					MEM_WrEn 			: out  STD_LOGIC;
					MEM_Control 		: out 	STD_LOGIC);
end CONTROL;
architecture Behavioral of CONTROL is
	begin
	with Instr(31 downto 26) select
		PC_sel <=
									'0' when others;
	with Instr(31 downto 26) select
		PC_LdEn <= 
											'1' when others;
	with Instr(31 downto 26) select
		RF_WrEn <= 	'1' when "100000",	--RType
											'1' when "111000",	--li
											'1' when "001111",	--lw
											'0' when others;
	with Instr(31 downto 26) select
		RF_WrData_sel <= 	"10" when "111000",	--li
															"01" when "001111",	--lw
															"00" when others;
	with Instr(31 downto 26) select
		RF_B_sel <= 	'1' when "001111",	--lw
											'1' when "011111",	--sw
											'0' when others;
--	with Instr(31 downto 26) select
--		RF_AB_we<= 
--											'0' when others;
	with Instr(31 downto 26) select
		ALU_Bin_sel <=	'1' when "001111",	--lw
													'1' when "011111",	--sw
													'0' when others;
	with Instr(31 downto 26) select
		ALU_func <=	Instr (3 downto 0) when "100000",	--RType
											--"0000" when "110000",	--addi
											--"0010" when "110010",	--andi
											--"0011" when "110011",	--ori
											"0000" when others;
	with Instr(31 downto 26) select
		MEM_WrEn<=	'1' when "011111",	--sw
												'0' when others;
	with Instr(31 downto 26) select
		MEM_Control <=
														'0' when others;
end Behavioral;