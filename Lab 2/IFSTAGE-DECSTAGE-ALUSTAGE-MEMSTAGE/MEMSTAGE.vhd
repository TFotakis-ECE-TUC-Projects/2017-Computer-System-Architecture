library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_Datain : in  STD_LOGIC_VECTOR (31 downto 0);
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
begin
	Data_MEM_0: Data_MEM port map(clk=>clk, we=>Mem_WrEn, addr=>ALU_MEM_Addr(11 downto 2), din=>MEM_Datain, dout=>MEM_DataOut);
end Structural;