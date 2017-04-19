library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Extended_control is
    Port (Instr 						: in  	STD_LOGIC_VECTOR (31 downto 0);
				ALU_Zero				: in		STD_LOGIC;
				Reset 					: in  	STD_LOGIC;
				Clk 						: in  	STD_LOGIC;
				PC_sel 					: out  STD_LOGIC_VECTOR (1 downto 0);
				PC_LdEn 				: out  STD_LOGIC;
				RF_WrEn 				: out  STD_LOGIC;
				RF_WrData_sel 	: out  STD_LOGIC_VECTOR (2 downto 0);
				RF_B_sel 				: out  STD_LOGIC;
				RF_AB_we			: out 	STD_LOGIC;
				ALU_Ain_sel 		: out  STD_LOGIC_VECTOR (2 downto 0);
				ALU_Bin_sel 		: out  STD_LOGIC_VECTOR (2 downto 0);
				ALU_func 			: out 	STD_LOGIC_VECTOR (3 downto 0);
				MEM_WrEn 		: out  STD_LOGIC;
				MEM_Control 		: out 	STD_LOGIC_VECTOR(1 downto 0);
				MEM_Addr_sel : out STD_LOGIC_VECTOR(2 downto 0) ;
				MEM_Reg_we : out STD_LOGIC;
				mmx_we 					: out STD_LOGIC_VECTOR(2 downto 0);
				bpm_we					: out STD_LOGIC_VECTOR(2 downto 0);
				baseAddr_we		: out STD_LOGIC;
				bum_sel		: out STD_LOGIC_VECTOR(1 downto 0));
end Extended_control;
architecture Behavioral of Extended_control is
	type stateType is (idle, InstructionFetch, InstructionDelay, Decode, add, sub, andS, notS, orS, sraS, sllS, srlS, rolS, 
	rorS, li, lui, addi, andi, ori, b, beq, beqDelay, bne, bneDelay, sw, swDelay, sb, sbDelay, lw, lwDelay, lb, lbDelay,
	cmov, cmovWrite,
	mmx_add7_0, mmx_add15_8, mmx_add23_16, mmx_add31_24,
	bermFetch, bermSub, brs,
	bnemFetchA, bnemFetchB, bnemSub, bi,
	bpmCreateBaseAddr, bpmFetch0, bpmAdd4, bpmFetch4, bpmAdd8, bpmFetch8, bpmAdd12,  bpmFetch12,
	bumCreateBaseAddr, bumWrite0, bumAdd4, bumWrite4, bumAdd8, bumWrite8, bumAdd12, bumWrite12);
	signal currentS, nextS: stateType;
