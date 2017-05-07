library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.Bus32pkg.ALL;
entity IFSTAGE is
    Port ( 	PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
					PC_Sel : in  STD_LOGIC;
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

component BusMux2
    Port ( 	input 	: in  	Bus2;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC);
end component;

signal muxOut, PCout, PC_plus_4_out, PC_plus_Imm_out: STD_LOGIC_VECTOR (31 downto 0);


begin
	PC_Register32: Register32 port map(data=>muxOut, dout=>PCout, we=>PC_LdEn, reset=>Reset, clk=>Clk);
	IF_MEM_0: IF_MEM port map(clk=>Clk, addr=>PCout (11 downto 2), dout=>Instr);
	PC_plus_4: Addition port map(A=>PCout, B=>std_logic_vector(to_unsigned(4,32)), CarryIn=>'0', output=>PC_plus_4_out);
	PC_plus_Imm: Addition port map(A=>PC_plus_4_out, B=>PC_Immed, CarryIn=>'0', output=>PC_plus_Imm_out);
	BusMux2_0: BusMux2 port map(input(0)=>PC_plus_4_out, input(1)=>PC_plus_Imm_out, output=>muxOut, control=>PC_Sel);
	Addr<=PCout;
end Structural;