library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity ForwardingUnit is
    Port ( 	EXMEM_RF_WrEn 		: in  STD_LOGIC;
						EXMEM_Rd 						: in  STD_LOGIC_VECTOR (4 downto 0);
						IDEX_Rs 								: in  STD_LOGIC_VECTOR (4 downto 0);
						IDEX_Rt 								: in  STD_LOGIC_VECTOR (4 downto 0);
						MEMWB_RF_WrEn 	: in  STD_LOGIC;
						MEMWB_Rd						: in  STD_LOGIC_VECTOR (4 downto 0);
						ForwardA 							: out  STD_LOGIC_VECTOR (1 downto 0);
						ForwardB 							: out  STD_LOGIC_VECTOR (1 downto 0));
end ForwardingUnit;
architecture Behavioral of ForwardingUnit is
begin
process(EXMEM_RF_WrEn, EXMEM_Rd, IDEX_Rs, IDEX_Rt, MEMWB_RF_WrEn, MEMWB_Rd)
begin
	if(EXMEM_RF_WrEn='1' and (EXMEM_Rd/="00000") and (EXMEM_Rd=IDEX_Rs)) then
		ForwardA<="10";
	elsif(MEMWB_RF_WrEn='1' and (MEMWB_Rd/="00000") and (MEMWB_Rd=IDEX_Rs)) then
		ForwardA<="01";
	else
		ForwardA<="00";
	end if;
	
	if(EXMEM_RF_WrEn='1' and (EXMEM_Rd/="00000") and (EXMEM_Rd=IDEX_Rt)) then
		ForwardB<="10";
	elsif(MEMWB_RF_WrEn='1' and (MEMWB_Rd/="00000") and (MEMWB_Rd=IDEX_Rt)) then
		ForwardB<="01";
	else
		ForwardB<="00";
	end if;
end process;
end Behavioral;