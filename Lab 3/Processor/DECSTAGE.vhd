library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
entity DECSTAGE is
    Port (Instr 						: in  	STD_LOGIC_VECTOR (31 downto 0);
				RF_WrEn 				: in  	STD_LOGIC;
				ALU_out 				: in  	STD_LOGIC_VECTOR (31 downto 0);
				MEM_out 			: in  	STD_LOGIC_VECTOR (31 downto 0);
				RF_WrData_sel	: in  	STD_LOGIC_VECTOR (1 downto 0);
				RF_B_sel 				: in  	STD_LOGIC;
				RF_AB_we			: in 	STD_LOGIC;
				Reset 					: in  	STD_LOGIC;
				Clk 						: in  	STD_LOGIC;
				Immed 				: out  STD_LOGIC_VECTOR (31 downto 0);
				RF_A 						: out  STD_LOGIC_VECTOR (31 downto 0);
				RF_B 						: out  STD_LOGIC_VECTOR (31 downto 0));
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

	component BusMux2
    Port ( 	input 	: in  	Bus2;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC);
	end component;
	
	component Mux2 
	Port (		input 	: in  	STD_LOGIC_VECTOR (1 downto 0);
					output 	: out  STD_LOGIC;
					control	: in  	STD_LOGIC);
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
	
	signal RF_B_Addr : STD_LOGIC_VECTOR (4 downto 0);
	signal RF_WrData, RF_WrData_mux1, ImmedSig, RF_A_sig, RF_B_sig : STD_LOGIC_VECTOR (31 downto 0);
begin
	RegisterFile_0: RegisterFile port map(Ard1=>Instr(25 downto 21), Ard2=>RF_B_Addr, Awr=>Instr(20 downto 16), Dout1=>RF_A_sig, Dout2=>RF_B_sig, Din=>RF_WrData, WrEn=>RF_WrEn, reset=>Reset, clk=>Clk);
	Mux_RF_B: for i in 0 to 4 generate
		mux2_i: Mux2 port map(input(0)=>Instr(11+i), 	input(1)=>Instr(16+i), 	output=>RF_B_Addr(i), 	control=>RF_B_sel);
	end generate Mux_RF_B;
	BusMux_RF_WrData_0: BusMux2 port map(input(0)=>ALU_out, input(1)=>MEM_out, output=>RF_WrData_mux1, control=>RF_WrData_sel(0));
	BusMux_RF_WrData_1: BusMux2 port map(input(0)=>RF_WrData_mux1, input(1)=>ImmedSig, output=>RF_WrData, control=>RF_WrData_sel(1));
	ImmediateProcessor_0: ImmediateProcessor port map(Data=>Instr(15 downto 0), Dout=>ImmedSig, Instr=>Instr(31 downto 26));
	Register32_A: Register32 port map(data=>RF_A_sig, dout=>RF_A, we=>RF_AB_we, reset=>Reset, clk=>Clk);
	Register32_B: Register32 port map(data=>RF_B_sig, dout=>RF_B, we=>RF_AB_we, reset=>Reset, clk=>Clk);
	Immed<=ImmedSig;
end Structural;