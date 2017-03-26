library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.Bus32pkg.ALL;
entity DECSTAGE is
    Port (Instr 						: in  	STD_LOGIC_VECTOR (31 downto 0);
				RF_WrEn 				: in  	STD_LOGIC;
				ALU_out 				: in  	STD_LOGIC_VECTOR (31 downto 0);
				MEM_out 			: in  	STD_LOGIC_VECTOR (31 downto 0);
				MEM_Reg_we :in STD_LOGIC;
				RF_WrData_sel	: in  	STD_LOGIC_VECTOR (2 downto 0);
				RF_B_sel 				: in  	STD_LOGIC;
				RF_AB_we			: in 	STD_LOGIC;
				mmx_we					: in STD_LOGIC_VECTOR(2 downto 0);
				bpm_we					: in STD_LOGIC_VECTOR(2 downto 0);
				baseAddr_we		: in STD_LOGIC;
				bum_sel		: in STD_LOGIC_VECTOR(1 downto 0);
				Reset 					: in  	STD_LOGIC;
				Clk 						: in  	STD_LOGIC;
				Immed 				: out  STD_LOGIC_VECTOR (31 downto 0);
				RF_A 						: out  STD_LOGIC_VECTOR (31 downto 0);
				RF_B 						: out  STD_LOGIC_VECTOR (31 downto 0);
				MEM_Reg_out : out  STD_LOGIC_VECTOR (31 downto 0);
				baseAddr_out : out STD_LOGIC_VECTOR (31 downto 0);
				bum_out : out STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Structural of DECSTAGE is
	component RegisterFile is
		 Port (	Ard1 		: in  	STD_LOGIC_VECTOR (4 downto 0);
						Ard2 		: in  	STD_LOGIC_VECTOR (4 downto 0);
						Awr 		: in  	STD_LOGIC_VECTOR (4 downto 0);
						Dout1 	: out  STD_LOGIC_VECTOR (31 downto 0);
						Dout2 	: out  STD_LOGIC_VECTOR (31 downto 0);
						Din 		: in  	STD_LOGIC_VECTOR (31 downto 0);
						WrEn		: in 	STD_LOGIC;
						reset 	: in  	STD_LOGIC;
						clk 			: in  	STD_LOGIC);
	end component;

	component BusMux8
    Port ( 	input 	: in  	Bus8;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC_VECTOR(2 downto 0));
	end component;
	
	component BusMux4
    Port ( 	input 	: in  	Bus4;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC_VECTOR(1 downto 0));
	end component;
	
	component Mux2 
	Port (input 	: in  	STD_LOGIC_VECTOR (1 downto 0);
					output 	: out  STD_LOGIC;
					control	: in  	STD_LOGIC);
	end component;
	
	component Mux4 
	Port (input 	: in  	STD_LOGIC_VECTOR (3 downto 0);
					output 	: out  STD_LOGIC;
					control	: in  	STD_LOGIC_VECTOR(1 downto 0));
	end component;
	
	
	component ImmediateProcessor 
	Port ( 	Data : in  	STD_LOGIC_VECTOR (15 downto 0);
					Dout : out  	STD_LOGIC_VECTOR (31 downto 0);
					Instr : in  	STD_LOGIC_VECTOR (5 downto 0));
	end component;
	
	component Register32
    Port ( 	data 	: in  	STD_LOGIC_VECTOR (31 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (31 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
	end component;
	
	component Register8
    Port ( 	data 	: in  	STD_LOGIC_VECTOR (7 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (7 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
	end component;
	
	component SignExtender
    Port ( 	Din 		: in  STD_LOGIC_VECTOR (7 downto 0);
						Dout 	: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	signal RF_B_Addr : STD_LOGIC_VECTOR (4 downto 0);
	signal RF_WrData, ImmedSig, RF_A_sig, RF_B_sig, RF_A_reg_sig, RF_B_reg_sig, mmx_sig, bpm_sig : STD_LOGIC_VECTOR (31 downto 0);
	signal bumMuxOut : STD_LOGIC_VECTOR (7 downto 0);
begin
	RegisterFile_0: RegisterFile port map(Ard1=>Instr(25 downto 21), Ard2=>RF_B_Addr, Awr=>Instr(20 downto 16), Dout1=>RF_A_sig, Dout2=>RF_B_sig, Din=>RF_WrData, WrEn=>RF_WrEn, reset=>Reset, clk=>Clk);
	Mux_RF_B: for i in 0 to 4 generate
		mux2_i: Mux2 port map(input(0)=>Instr(11+i), 	input(1)=>Instr(16+i), 	output=>RF_B_Addr(i), 	control=>RF_B_sel);
	end generate Mux_RF_B;
	BusMux_RF_WrData_0: BusMux8 port map(input(0)=>ALU_out, 
																															input(1)=>MEM_out, 
																															input(2)=>ImmedSig, 
																															input(3)=>RF_A_reg_sig, 
																															input(4)=>mmx_sig, 
																															input(5)=>bpm_sig, 
																															input(6)=>std_logic_vector(to_unsigned(0,32)), 
																															input(7)=>std_logic_vector(to_unsigned(0,32)), 
																															output=>RF_WrData, 
																															control=>RF_WrData_sel);
	ImmediateProcessor_0: ImmediateProcessor port map(Data=>Instr(15 downto 0), Dout=>ImmedSig, Instr=>Instr(31 downto 26));
	
	Register32_A: Register32 port map(data=>RF_A_sig, dout=>RF_A_reg_sig, we=>RF_AB_we, reset=>Reset, clk=>Clk);
	Register32_B: Register32 port map(data=>RF_B_sig, dout=>RF_B_reg_sig, we=>RF_AB_we, reset=>Reset, clk=>Clk);
	
	Register8_7_0: Register8 port map(data=>ALU_out(7 downto 0), dout=>mmx_sig(7 downto 0), we=>mmx_we(0), reset=>Reset, clk=>Clk);
	Register8_15_8: Register8 port map(data=>ALU_out(7 downto 0), dout=>mmx_sig(15 downto 8), we=>mmx_we(1), reset=>Reset, clk=>Clk);
	Register8_23_16: Register8 port map(data=>ALU_out(7 downto 0), dout=>mmx_sig(23 downto 16), we=>mmx_we(2), reset=>Reset, clk=>Clk);
	mmx_sig(31 downto 24)<=ALU_out(7 downto 0);

	Register8_MEM0: Register8 port map(data=>MEM_out(7 downto 0), dout=>bpm_sig(7 downto 0), we=>bpm_we(0), reset=>Reset, clk=>Clk);
	Register8_MEM4: Register8 port map(data=>MEM_out(7 downto 0), dout=>bpm_sig(15 downto 8), we=>bpm_we(1), reset=>Reset, clk=>Clk);
	Register8_MEM8: Register8 port map(data=>MEM_out(7 downto 0), dout=>bpm_sig(23 downto 16), we=>bpm_we(2), reset=>Reset, clk=>Clk);
	bpm_sig(31 downto 24)<=MEM_out(7 downto 0);

	Register32_bpm: Register32 port map(data=>ALU_out, dout=>baseAddr_out, we=>baseAddr_we, reset=>Reset, clk=>Clk);
	
	Register32_bnem: Register32 port map(data=>MEM_out, dout=>MEM_Reg_out, we=>MEM_Reg_we, reset=>Reset, clk=>Clk);
	
	SignExtender_bum: SignExtender port map(din=>bumMuxOut, dout=>bum_out);
	Mux4x8to1x8_bum: for i in 0 to 7 generate
	mux4_i: Mux4 port map(	input(0)=>RF_B_sig(i),
																			input(1)=>RF_B_sig(8+i),
																			input(2)=>RF_B_sig(16+i),
																			input(3)=>RF_B_sig(24+i),
																			output=>bumMuxOut(i),
																			control=>bum_sel);
	end generate Mux4x8to1x8_bum;
--	BusMux4_bum: BusMux4 port map(input(0)=>RF_B_reg_sig(7 downto 0),
--																										input(1)=>RF_B_reg_sig(15 downto 8),
--																										input(2)=>RF_B_reg_sig(23 downto 16),
--																										input(3)=>RF_B_reg_sig(31 downto 24),
--																										output=>bumMuxOut,
--																										control=>bum_sel);
	RF_A<=RF_A_reg_sig;
	RF_B<=RF_B_reg_sig;
	Immed<=ImmedSig;
end Structural;