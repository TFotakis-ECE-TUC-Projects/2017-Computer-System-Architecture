library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.Bus32pkg.ALL;
entity IFSTAGE is
    Port ( EPC : in  STD_LOGIC_VECTOR (31 downto 0);
					PC_Sel : in  STD_LOGIC_VECTOR(1 downto 0);
					PC_LdEn : in  STD_LOGIC;
					Reset : in  STD_LOGIC;
					Clk : in  STD_LOGIC;
					Instr : out  STD_LOGIC_VECTOR (31 downto 0);
					Addr: out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Structural of IFSTAGE is
component Register32
    Port ( 	data 	: in  	STD_LOGIC_VECTOR (31 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (31 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end component;

component IF_MEM
	port (	clk : in std_logic;
					addr : in std_logic_vector(9 downto 0);
					dout : out std_logic_vector(31 downto 0));
end component;

component Addition
    Port (	A : in  STD_LOGIC_VECTOR (31 downto 0);
					B : in  STD_LOGIC_VECTOR (31 downto 0);
					CarryIn : in  STD_LOGIC;
					CarryOut : out  STD_LOGIC;
					Ovf :out STD_LOGIC;
					output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component BusMux4
    Port ( 	input 	: in  	Bus4;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC_VECTOR(1 downto 0));
end component;

component BusMux2
    Port ( 	input 	: in  	Bus2;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC);
end component;

signal muxOut, PCout, PC_plus_4_out, PC_plus_EPC_out, RegMuxOut: STD_LOGIC_VECTOR (31 downto 0);


begin
	PC_Register32: Register32 port map(data=>RegMuxOut, dout=>PCout, we=>PC_LdEn, reset=>Reset, clk=>Clk);
	IF_MEM_0: IF_MEM port map(clk=>Clk, addr=>muxOut (11 downto 2), dout=>Instr);
	PC_plus_4: Addition port map(A=>PCout, B=>std_logic_vector(to_unsigned(4,32)), CarryIn=>'0', output=>PC_plus_4_out);
--	PC_plus_Imm: Addition port map(A=>std_logic_vector(to_unsigned(0,32)), B=>EPC, CarryIn=>'0', output=>PC_plus_EPC_out);
	BusMux4_0: BusMux4 port map(	input(0)=>PC_plus_4_out, 
																						input(1)=>EPC, 
																						input(2)=>std_logic_vector(to_unsigned(260,32)),
																						input(3)=>std_logic_vector(to_unsigned(516,32)),
																						output=>RegMuxOut, 
																						control=>PC_Sel);
	BusMux4_1: BusMux4 port map(	input(0)=>PCOut, 
																						input(1)=>PCOut, 
																						input(2)=>std_logic_vector(to_unsigned(256,32)), 
																						input(3)=>std_logic_vector(to_unsigned(512,32)), 
																						output=>muxOut, 
																						control=>PC_Sel);
	Addr<=PCout;
end Structural;