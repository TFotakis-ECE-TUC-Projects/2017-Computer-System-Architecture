LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; 
ENTITY TestDECSTAGE IS
END TestDECSTAGE;
ARCHITECTURE behavior OF TestDECSTAGE IS  
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);
   -- Clock period definitions
   constant Clk_period : time := 10 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Reset => Reset,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
        );
   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
   -- Stimulus process
   stim_proc: process
   begin		
		Reset<='1';
		Instr<=std_logic_vector(to_signed(0,32));
		RF_WrEn<='0';
		ALU_out<=std_logic_vector(to_signed(125,32));
		MEM_out<=std_logic_vector(to_signed(320,32));
		RF_WrData_sel<='0';
		RF_B_sel<='0';
		wait for 200 ns;
		------------------After reset------------------
		---------------Write first register------------
		Reset<='0';
		Instr(20 downto 16)<="00001";
		Instr(15 downto 11)<="00010";
		RF_WrEn<='1';
		-----------------SignExt Immed-----------------
		Instr(31 downto 26)<="000000";
		Instr(15 downto 0)<=std_logic_vector(to_signed(1235,16));
      wait for 200 ns;
		
		
      -----------Read first register RF(A)-----------	
		---------------Write second register-----------
		Instr(25 downto 21)<="00001";
		Instr(20 downto 16)<="00010";
		RF_B_sel<='1';
		RF_WrData_sel<='0';
		RF_WrEn<='1';
		-----------------SignExt<<2-----------------------
		Instr(31 downto 26)<="111111";
      wait for 200 ns;	
		
		
		-----------Read first register RF(A)-----------	
      -----------Read second register RF(B)----------	
      ----------------Not Write register-------------		
		RF_B_sel<='1';
		RF_WrData_sel<='0';
		RF_WrEn<='0';
		-------------------Imm<<16ZeroFill-------------
		Instr(31 downto 26)<="111001";
      wait for 200 ns;
		
		-------------------ZeroFill-----------------------------
		Instr(31 downto 26)<="110010";
      wait;
   end process;
END;