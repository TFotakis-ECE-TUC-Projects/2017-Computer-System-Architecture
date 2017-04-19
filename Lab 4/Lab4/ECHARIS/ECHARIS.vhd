library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity ECHARIS is
    Port (Reset 	: in  	STD_LOGIC;
					Clk 		: in  	STD_LOGIC);
end ECHARIS;
architecture Structural of ECHARIS is
	component Extended_control
		 Port (Instr 						: in  	STD_LOGIC_VECTOR (31 downto 0);
					ALU_Zero				: in		STD_LOGIC;
					Reset 					: in  	STD_LOGIC;
					Clk 						: in  	STD_LOGIC;
					PC_sel 					: out  STD_LOGIC_VECTOR (1 downto 0);
					PC_LdEn 				: out  STD_LOGIC;
					RF_WrEn 				: out  STD_LOGIC;
					RF_WrData_sel 	: out  STD_LOGIC_VECTOR (2 downto 0);
					RF_B_sel 				: out  STD_LOGIC;
					RF_AB_we			: out	STD_LOGIC;
					ALU_Ain_sel 		: out  STD_LOGIC_VECTOR (2 downto 0);
					ALU_Bin_sel 		: out  STD_LOGIC_VECTOR (2 downto 0);
					ALU_func 			: out	STD_LOGIC_VECTOR (3 downto 0);
					MEM_WrEn 		: out  STD_LOGIC;
					MEM_Control 		: out 	STD_LOGIC_VECTOR(1 downto 0);
					MEM_Addr_sel	: out 	STD_LOGIC_VECTOR (2 downto 0);
					MEM_Reg_we :out STD_LOGIC;
					mmx_we 				: out STD_LOGIC_VECTOR (2 downto 0);
					bpm_we					: out STD_LOGIC_VECTOR(2 downto 0);
					baseAddr_we		: out STD_LOGIC;
					bum_sel		: out STD_LOGIC_VECTOR(1 downto 0));
	end component;

	component Datapath
		 Port (PC_Sel 					: in  	STD_LOGIC_VECTOR (1 downto 0);
					PC_LdEn 				: in  	STD_LOGIC;
					RF_WrEn 				: in  	STD_LOGIC;
					RF_WrData_sel 	: in  	STD_LOGIC_VECTOR (2 downto 0);
					RF_B_sel 				: in  	STD_LOGIC;
					RF_AB_we			: in 	STD_LOGIC;
					ALU_Ain_sel 		: in  	STD_LOGIC_VECTOR (2 downto 0);
					ALU_Bin_sel 		: in  	STD_LOGIC_VECTOR (2 downto 0);
					ALU_func 			: in  	STD_LOGIC_VECTOR (3 downto 0);
					ALU_Zero		 		: out 	STD_LOGIC;
					MEM_WrEn 		: in  	STD_LOGIC;
					MEM_Control 		: in 	STD_LOGIC_VECTOR(1 downto 0);
					MEM_Addr_sel	: in 	STD_LOGIC_VECTOR (2 downto 0);
					MEM_Reg_we :in STD_LOGIC;
					mmx_we					: in STD_LOGIC_VECTOR (2 downto 0);
					bpm_we					: in STD_LOGIC_VECTOR(2 downto 0);
					baseAddr_we		: in STD_LOGIC;
					bum_sel		: in STD_LOGIC_VECTOR(1 downto 0);
					Reset 					: in  	STD_LOGIC;
					Clk 						: in  	STD_LOGIC;
					Instr						: out 	STD_LOGIC_VECTOR (31 downto 0));
	end component;
--	signal InstrSig, RF_A_sig, RF_B_sig : STD_LOGIC_VECTOR (31 downto 0);
	signal InstrSig : STD_LOGIC_VECTOR (31 downto 0);
	signal PC_LdEn_sig, RF_B_sel_sig, RF_WrEn_sig , RF_AB_we_sig, ALU_Zero_sig, MEM_WrEn_sig,MEM_Reg_we_sig, baseAddr_we_sig : STD_LOGIC;
	signal PC_sel_sig, bum_sel_sig, MEM_Control_sig : STD_LOGIC_VECTOR (1 downto 0);
	signal ALU_func_sig : STD_LOGIC_VECTOR (3 downto 0);
	signal ALU_Ain_sel_sig, ALU_Bin_sel_sig, mmx_we_sig, RF_WrData_sel_sig, bpm_we_sig, MEM_Addr_sel_sig : STD_LOGIC_VECTOR(2 downto 0);
begin
	Extended_control_0: Extended_control port map (Instr=>InstrSig,
																		ALU_Zero=>ALU_Zero_sig,
																		Reset=>Reset,
																		Clk=>Clk,
																		PC_sel=>PC_sel_sig,
																		PC_LdEn=>PC_LdEn_sig,
																		RF_WrEn=>RF_WrEn_sig,
																		RF_WrData_sel=>RF_WrData_sel_sig,
																		RF_B_sel=>RF_B_sel_sig,
																		RF_AB_we=>RF_AB_we_sig,
																		ALU_Ain_sel=>ALU_Ain_sel_sig,
																		ALU_Bin_sel=>ALU_Bin_sel_sig,
																		ALU_func=>ALU_func_sig,
																		MEM_WrEn=>MEM_WrEn_sig,
																		MEM_Control=>MEM_Control_sig,
																		MEM_Addr_sel=>MEM_Addr_sel_sig,
																		MEM_Reg_we=>MEM_Reg_we_sig,
																		mmx_we=>mmx_we_sig,
																		bpm_we=>bpm_we_sig,
																		baseAddr_we=>baseAddr_we_sig,
																		bum_sel=>bum_sel_sig);

	Datapath_0: Datapath port map (PC_Sel=>PC_sel_sig,
																		PC_LdEn=>PC_LdEn_sig,
																		RF_WrEn=>RF_WrEn_sig,
																		RF_WrData_sel=>RF_WrData_sel_sig,
																		RF_B_sel=>RF_B_sel_sig,
																		RF_AB_we=>RF_AB_we_sig,
																		ALU_Ain_sel=>ALU_Ain_sel_sig,
																		ALU_Bin_sel=>ALU_Bin_sel_sig,
																		ALU_func=>ALU_func_sig,
																		ALU_Zero=>ALU_Zero_sig,
																		MEM_WrEn=>MEM_WrEn_sig,
																		MEM_Control=>MEM_Control_sig,
																		MEM_Addr_sel=>MEM_Addr_sel_sig,
																		MEM_Reg_we=>MEM_Reg_we_sig,
																		mmx_we=>mmx_we_sig,
																		bpm_we=>bpm_we_sig,
																		baseAddr_we=>baseAddr_we_sig,
																		bum_sel=>bum_sel_sig,
																		Reset=>Reset,
																		Clk=>Clk,
																		Instr=>InstrSig);
end Structural;