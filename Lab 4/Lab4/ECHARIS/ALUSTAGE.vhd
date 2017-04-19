library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
use IEEE.NUMERIC_STD.ALL; 
entity ALUSTAGE is
    Port (RF_A 				: in  	STD_LOGIC_VECTOR (31 downto 0);
				RF_B 					: in  	STD_LOGIC_VECTOR (31 downto 0);
				Immed 				: in  	STD_LOGIC_VECTOR (31 downto 0);
				MEM_out			: in 	STD_LOGIC_VECTOR (31 downto 0);
				MEM_Reg_out : in  STD_LOGIC_VECTOR (31 downto 0);
				baseAddr_out : in  STD_LOGIC_VECTOR (31 downto 0);
				ALU_Ain_sel	: in  	STD_LOGIC_VECTOR(2 downto 0);
				ALU_Bin_sel	: in  	STD_LOGIC_VECTOR(2 downto 0);
				ALU_func 		: in  	STD_LOGIC_VECTOR (3 downto 0);
				ALU_out 			: out  STD_LOGIC_VECTOR (31 downto 0);
				ALU_Zero			: out 	STD_LOGIC);
end ALUSTAGE;
architecture Structural of ALUSTAGE is
	component ALU
		 Port (A 			: in  	STD_LOGIC_VECTOR (31 downto 0);
					B 			: in  	STD_LOGIC_VECTOR (31 downto 0);
					Op 			: in  	STD_LOGIC_VECTOR (3 downto 0);
					output 	: out  STD_LOGIC_VECTOR (31 downto 0);
					Zero 		: out  STD_LOGIC;
					Cout 		: out  STD_LOGIC;
					Ovf 		: out  STD_LOGIC);
	end component;

	component BusMux8
    Port ( 	input 	: in  	Bus8;
					output	: out  STD_LOGIC_VECTOR (31 downto 0);
					control	: in  	STD_LOGIC_VECTOR(2 downto 0));
	end component;
	signal muxOutA, muxOutB, rs7_0, rt7_0, rs15_8, rt15_8, rs23_16, rt23_16, rs31_24, rt31_24: STD_LOGIC_VECTOR (31 downto 0);
begin
	ALU_0: ALU port map(A=>muxOutA, B=>muxOutB, Op=>ALU_func, output=>ALU_out, Zero=>ALU_Zero);
		BusMux8_1: BusMux8 port map(	input(0)=>RF_A, 
																								input(1)=>std_logic_vector(to_unsigned(0,32)), 
																								input(2)=>rs7_0, 
																								input(3)=>rs15_8, 
																								input(4)=>rs23_16, 
																								input(5)=>rs31_24, 
																								input(6)=>MEM_out, 
																								input(7)=>baseAddr_out, 
																								output=>muxOutA, 
																								control=>ALU_Ain_sel);
		BusMux8_0: BusMux8 port map(	input(0)=>RF_B, 
																								input(1)=>Immed, 
																								input(2)=>rt7_0, 
																								input(3)=>rt15_8, 
																								input(4)=>rt23_16, 
																								input(5)=>rt31_24, 
																								input(6)=>MEM_Reg_out, 
																								input(7)=>std_logic_vector(to_unsigned(4,32)), 
																								output=>muxOutB, 
																								control=>ALU_Bin_sel);

	rs7_0(31 downto 8)<=std_logic_vector(to_unsigned(0,24));
	rs7_0(7 downto 0)<=RF_A(7 downto 0);
	rt7_0(31 downto 8)<=std_logic_vector(to_unsigned(0,24));
	rt7_0(7 downto 0)<=RF_B(7 downto 0);
	
	rs15_8(31 downto 8)<=std_logic_vector(to_unsigned(0,24));
	rs15_8(7 downto 0)<=RF_A(15 downto 8);
	rt15_8(31 downto 8)<=std_logic_vector(to_unsigned(0,24));
	rt15_8(7 downto 0)<=RF_B(15 downto 8);
	
	rs23_16(31 downto 8)<=std_logic_vector(to_unsigned(0,24));
	rs23_16(7 downto 0)<=RF_A(23 downto 16);
	rt23_16(31 downto 8)<=std_logic_vector(to_unsigned(0,24));
	rt23_16(7 downto 0)<=RF_B(23 downto 16);
	
	rs31_24(31 downto 8)<=std_logic_vector(to_unsigned(0,24));
	rs31_24(7 downto 0)<=RF_A(31 downto 24);
	rt31_24(31 downto 8)<=std_logic_vector(to_unsigned(0,24));
	rt31_24(7 downto 0)<=RF_B(31 downto 24);
end Structural;