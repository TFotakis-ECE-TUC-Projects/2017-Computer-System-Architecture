library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_Datain : in  STD_LOGIC_VECTOR (31 downto 0);
			  MEM_Control : in STD_LOGIC;
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
	signal data, zeroFillDataIn, zeroFillDataOut, MEM_DataOut_sig : STD_LOGIC_VECTOR (31 downto 0);
begin
	Data_MEM_0: Data_MEM port map(clk=>clk, we=>Mem_WrEn, addr=>ALU_MEM_Addr(11 downto 2), din=>data, dout=>MEM_DataOut_sig);
	BusMux2_0: BusMux2 port map(input(0)=>MEM_DataIn, input(1)=>zeroFillDataIn,	output=>data, control=>MEM_Control);
	zeroFillDataIn(31 downto 8)<= "000000000000000000000000";
	zeroFillDataIn(7 downto 0)<=MEM_DataIn(7 downto 0);
	BusMux2_1: BusMux2 port map(input(0)=>MEM_DataOut_sig, input(1)=>zeroFillDataOut,	output=>MEM_DataOut, control=>MEM_Control);
	zeroFillDataOut(31 downto 8)<= "000000000000000000000000";
	zeroFillDataOut(7 downto 0)<=MEM_DataOut_sig(7 downto 0);
end Structural;