library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
entity RegisterFile is
    Port (	Ard1 	: in  	STD_LOGIC_VECTOR (4 downto 0);
					Ard2 	: in  	STD_LOGIC_VECTOR (4 downto 0);
					Awr 		: in  	STD_LOGIC_VECTOR (4 downto 0);
					Dout1 	: out  STD_LOGIC_VECTOR (31 downto 0);
					Dout2 	: out  STD_LOGIC_VECTOR (31 downto 0);
					Din 		: in  	STD_LOGIC_VECTOR (31 downto 0);
					WrEn		: in 	STD_LOGIC;
					reset 	: in  	STD_LOGIC;
					clk 		: in  	STD_LOGIC);
end RegisterFile;
architecture Structural of RegisterFile is
	component Register32
		 Port (	data 	: in  	STD_LOGIC_VECTOR (31 downto 0);
						dout 	: out  STD_LOGIC_VECTOR (31 downto 0);
						we 	: in  	STD_LOGIC;
						reset : in  	STD_LOGIC;
						clk 	: in  	STD_LOGIC);
	end component;
	component Decoder5to32
		Port ( 	input 	: in  	STD_LOGIC_VECTOR (4 downto 0);
						output	: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	component BusMux32
		Port ( 	input		: in		Bus32;
						output	: out  STD_LOGIC_VECTOR (31 downto 0);
						control : in  	STD_LOGIC_VECTOR (4 downto 0));
	end component;
	
	component Comparator
		Port ( 	inA 		: in  	STD_LOGIC_VECTOR (4 downto 0);
						inB 		: in  	STD_LOGIC_VECTOR (4 downto 0);
						WrEn		: in		STD_LOGIC;
						output	: out  STD_LOGIC);
	end component;
	
	component BusMux2
		Port ( 	input 	: in  	Bus2;
						output	: out  STD_LOGIC_VECTOR (31 downto 0);
						control	: in  	STD_LOGIC);
	end component;	

	signal register32out: Bus32;
	signal busMux32out: Bus2;
	signal decoderOut, WrEnable: STD_LOGIC_VECTOR (31 downto 0);
	signal comparatorOut: STD_LOGIC_VECTOR(1 downto 0);
begin
	decoder: Decoder5to32 port map(input=>Awr, output=>decoderOut);
	
	wrEnable(0)<='0';
	WriteEnable: for i in 1 to 31 generate
			wrEnable(i)<=decoderOut(i) and WrEn;
	end generate;
	
	Register32Gen : for i in 0 to 31 generate
		register32_i: Register32 port map(data=>din, dout=>register32out(i), we=>WrEnable(i), reset=>reset, clk=>clk);
	end generate Register32Gen;
	
	busMux32_0: BusMux32 port map(input=>register32out,output=>busMux32out(0), control=>Ard1);
	busMux32_1: BusMux32 port map(input=>register32out,output=>busMux32out(1), control=>Ard2);
	
	comparator_0: Comparator port map(inA=>Ard1, inB=>Awr, WrEn=>WrEn, output=>comparatorOut(0));
	comparator_1: Comparator port map(inA=>Ard2, inB=>Awr, WrEn=>WrEn, output=>comparatorOut(1));
	
	busMux2_0: BusMux2 port map(input(0)=>busMux32out(0), input(1)=>Din, output=>Dout1, control=>comparatorOut(0));
	busMux2_1: BusMux2 port map(input(0)=>busMux32out(1), input(1)=>Din, output=>Dout2, control=>comparatorOut(1));
end Structural;