begin
	fsm_synch: process (Clk, Reset)
	begin
		if (Reset='1')  	   				then 	currentS <= idle;  
		elsif (rising_edge(Clk))  	then	currentS <= nextS; 
		end if;
	end process fsm_synch;

	fsm_comb: process(currentS, Instr, ALU_Zero)
	begin
		case currentS is
			when idle => nextS<=Decode;
			when InstructionFetch => 	nextS<=InstructionDelay;
			when InstructionDelay => nextS<=Decode;
			when Decode => if Instr = "00000000000000000000000000000000" then nextS<=InstructionFetch;
												elsif Instr (31 downto 26) = "100000" then
													if Instr(5 downto 0) = "110000" then nextS<=add;
													elsif Instr(5 downto 0) = "110001" then nextS<=sub;
													elsif Instr(5 downto 0) = "110010" then nextS<=andS;
													elsif Instr(5 downto 0) = "110100" then nextS<=notS;
													elsif Instr(5 downto 0) = "110011" then nextS<=orS;
													elsif Instr(5 downto 0) = "111000" then nextS<=sraS;
													elsif Instr(5 downto 0) = "111001" then nextS<=sllS;
													elsif Instr(5 downto 0) = "111010" then nextS<=srlS;
													elsif Instr(5 downto 0) = "111100" then nextS<=rolS;
													elsif Instr(5 downto 0) = "111101" then nextS<=rorS;
													end if;
												elsif Instr (31 downto 26) = "111000" then nextS<=li;
												elsif Instr (31 downto 26) = "111001" then nextS<=lui;
												elsif Instr (31 downto 26) = "110000" then nextS<=addi;
												elsif Instr (31 downto 26) = "110010" then nextS<=andi;
												elsif Instr (31 downto 26) = "110011" then nextS<=ori;
												elsif Instr (31 downto 26) = "111111" then nextS<=b;
												elsif Instr (31 downto 26) = "000000" then nextS<=beq;
												elsif Instr (31 downto 26) = "000001" then nextS<=bne;
												elsif Instr (31 downto 26) = "000011" then nextS<=lb;
												elsif Instr (31 downto 26) = "000111" then nextS<=sb;
												elsif Instr (31 downto 26) = "001111" then nextS<=lw;
												elsif Instr (31 downto 26) = "011111" then nextS<=sw;
												elsif Instr (31 downto 26) = "100001" then nextS<=cmov;
												elsif Instr (31 downto 26) = "100011" then nextS<=mmx_add7_0;
												elsif Instr (31 downto 26) = "100111" then nextS<=bermFetch;
												elsif Instr (31 downto 26) = "101111" then nextS<=bnemFetchA;
												elsif Instr (31 downto 26) = "111100" then nextS<=bpmCreateBaseAddr;
												elsif Instr (31 downto 26) = "111110" then nextS<=bumCreateBaseAddr;
												else nextS<=idle;
												end if;
			when b=> nextS<=InstructionDelay;
			when beq => nextS<=beqDelay;
			when beqDelay=> 	if ALU_Zero='1' then nextS<=b;
													else nextS<=InstructionFetch;
													end if;
			when bne => nextS<=bneDelay;
			when bneDelay=> 	if ALU_Zero='0' then nextS<=b;
													else nextS<=InstructionFetch;
													end if;
			when sw=> nextS<=swDelay;
			when sb=> nextS<=sbDelay;
			when lw=> nextS<=lwDelay;
			when lb=> nextS<=lbDelay;
			when cmov => if ALU_Zero='1' then
														nextS<=InstructionFetch;
													else
														nextS<=cmovWrite;
													end if;
			when mmx_add7_0=> nextS<=mmx_add15_8;
			when mmx_add15_8=> nextS<=mmx_add23_16;
			when mmx_add23_16=> nextS<=mmx_add31_24;
			when bermFetch=> nextS<=bermSub;
			when bermSub=> if ALU_Zero='1' then
																nextS<=brs;
															else
																nextS<=InstructionFetch;
															end if;
			when brs=> nextS<=InstructionDelay;
			when bnemFetchA=> nextS<=bnemFetchB;
			when bnemFetchB=> nextS<=bnemSub;
			when bnemSub=> if ALU_Zero='0' then
																	nextS<=bi;
																else
																	nextS<=InstructionFetch;
																end if;
			when bi=> nextS<=InstructionDelay;
			when bpmCreateBaseAddr=> nextS<=bpmFetch0;
			when bpmFetch0=>nextS<=bpmAdd4;
			when bpmAdd4=>nextS<=bpmFetch4;
			when bpmFetch4=>nextS<=bpmAdd8;
			when bpmAdd8=>nextS<=bpmFetch8;
			when bpmFetch8=>nextS<=bpmAdd12;
			when bpmAdd12=>nextS<=bpmFetch12;
			when bumCreateBaseAddr=> nextS<=bumWrite0;
			when bumWrite0=> nextS<=bumAdd4;
			when bumAdd4=> nextS<=bumWrite4;
			when bumWrite4=> nextS<=bumAdd8;
			when bumAdd8=> nextS<=bumWrite8;
			when bumWrite8=> nextS<=bumAdd12;
			when bumAdd12=> nextS<=bumWrite12;
			when others => nextS<=InstructionFetch;
		end case;
	end process fsm_comb;
	
	with currentS select
		PC_sel <= 	"01" when b,
										"10" when brs,
										"01" when bi,
										"00" when others;
	with currentS select
		PC_LdEn <= 	'1' when InstructionFetch,
											'1' when b,
											'1' when brs,
											'1' when bi,
											'0' when others;
	with currentS select
		RF_WrEn <= 	'1' when add,
											'1' when sub,
											'1' when andS,
											'1' when notS,
											'1' when orS,
											'1' when sraS,
											'1' when sllS,
											'1' when srlS,
											'1' when rolS,
											'1' when rorS,
											'1' when li,
											'1' when lui,
											'1' when addi,
											'1' when andi,
											'1' when ori,
											'1' when lwDelay,
											'1' when lbDelay,
											'1' when cmovWrite,
											'1' when mmx_add31_24,
											'1' when bpmFetch12,
											'0' when others;
	with currentS select
		RF_WrData_sel <= 	"000" when InstructionFetch,
															"010" when li,
															"010" when lui,
															"001" when lw,
															"001" when lwDelay,
															"001" when lb,
															"001" when lbDelay,
															"011" when cmovWrite,
															"100" when mmx_add7_0,
															"100" when mmx_add15_8,
															"100" when mmx_add23_16,
															"100" when mmx_add31_24,
															"101" when bpmFetch12,
															"000" when others;
	with currentS select
		RF_B_sel <= 	'1' when beq,
											'1' when bne,
											'1' when sw,
											'1' when swDelay,
											'1' when sb,
											'1' when sbDelay,
											'1' when lw,
											'1' when lwDelay,
											'1' when lb,
											'1' when lbDelay,
											'1' when bermFetch,
											'1' when bermSub,
											'1' when brs,
											'1' when bnemFetchA,
											'1' when bnemFetchB,
											'1' when bnemSub,
											'1' when bi,
											'1' when bumWrite0,
											'1' when bumAdd4,
											'1' when bumWrite4,
											'1' when bumAdd8,
											'1' when bumWrite8,
											'1' when bumAdd12,
											'1' when bumWrite12,
											'0' when others;
	with currentS select
		RF_AB_we<= '1' when Decode,
											'1' when beq,
											'1' when bne,
											'1' when sw,
											'1' when sb,
											'1' when lw,
											'1' when lb,
											'1' when bermFetch,
											'1' when bnemFetchA,
											'1' when bumCreateBaseAddr,
											'0' when others;
	with currentS select
		ALU_Ain_sel <=	"001" when cmov,
													"001" when cmovWrite,
													"010" when mmx_add7_0,
													"011" when mmx_add15_8,
													"100" when mmx_add23_16,
													"101" when mmx_add31_24,
													"110" when bermSub,
													"110" when bnemSub,
													"111" when bpmFetch0,
													"111" when bpmAdd4,
													"111" when bpmFetch4,
													"111" when bpmAdd8,
													"111" when bpmFetch8,
													"111" when bpmAdd12,
													"111" when bpmFetch12,
													"111" when bumWrite0,
													"111" when bumAdd4,
													"111" when bumWrite4,
													"111" when bumAdd8,
													"111" when bumWrite8,
													"111" when bumAdd12,
													"111" when bumWrite12,
													"000" when others;
	with currentS select
		ALU_Bin_sel <=	"001" when addi,
													"001" when andi,
													"001" when ori,
													"001" when sw,
													"001" when swDelay,
													"001" when sb,
													"001" when sbDelay,
													"001" when lw,
													"001" when lwDelay,
													"001" when lb,
													"001"when lbDelay,
													"010" when mmx_add7_0,
													"011" when mmx_add15_8,
													"100" when mmx_add23_16,
													"101" when mmx_add31_24,
													"110" when bnemSub,
													"001" when bpmCreateBaseAddr,
													"111" when bpmFetch0,
													"111" when bpmAdd4,
													"111" when bpmFetch4,
													"111" when bpmAdd8,
													"111" when bpmFetch8,
													"111" when bpmAdd12,
													"111" when bpmFetch12,
													"001" when bumCreateBaseAddr,
													"111" when bumWrite0,
													"111" when bumAdd4,
													"111" when bumWrite4,
													"111" when bumAdd8,
													"111" when bumWrite8,
													"111" when bumAdd12,
													"111" when bumWrite12,
													"000" when others;
	with currentS select
		ALU_func <=	Instr (3 downto 0) when add,
											Instr (3 downto 0) when sub,
											Instr (3 downto 0) when andS,
											Instr (3 downto 0) when notS,
											Instr (3 downto 0) when orS,
											Instr (3 downto 0) when sraS,
											Instr (3 downto 0) when sllS,
											Instr (3 downto 0) when srlS,
											Instr (3 downto 0) when rolS,
											Instr (3 downto 0) when rorS,
											"0000" when addi,
											"0010" when andi,
											"0011" when ori,
											"0001" when beqDelay,
											"0001" when bneDelay,
											"0000" when sw,
											"0000" when sb,
											"0000" when lw,
											"0000" when lb,
											"0001" when bermSub,
											"0001" when bnemSub,
											"0000" when others;
	with currentS select
		MEM_WrEn <= 	'1' when swDelay,
													'1' when sbDelay,
													'1' when bumWrite0,
													'1' when bumWrite4,
													'1' when bumWrite8,
													'1' when bumWrite12,
													'0' when others;
	with currentS select
		MEM_Control <= 	"01" when sb,
														"01" when sbDelay,
														"01" when lb,
														"01" when lbDelay,
														"10" when bumCreateBaseAddr,
														"10" when bumWrite0,
														"10" when bumAdd4,
														"10" when bumWrite4,
														"10" when bumAdd8,
														"10" when bumWrite8,
														"10" when bumAdd12,
														"10" when bumWrite12,
														"00" when others;
	with currentS select
		MEM_Addr_sel <= 	"001" when bermFetch,
															"001"  when bermSub,
															"010" when bnemFetchA,
															"011"when bnemFetchB,
															"011"when bnemSub,
															"100" when bpmCreateBaseAddr,
															"100" when bpmFetch0,
															"100" when bpmAdd4,
															"100" when bpmFetch4,
															"100" when bpmAdd8,
															"100" when bpmFetch8,
															"100" when bpmAdd12,
															"100" when bpmFetch12,
															"100" when bumCreateBaseAddr,
															"100" when bumWrite0,
															"100" when bumAdd4,
															"100" when bumWrite4,
															"100" when bumAdd8,
															"100" when bumWrite8,
															"100" when bumAdd12,
															"100" when bumWrite12,
															"000"  when others;
	with currentS select
		MEM_Reg_we<=	'1' when bnemFetchB,
														'0' when others;
	with currentS select
		mmx_we<= "001" when mmx_add7_0,
										"010" when mmx_add15_8,
										"100" when mmx_add23_16,
										"000" when others;
	with currentS select
		bpm_we<= "001" when bpmAdd4,
										"010" when bpmAdd8,
										"100" when bpmAdd12,
										"000" when others;
	with currentS select
		baseAddr_we<=	'1'  when bpmCreateBaseAddr,
														'1' when bpmFetch0,
														'1' when bpmFetch4,
														'1' when bpmFetch8,
														'1' when bpmFetch12,
														'1' when bumCreateBaseAddr,
														'1' when bumAdd4,
														'1' when bumAdd8,
														'1' when bumAdd12,
														'0' when others;
	with currentS select
		bum_sel<= "01" when bumWrite4,
										"10" when bumWrite8,
										"11" when bumWrite12,
										"00" when others;
end Behavioral;