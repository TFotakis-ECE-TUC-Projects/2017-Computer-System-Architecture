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
		PC_sel <=	'1' when "111111",	--b
									'1' when "000000",	--beq
									'1' when "000001",	--bne
									'0' when others;
	with Instr(31 downto 26) select
		PC_LdEn <= '1' when "111111",	--b
									'1' when "000000",	--beq
									'1' when "000001",	--bne
									'0' when others;
	with Instr(31 downto 26) select
		RF_WrEn <= 	'1' when "100000",	--RType
											'1' when "111000",	--li
											'1' when "111001",	--lui
											'1' when "001111",	--lw
											'1' when "110000",	--addi
											'1' when "110010",	--andi
											'1' when "110011",	--ori
											'1' when "000011",	--lb
											'0' when others;
	with Instr(31 downto 26) select
		RF_WrData_sel <= 	"10" when "111000",	--li
															"10" when "111001",	--lui
															"01" when "001111",	--lw
															"01" when "000011",	--lb
															"00" when others;
	with Instr(31 downto 26) select
		RF_B_sel <= 	'1' when "001111",	--lw
											'1' when "011111",	--sw
											'1' when "000111",	--sb
											'1' when "000011",	--lb
											'1' when "000000",	--beq
											'1' when "000001",	--bne
											'0' when others;
	with Instr(31 downto 26) select
		ALU_Bin_sel <=	'1' when "001111",	--lw
													'1' when "011111",	--sw
													'1' when "110000",	--addi
													'1' when "110010",	--andi
													'1' when "110011",	--ori
													'1' when "000111",	--sb
													'1' when "000011",	--lb
													'0' when others;
	with Instr(31 downto 26) select
		ALU_func <=	Instr (3 downto 0) when "100000",	--RType
											"0010" when "110010",	--andi
											"0011" when "110011",	--ori
											"0001" when "000000",	--beq
											"0001" when "000001",	--bne
											"0000" when others;
	with Instr(31 downto 26) select
		MEM_WrEn<=	'1' when "011111",	--sw
												'1' when "000111",	--sb
												'0' when others;
	with Instr(31 downto 26) select
		MEM_Control <=	'1' when "000111",	--sb
														'1' when "000011",	--lb
														'0' when others;
end Behavioral;