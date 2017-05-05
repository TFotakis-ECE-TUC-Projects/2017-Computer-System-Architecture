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
--	component IFID_Register
--	Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
--					output : out  STD_LOGIC_VECTOR (31 downto 0);
--					clk : in  STD_LOGIC;
--						reset : in STD_LOGIC);
--	end component;

	component Register32
		 Port (	data 	: in  	STD_LOGIC_VECTOR (31 downto 0);
						dout 	: out  STD_LOGIC_VECTOR (31 downto 0);
						we 	: in  	STD_LOGIC;
						reset : in  	STD_LOGIC;
						clk 	: in  	STD_LOGIC);
	end component;
	
	component IDEX_Register
    Port ( input : in  STD_LOGIC_VECTOR (129 downto 0);
					output : out  STD_LOGIC_VECTOR (129 downto 0);
					clk : in  STD_LOGIC;
						reset : in STD_LOGIC);
	end component;
	component EXMEM_Register 
    Port ( input : in  STD_LOGIC_VECTOR (108 downto 0);
					output : out  STD_LOGIC_VECTOR (108 downto 0);
					clk : in  STD_LOGIC;
						reset : in STD_LOGIC);
	end component;
	component MEMWB_Register
    Port ( input : in  STD_LOGIC_VECTOR (106 downto 0);
					output : out  STD_LOGIC_VECTOR (106 downto 0);
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
	
	component HazardDetectionUnit 
	Port(	  IDEX_Opcode 		: in  		STD_LOGIC_VECTOR(5 downto 0);
					  IDEX_Rt 						: in  		STD_LOGIC_VECTOR (4 downto 0);
					  IFID_Rs 						: in  		STD_LOGIC_VECTOR (4 downto 0);
					  IFID_Rt 						: in  		STD_LOGIC_VECTOR (4 downto 0);
					  PC_LdEn					: in 		STD_LOGIC;
					  output 							: out  	STD_LOGIC);
	end component;
	
	signal HazardDetectionUnitOut, processedPC_sel, ALU_Zero_sig, PC_LdEn_sig, PC_LdEn_sig2 : STD_LOGIC;
	signal ForwardASig, ForwardBSig : STD_LOGIC_VECTOR(1 downto 0);
	signal IDEXControl : STD_LOGIC_VECTOR(10 downto 0);
	signal IDEXOpcode : STD_LOGIC_VECTOR(5 downto 0);
	signal InstrSig, ALU_out_sig, MEM_out_sig, ImmedSig, RF_A_sig, RF_B_sig, WBMuxOutSig, BusMuxAOut, BusMuxBOut: STD_LOGIC_VECTOR (31 downto 0);
	signal IFIDOut: STD_LOGIC_VECTOR(31 downto 0);
	signal IDEXOut: STD_LOGIC_VECTOR(129 downto 0);
	signal EXMEMOut: STD_LOGIC_VECTOR(108 downto 0);
	signal MEMWBOut: STD_LOGIC_VECTOR(106 downto 0);
	signal RtORRdMuxOut, IDEX_Rd: STD_LOGIC_VECTOR(4 downto 0);
begin
	PC_LdEn_sig2<=PC_LdEn_sig or HazardDetectionUnitOut;

	IFSTAGE_0: IFSTAGE port map(	PC_Immed=>MEMWBOut(40 downto 9),
																							PC_Sel=>MEMWBOut(105),
																							PC_LdEn=>HazardDetectionUnitOut,
																							Reset=>Reset,
																							Clk=>Clk,
																							Instr=>InstrSig);

	DECSTAGE_0: DECSTAGE port map(Instr=>IFIDOut,
																										Awr=>MEMWBOut(8 downto 4),
																										RF_WrEn=>MEMWBOut(0),
																										WBMuxOut=>WBMuxOutSig,
--																										RF_WrData_sel=>MEMWBOut(1),
																										RF_WrData_sel=>'0',
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
																										ALU_Zero=>ALU_Zero_sig);
ALU_Zero<=ALU_Zero_sig;
	MEMSTAGE_0: MEMSTAGE port map(clk=>Clk,
																											Mem_WrEn=>EXMEMOut(9),
																											ALU_MEM_Addr=>EXMEMOut(74 downto 43),
																											MEM_Datain=>EXMEMOut(106 downto 75),
																											MEM_Control=>EXMEMOut(10),
																											MEM_DataOut=>MEM_out_sig);
																											
--	IFIDRegister: 				IFID_Register 				port map(input=>InstrSig, output=>IFIDOut, clk=>Clk, reset=>Reset);
	IFIDRegister: Register32 Port Map(data=>InstrSig, 
																									dout=>IFIDOut,
																									we=>HazardDetectionUnitOut,
																									reset=>Reset,
																									clk=>Clk);

	IDEXControl(0)<=RF_WrEn and HazardDetectionUnitOut;
	IDEXControl(1)<=RF_WrData_sel(0) and HazardDetectionUnitOut;
	IDEXControl(2)<=RF_WrData_sel(1) and HazardDetectionUnitOut;
	IDEXControl(3)<=RF_B_sel and HazardDetectionUnitOut;
	IDEXControl(4)<=ALU_Bin_sel and HazardDetectionUnitOut;
	IDEXControl(5)<=ALU_func(0) and HazardDetectionUnitOut;
	IDEXControl(6)<=ALU_func(1) and HazardDetectionUnitOut;
	IDEXControl(7)<=ALU_func(2) and HazardDetectionUnitOut;
	IDEXControl(8)<=ALU_func(3) and HazardDetectionUnitOut;
	IDEXControl(9)<=MEM_WrEn and HazardDetectionUnitOut;
	IDEXControl(10)<=MEM_Control and HazardDetectionUnitOut;
	IDEXOpcode(0)<=IFIDOut(26) and HazardDetectionUnitOut;
	IDEXOpcode(1)<=IFIDOut(27) and HazardDetectionUnitOut;
	IDEXOpcode(2)<=IFIDOut(28) and HazardDetectionUnitOut;
	IDEXOpcode(3)<=IFIDOut(29) and HazardDetectionUnitOut;
	IDEXOpcode(4)<=IFIDOut(30) and HazardDetectionUnitOut;
	IDEXOpcode(5)<=IFIDOut(31) and HazardDetectionUnitOut;
	PC_LdEn_sig<=PC_LdEn and HazardDetectionUnitOut;
	IDEX_Rd(0)<=IDEXOut(112) and HazardDetectionUnitOut;
	IDEX_Rd(1)<=IDEXOut(113) and HazardDetectionUnitOut;
	IDEX_Rd(2)<=IDEXOut(114) and HazardDetectionUnitOut;
	IDEX_Rd(3)<=IDEXOut(115) and HazardDetectionUnitOut;
	IDEX_Rd(4)<=IDEXOut(116) and HazardDetectionUnitOut;
	
	IDEXRegister: 				IDEX_Register 			port map(input(31 downto 0)=>RF_A_sig,
																																		input(63 downto 32)=>RF_B_sig,
																																		input(74 downto 64)=>IDEXControl,
--																																		input(64)=>RF_WrEn,
--																																		input(66 downto 65)=>RF_WrData_sel,
--																																		input(67)=>RF_B_sel,
--																																		input(68)=>ALU_Bin_sel,
--																																		input(72 downto 69)=>ALU_func,
--																																		input(73)=>MEM_WrEn,
--																																		input(74)=>MEM_Control,
																																		input(106 downto 75)=>ImmedSig,
																																		input(111 downto 107)=>IFIDOut(15 downto 11),	--Rt
																																		input(116 downto 112)=>IFIDOut(20 downto 16),	--Rd
--																																		input(116 downto 112)=>IDEX_Rd,	--Rd
																																		input(121 downto 117)=>IFIDOut(25 downto 21),	--Rs
																																		input(127 downto 122)=>IDEXOpcode,	--Opcode
																																		input(128)=>PC_sel,
																																		input(129)=>PC_LdEn_sig,
																																		output=>IDEXOut, clk=>Clk, reset=>Reset);
																																			
process(clk,PC_sel,IDEXOpcode,ALU_Zero_sig)
begin
	if(IDEXOpcode="000000" and ALU_Zero_sig='1') then
		processedPC_sel<='1';
	elsif(IDEXOpcode="000001" and ALU_Zero_sig='0') then
		processedPC_sel<='1';
	else
		processedPC_sel<='0';
	end if;
end process;
																																		
																																		
	EXMEMRegister: 	EXMEM_Register 	port map(input(0)=>IDEXOut(64),	--RF_WrEn
																																		input(2 downto 1)=>IDEXOut(66 downto 65),	--RF_WrData_sel
																																		input(3)=>IDEXOut(67),	--RF_B_sel
																																		input(8 downto 4)=>RtORRdMuxOut,	--Rt/Rd
																																		input(9)=>IDEXOut(73),	--MEM_WrEn
																																		input(10)=>IDEXOut(74),	--MEM_Control
																																		input(42 downto 11)=>IDEXOut(106 downto 75),	--ImmedSig
																																		input(74 downto 43)=>ALU_out_sig,
																																		input(106 downto 75)=>IDEXOut(63 downto 32), --RF_B_sig
																																		input(107)=>processedPC_sel,
																																		input(108)=>IDEXOut(129),
																																		output=>EXMEMOut, clk=>Clk, reset=>Reset);
																																		
	MEMWBRegister: 	MEMWB_Register 	port map(input(0)=>EXMEMOut(0),	--RF_WrEn
																																		input(2 downto 1)=>EXMEMOut(2 downto 1),	--RF_WrData_sel
																																		input(3)=>EXMEMOut(3),	--RF_B_sel
																																		input(8 downto 4)=>EXMEMOut(8 downto 4),	--Rt/Rd
																																		input(40 downto 9)=>EXMEMOut(42 downto 11),	--ImmedSig
																																		input(72 downto 41)=>EXMEMOut(74 downto 43),	--ALU_out_sig
																																		input(104 downto 73)=>MEM_out_sig,
--																																		input(105)=>EXMEMOut(107),
																																		input(105)=>processedPC_sel,
																																		input(106)=>EXMEMOut(108),
																																		output=>MEMWBOut, clk=>Clk, reset=>Reset);
																																		
	ForwardingUnit_0: ForwardingUnit port map(EXMEM_RF_WrEn =>EXMEMOut(0),
																																EXMEM_Rd=>EXMEMOut(8 downto 4),
																																IDEX_Rs=>IDEXOut(121 downto 117),
																																IDEX_Rt=>IDEXOut(111 downto 107),
																																MEMWB_RF_WrEn=>MEMWBOut(0),
																																MEMWB_Rd=>MEMWBOut(8 downto 4),
																																ForwardA =>ForwardASig,
																																ForwardB =>ForwardBSig);

	MEMWB_BusMux: BusMux4 port map(	input(0)=>MEMWBOut(72 downto 41),	--ALUOut
																												input(1)=>MEMWBOut(40 downto 9),	--ImmedSig
																												input(2)=>MEMWBOut(104 downto 73),	--MEMOut
																												input(3)=>std_logic_vector(to_unsigned(0,32)),
																												output=>WBMuxOutSig,
																												control(0)=>MEMWBOut(2),
																												control(1)=>MEMWBOut(1));

	BusMux4A: BusMux4 Port Map(input(0)=>IDEXOut(31 downto 0),
																							input(1)=>WBMuxOutSig,
																							input(2)=>EXMEMOut(74 downto 43),
																							input(3)=>std_logic_vector(to_unsigned(0,32)),
																							output=>BusMuxAOut,
																							control=>ForwardASig);

	BusMux4B: BusMux4 Port Map( 	input(0)=>IDEXOut(63 downto 32),
																								input(1)=>WBMuxOutSig,
																								input(2)=>EXMEMOut(74 downto 43),
																								input(3)=>std_logic_vector(to_unsigned(0,32)),
																								output=>BusMuxBOut,
																								control=>ForwardBSig);

HazardDetectionUnit_0: HazardDetectionUnit Port Map (IDEX_Opcode=>IDEXOut(127 downto 122),
																																						  IDEX_Rt=>IDEXOut(116 downto 112),
																																						  IFID_Rs=>IFIDOut(25 downto 21),
																																						  IFID_Rt=>IFIDOut(15 downto 11),
																																						  PC_LdEn=>MEMWBOut(106),
																																						  output=>HazardDetectionUnitOut);

	RtORRdMuxOut<=IDEXOut(116 downto 112);
	Instr<= IFIDOut;
end Structural;