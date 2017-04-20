library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Bus32pkg.ALL;
entity Datapath is
    Port (PC_Sel 					: in  	STD_LOGIC;
				PC_LdEn 				: in  	STD_LOGIC;
				RF_WrEn 				: in  	STD_LOGIC;
				RF_WrData_sel 	: in  	STD_LOGIC_VECTOR (1 downto 0);
				RF_B_sel 				: in  	STD_LOGIC;
				ALU_Bin_sel 		: in  	STD_LOGIC;
				ALU_func 			: in  	STD_LOGIC_VECTOR (3 downto 0);
				ALU_Zero				: out	STD_LOGIC;
				MEM_WrEn 		: in  	STD_LOGIC;
				MEM_Control 		: in 	STD_LOGIC;
				Reset 					: in  	STD_LOGIC;
				Clk 						: in  	STD_LOGIC;
				Instr						: out 	STD_LOGIC_VECTOR (31 downto 0));
end Datapath;

architecture Structural of Datapath is
	component IFSTAGE
		 Port (PC_Immed 	: in  	STD_LOGIC_VECTOR (31 downto 0);
					PC_Sel 			: in  	STD_LOGIC;
					PC_LdEn 		: in  	STD_LOGIC;
					Reset 			: in  	STD_LOGIC;
					Clk 				: in  	STD_LOGIC;
					Instr 				: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component DECSTAGE
		 Port (Instr 						: in  	STD_LOGIC_VECTOR (31 downto 0);
		 				Awr							: in 	STD_LOGIC_VECTOR (4 downto 0);
						RF_WrEn 				: in  	STD_LOGIC;
						WBMuxOut 				: in  	STD_LOGIC_VECTOR (31 downto 0);
						MEM_out 			: in  	STD_LOGIC_VECTOR (31 downto 0);
						RF_WrData_sel	: in  	STD_LOGIC;
						RF_B_sel 				: in  	STD_LOGIC;
						Reset 					: in  	STD_LOGIC;
						Clk 						: in  	STD_LOGIC;
--						ImmedIn 				: in  STD_LOGIC_VECTOR (31 downto 0);
						ImmedOut			: out  STD_LOGIC_VECTOR (31 downto 0);
						RF_A 						: out  STD_LOGIC_VECTOR (31 downto 0);
						RF_B 						: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component ALUSTAGE
		 Port (RF_A 				: in  	STD_LOGIC_VECTOR (31 downto 0);
					RF_B 					: in  	STD_LOGIC_VECTOR (31 downto 0);
					Immed 			: in  	STD_LOGIC_VECTOR (31 downto 0);
					ALU_Bin_sel	: in  	STD_LOGIC;
					ALU_func 		: in  	STD_LOGIC_VECTOR (3 downto 0);
					ALU_out 			: out  STD_LOGIC_VECTOR (31 downto 0);
					ALU_Zero			: out	STD_LOGIC);
	end component;

	component MEMSTAGE
		 Port (clk 						: in  	STD_LOGIC;
					Mem_WrEn 		: in  	STD_LOGIC;
					ALU_MEM_Addr : in  	STD_LOGIC_VECTOR (31 downto 0);
					MEM_Datain		: in  STD_LOGIC_VECTOR (31 downto 0);
					MEM_Control 		: in 	STD_LOGIC;
					MEM_DataOut 	: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	component IFID_Register
	Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
					output : out  STD_LOGIC_VECTOR (31 downto 0);
					clk : in  STD_LOGIC;
						reset : in STD_LOGIC);
	end component;
	component IDEX_Register
    Port ( input : in  STD_LOGIC_VECTOR (121 downto 0);
					output : out  STD_LOGIC_VECTOR (121 downto 0);
					clk : in  STD_LOGIC;
						reset : in STD_LOGIC);
	end component;
	component EXMEM_Register 
    Port ( input : in  STD_LOGIC_VECTOR (106 downto 0);
					output : out  STD_LOGIC_VECTOR (106 downto 0);
					clk : in  STD_LOGIC;
						reset : in STD_LOGIC);
	end component;
	component MEMWB_Register
    Port ( input : in  STD_LOGIC_VECTOR (104 downto 0);
					output : out  STD_LOGIC_VECTOR (104 downto 0);
					clk : in  STD_LOGIC;
						reset : in STD_LOGIC);
	end component;
	
	component ForwardingUnit
		Port ( EXMEM_RF_WrEn 	: in  STD_LOGIC;
						EXMEM_Rd 						: in  STD_LOGIC_VECTOR (4 downto 0);
						IDEX_Rs 								: in  STD_LOGIC_VECTOR (4 downto 0);
						IDEX_Rt 								: in  STD_LOGIC_VECTOR (4 downto 0);
						MEMWB_RF_WrEn 	: in  STD_LOGIC;
						MEMWB_Rd						: in  STD_LOGIC_VECTOR (4 downto 0);
						ForwardA 							: out  STD_LOGIC_VECTOR (1 downto 0);
						ForwardB 							: out  STD_LOGIC_VECTOR (1 downto 0));
		end component;
		
	component BusMux2
    Port ( 	input 	: in  	Bus2;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC);
	end component;
		
	component BusMux4
	Port ( input		: in 	Bus4;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control : in  	STD_LOGIC_VECTOR (1 downto 0));
	end component;
	
	signal ForwardASig, ForwardBSig : STD_LOGIC_VECTOR(1 downto 0);
	signal InstrSig, ALU_out_sig, MEM_out_sig, ImmedSig, RF_A_sig, RF_B_sig, WBMuxOutSig, BusMuxAOut, BusMuxBOut: STD_LOGIC_VECTOR (31 downto 0);
	signal IFIDOut: STD_LOGIC_VECTOR(31 downto 0);
	signal IDEXOut: STD_LOGIC_VECTOR(121 downto 0);
	signal EXMEMOut: STD_LOGIC_VECTOR(106 downto 0);
	signal MEMWBOut: STD_LOGIC_VECTOR(104 downto 0);
	signal RtORRdMuxOut: STD_LOGIC_VECTOR(4 downto 0);
begin
	IFSTAGE_0: IFSTAGE port map(	PC_Immed=>ImmedSig,
																							PC_Sel=>PC_Sel,
																							PC_LdEn=>PC_LdEn,
																							Reset=>Reset,
																							Clk=>Clk,
																							Instr=>InstrSig);

	DECSTAGE_0: DECSTAGE port map(Instr=>IFIDOut,
																										Awr=>MEMWBOut(8 downto 4),
																										RF_WrEn=>MEMWBOut(0),
																										WBMuxOut=>WBMuxOutSig,
																										RF_WrData_sel=>MEMWBOut(1),
																										RF_B_sel=>RF_B_sel,
																										Reset=>Reset,
																										Clk=>Clk,
																										MEM_out=>MEMWBOut(104 downto 73),
																										ImmedOut=>ImmedSig,
																										RF_A=>RF_A_sig,
																										RF_B=>RF_B_sig);

	ALUSTAGE_0: ALUSTAGE port map( RF_A=>BusMuxAOut,
																										RF_B=>BusMuxBOut,
																										Immed=>IDEXOut(106 downto 75),
																										ALU_Bin_sel=>IDEXOut(68),
																										ALU_func=>IDEXOut(72 downto 69),
																										ALU_out=>ALU_out_sig,
																										ALU_Zero=>ALU_Zero);

	MEMSTAGE_0: MEMSTAGE port map(clk=>Clk,
																											Mem_WrEn=>EXMEMOut(9),
																											ALU_MEM_Addr=>EXMEMOut(74 downto 43),
																											MEM_Datain=>EXMEMOut(106 downto 75),
																											MEM_Control=>EXMEMOut(10),
																											MEM_DataOut=>MEM_out_sig);
																											
	IFIDRegister: 				IFID_Register 				port map(input=>InstrSig, output=>IFIDOut, clk=>Clk, reset=>Reset);
	
	IDEXRegister: 				IDEX_Register 			port map(input(31 downto 0)=>RF_A_sig,
																																		input(63 downto 32)=>RF_B_sig,
																																		input(64)=>RF_WrEn,
																																		input(66 downto 65)=>RF_WrData_sel,
																																		input(67)=>RF_B_sel,
																																		input(68)=>ALU_Bin_sel,
																																		input(72 downto 69)=>ALU_func,
																																		input(73)=>MEM_WrEn,
																																		input(74)=>MEM_Control,
																																		input(106 downto 75)=>ImmedSig,
																																		input(111 downto 107)=>IFIDOut(15 downto 11),	--Rt
																																		input(116 downto 112)=>IFIDOut(20 downto 16),	--Rd
																																		input(121 downto 117)=>IFIDOut(25 downto 21),	--Rs
																																		output=>IDEXOut, clk=>Clk, reset=>Reset);
																																		
	EXMEMRegister: 	EXMEM_Register 	port map(input(0)=>IDEXOut(64),	--RF_WrEn
																																		input(2 downto 1)=>IDEXOut(66 downto 65),	--RF_WrData_sel
																																		input(3)=>IDEXOut(67),	--RF_B_sel
																																		input(8 downto 4)=>RtORRdMuxOut,	--Rt/Rd
																																		input(9)=>IDEXOut(73),	--MEM_WrEn
																																		input(10)=>IDEXOut(74),	--MEM_Control
																																		input(42 downto 11)=>IDEXOut(106 downto 75),	--ImmedSig
																																		input(74 downto 43)=>ALU_out_sig,
																																		input(106 downto 75)=>IDEXOut(63 downto 32), --RF_B_sig
																																		output=>EXMEMOut, clk=>Clk, reset=>Reset);
																																		
	MEMWBRegister: 	MEMWB_Register 	port map(input(0)=>EXMEMOut(0),	--RF_WrEn
																																		input(2 downto 1)=>EXMEMOut(2 downto 1),	--RF_WrData_sel
																																		input(3)=>EXMEMOut(3),	--RF_B_sel
																																		input(8 downto 4)=>EXMEMOut(8 downto 4),	--Rt/Rd
																																		input(40 downto 9)=>EXMEMOut(42 downto 11),	--ImmedSig
																																		input(72 downto 41)=>EXMEMOut(74 downto 43),	--ALU_out_sig
																																		input(104 downto 73)=>MEM_out_sig,
																																		output=>MEMWBOut, clk=>Clk, reset=>Reset);
																																		
	ForwardingUnit_0: ForwardingUnit port map(EXMEM_RF_WrEn =>EXMEMOut(0),
																																EXMEM_Rd=>EXMEMOut(8 downto 4),
																																IDEX_Rs=>IDEXOut(121 downto 117),
																																IDEX_Rt=>IDEXOut(111 downto 107),
																																MEMWB_RF_WrEn=>MEMWBOut(0),
																																MEMWB_Rd=>MEMWBOut(8 downto 4),
																																ForwardA =>ForwardASig,
																																ForwardB =>ForwardBSig);

	MEMWB_BusMux: BusMux2 port map(input(0)=>MEMWBOut(72 downto 41),	--ALUOut
--																									input(1)=>MEMWBOut(104 downto 73),	--MEMOut
																									input(1)=>MEMWBOut(40 downto 9),	--MEMOut
																									output=>WBMuxOutSig,
																									control=>MEMWBOut(2));

	BusMux4A: BusMux4 Port Map( input(0)=>IDEXOut(31 downto 0),
																					input(1)=>WBMuxOutSig,
																					input(2)=>EXMEMOut(74 downto 43),
																					input(3)=>std_logic_vector(to_unsigned(0,32)),
																					output=>BusMuxAOut,
																					control=>ForwardASig);

	BusMux4B: BusMux4 Port Map( input(0)=>IDEXOut(63 downto 32),
																					input(1)=>WBMuxOutSig,
																					input(2)=>EXMEMOut(74 downto 43),
																					input(3)=>std_logic_vector(to_unsigned(0,32)),
																					output=>BusMuxBOut,
																					control=>ForwardBSig);

	RtORRdMuxOut<=IDEXOut(116 downto 112);
	Instr<= IFIDOut;
end Structural;