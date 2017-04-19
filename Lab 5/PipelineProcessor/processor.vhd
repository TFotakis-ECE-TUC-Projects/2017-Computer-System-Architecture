library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity processor is
    Port (Reset 	: in  	STD_LOGIC;
					Clk 		: in  	STD_LOGIC);
end processor;
architecture Structural of processor is
	component CONTROL
		 Port (Instr 						: in  	STD_LOGIC_VECTOR (31 downto 0);
					ALU_Zero				: in		STD_LOGIC;
					Reset 					: in  	STD_LOGIC;
					Clk 						: in  	STD_LOGIC;
					PC_sel 					: out  STD_LOGIC;
					PC_LdEn 				: out  STD_LOGIC;
					RF_WrEn 				: out  STD_LOGIC;
					RF_WrData_sel 	: out  STD_LOGIC_VECTOR (1 downto 0);
					RF_B_sel 				: out  STD_LOGIC;
					--RF_AB_we			: out	STD_LOGIC;
					ALU_Bin_sel 		: out  STD_LOGIC;
					ALU_func 			: out	STD_LOGIC_VECTOR (3 downto 0);
					MEM_WrEn 		: out  STD_LOGIC;
					MEM_Control 		: out 	STD_LOGIC);
	end component;

	component Datapath
		 Port (PC_Sel 					: in  	STD_LOGIC;
					PC_LdEn 				: in  	STD_LOGIC;
					RF_WrEn 				: in  	STD_LOGIC;
					RF_WrData_sel 	: in  	STD_LOGIC_VECTOR (1 downto 0);
					RF_B_sel 				: in  	STD_LOGIC;
					--RF_AB_we			: in 	STD_LOGIC;
					ALU_Bin_sel 		: in  	STD_LOGIC;
					ALU_func 			: in  	STD_LOGIC_VECTOR (3 downto 0);
					ALU_Zero		 		: out 	STD_LOGIC;
					MEM_WrEn 		: in  	STD_LOGIC;
					MEM_Control 		: in 	STD_LOGIC;
					Reset 					: in  	STD_LOGIC;
					Clk 						: in  	STD_LOGIC;
					--RF_A 						: out  STD_LOGIC_VECTOR (31 downto 0);
					--RF_B 						: out  STD_LOGIC_VECTOR (31 downto 0);
					Instr						: out 	STD_LOGIC_VECTOR (31 downto 0));
	end component;
	signal InstrSig: STD_LOGIC_VECTOR (31 downto 0);
	signal PC_sel_sig, PC_LdEn_sig, RF_WrEn_sig, RF_B_sel_sig, ALU_Bin_sel_sig, ALU_Zero_sig, MEM_WrEn_sig, MEM_Control_sig : STD_LOGIC;
	signal RF_WrData_sel_sig : STD_LOGIC_VECTOR (1 downto 0);
	signal ALU_func_sig : STD_LOGIC_VECTOR (3 downto 0);
begin
	CONTROL_0: CONTROL port map (Instr=>InstrSig,
																		ALU_Zero=>ALU_Zero_sig,
																		Reset=>Reset,
																		Clk=>Clk,
																		PC_sel=>PC_sel_sig,
																		PC_LdEn=>PC_LdEn_sig,
																		RF_WrEn=>RF_WrEn_sig,
																		RF_WrData_sel=>RF_WrData_sel_sig,
																		RF_B_sel=>RF_B_sel_sig,
																		--RF_AB_we=>RF_AB_we_sig,
																		ALU_Bin_sel=>ALU_Bin_sel_sig,
																		ALU_func=>ALU_func_sig,
																		MEM_WrEn=>MEM_WrEn_sig,
																		MEM_Control=>MEM_Control_sig);

	Datapath_0: Datapath port map (PC_Sel=>PC_sel_sig,
																		PC_LdEn=>PC_LdEn_sig,
																		RF_WrEn=>RF_WrEn_sig,
																		RF_WrData_sel=>RF_WrData_sel_sig,
																		RF_B_sel=>RF_B_sel_sig,
																		--RF_AB_we=>RF_AB_we_sig,
																		ALU_Bin_sel=>ALU_Bin_sel_sig,
																		ALU_func=>ALU_func_sig,
																		ALU_Zero=>ALU_Zero_sig,
																		MEM_WrEn=>MEM_WrEn_sig,
																		MEM_Control=>MEM_Control_sig,
																		Reset=>Reset,
																		Clk=>Clk,
																		--RF_A=>RF_A_sig,
																		--RF_B=>RF_B_sig,
																		Instr=>InstrSig);
end Structural;