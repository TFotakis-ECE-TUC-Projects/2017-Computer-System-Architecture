library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity CONTROL is
    Port (Instr 						: in  	STD_LOGIC_VECTOR (31 downto 0);
				ALU_Zero				: in		STD_LOGIC;
				Reset 					: in  	STD_LOGIC;
				Clk 						: in  	STD_LOGIC;
				PC_sel 					: out  STD_LOGIC;
				PC_LdEn 				: out  STD_LOGIC;
				RF_WrEn 				: out  STD_LOGIC;
				RF_WrData_sel 	: out  STD_LOGIC_VECTOR (1 downto 0);
				RF_B_sel 				: out  STD_LOGIC;
				RF_AB_we			: out 	STD_LOGIC;
				ALU_Bin_sel 		: out  STD_LOGIC;
				ALU_func 			: out 	STD_LOGIC_VECTOR (3 downto 0);
				MEM_WrEn 		: out  STD_LOGIC;
				MEM_Control 		: out 	STD_LOGIC);
end CONTROL;
architecture Behavioral of CONTROL is
	type stateType is (idle, InstructionFetch, InstructionDelay, Decode, add, sub, andS, notS, orS, sraS, sllS, srlS, rolS, rorS, li, lui, addi, andi, ori, b, beq, beqDelay, bne, bneDelay, sw, swDelay, sb, sbDelay, lw, lwDelay, lb, lbDelay);
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
			when others => nextS<=InstructionFetch;
		end case;
	end process fsm_comb;
	
	with currentS select
		PC_sel <= 	'1' when b,
								'0' when others;
	with currentS select
		PC_LdEn <= 	'1' when InstructionFetch,
									'1' when b,
									'0' when others;
	with currentS select
		RF_WrEn <= 	'0' when Idle,
									'0' when InstructionFetch,
									'0' when InstructionDelay,
									'0' when Decode,
									'0' when b,
									'0' when beq,
									'0' when beqDelay,
									'0' when bne,
									'0' when bneDelay,
									'0' when sw,
									'0' when swDelay,
									'0' when sb,
									'0' when sbDelay,
									'0' when lw,
									'1' when lwDelay,
									'0' when lb,
									'1' when lbDelay,
									'1' when others;
	with currentS select
		RF_WrData_sel <= 	"00" when InstructionFetch,
												"10" when li,
												"10" when lui,
												"01" when lw,
												"01" when lwDelay,
												"01" when lb,
												"01" when lbDelay,
												"00" when others;
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
									'0' when others;
	with currentS select
		RF_AB_we<= '1' when Decode,
									'1' when beq,
									'1' when bne,
									'1' when sw,
									'1' when sb,
									'1' when lw,
									'1' when lb,
									'0' when others;
	with currentS select
		ALU_Bin_sel <=	'0' when InstructionFetch,
											'1' when addi,
											'1' when andi,
											'1' when ori,
											'1' when sw,
											'1' when swDelay,
											'1' when sb,
											'1' when sbDelay,
											'1' when lw,
											'1' when lwDelay,
											'1' when lb,
											'1' when lbDelay,
											'0' when others;
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
									"0000" when others;
	with currentS select
		MEM_WrEn <= 	'1' when swDelay,
											'1' when sbDelay,
											'0' when others;
	with currentS select
		MEM_Control <= 	'1' when sb,
											'1' when sbDelay,
											'1' when lb,
											'1' when lbDelay,
											'0' when others;
end Behavioral;