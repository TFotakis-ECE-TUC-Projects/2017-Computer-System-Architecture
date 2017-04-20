library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity HazardDetectionUnit is
    Port ( IDEX_Opcode : in  		STD_LOGIC_VECTOR(5 downto 0);
					  IDEX_Rt 						: in  		STD_LOGIC_VECTOR (4 downto 0);
					  IFID_Rs 						: in  		STD_LOGIC_VECTOR (4 downto 0);
					  IFID_Rt 						: in  		STD_LOGIC_VECTOR (4 downto 0);
					  output 							: out  	STD_LOGIC);
end HazardDetectionUnit;
architecture Behavioral of HazardDetectionUnit is
begin
	process(IDEX_Opcode, IDEX_Rt, IFID_Rs, IFID_Rt)
	begin
		if((IDEX_Opcode="001111" or IDEX_Opcode="000011") and ((IDEX_Rt = IFID_Rs) or (IDEX_Rt = IFID_Rt))) then 
			output<='0';
		else
			output<='1';
		end if;
	end process;
end Behavioral;