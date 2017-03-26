library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
use IEEE.NUMERIC_STD.ALL;
entity MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
			  Immed_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
				baseAddr_out : in STD_LOGIC_VECTOR (31 downto 0);
				bum_out : in STD_LOGIC_VECTOR (31 downto 0);
			  RF_A : in STD_LOGIC_VECTOR(31 downto 0);
			  RF_B : in STD_LOGIC_VECTOR(31 downto 0);
			  MEM_Addr_sel : in STD_LOGIC_VECTOR(2 downto 0);
           MEM_Datain : in  STD_LOGIC_VECTOR (31 downto 0);
			  MEM_Control : in STD_LOGIC_VECTOR(1 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;
 architecture Structural of MEMSTAGE is
	component Data_MEM is
		port (	clk 		: in 	std_logic;
						we 		: in 	std_logic;
						addr 	: in 	std_logic_vector(9 downto 0);
						din 	: in		std_logic_vector(31 downto 0);
						dout 	: out 	std_logic_vector(31 downto 0));
	end component;
	component BusMux2
		Port ( input 	: in  	Bus2;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC);
	end component;
	component BusMux4
		Port ( input 	: in  	Bus4;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC_VECTOR (1 downto 0));
	end component;
	component BusMux8
		Port ( input 	: in  	Bus8;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC_VECTOR (2 downto 0));
	end component;
	signal data, zeroFillDataIn, zeroFillDataOut, MEM_DataOut_sig, addr_sig : STD_LOGIC_VECTOR (31 downto 0);
begin
	Data_MEM_0: Data_MEM port map(clk=>clk, we=>Mem_WrEn, addr=>addr_sig(11 downto 2), din=>data, dout=>MEM_DataOut_sig);
	BusMux8_0: BusMux8 port map(	input(0)=>ALU_MEM_Addr, 
																								input(1)=>Immed_MEM_Addr,
																								input(2)=>RF_A,
																								input(3)=>RF_B,
																								input(4)=>baseAddr_out,
																								input(5)=>std_logic_vector(to_unsigned(0,32)),
																								input(6)=>std_logic_vector(to_unsigned(0,32)),
																								input(7)=>std_logic_vector(to_unsigned(0,32)),
																								output=>addr_sig, 
																								control=>MEM_Addr_sel);
	BusMux4_0: BusMux4 port map(	input(0)=>MEM_DataIn, 
																								input(1)=>zeroFillDataIn,	
																								input(2)=>bum_out,	
																								input(3)=>std_logic_vector(to_unsigned(0,32)),
																								output=>data, 
																								control=>MEM_Control);
	zeroFillDataIn(31 downto 8)<= "000000000000000000000000";
	zeroFillDataIn(7 downto 0)<=MEM_DataIn(7 downto 0);
	BusMux2_2: BusMux2 port map(input(0)=>MEM_DataOut_sig, input(1)=>zeroFillDataOut,	output=>MEM_DataOut, control=>MEM_Control(0));
	zeroFillDataOut(31 downto 8)<= "000000000000000000000000";
	zeroFillDataOut(7 downto 0)<=MEM_DataOut_sig(7 downto 0);
end Structural;