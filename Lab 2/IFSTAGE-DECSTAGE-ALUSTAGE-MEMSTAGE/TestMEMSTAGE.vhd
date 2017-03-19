LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
ENTITY TestMEMSTAGE IS
END TestMEMSTAGE;
ARCHITECTURE behavior OF TestMEMSTAGE IS 
    COMPONENT MEMSTAGE
    PORT(
         clk : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_Datain : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal clk : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_Datain : std_logic_vector(31 downto 0) := (others => '0');
 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   -- Clock period definitions
   constant clk_period : time := 10 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          clk => clk,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_Datain => MEM_Datain,
          MEM_DataOut => MEM_DataOut
        );
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   -- Stimulus process
   stim_proc: process
   begin
		Mem_WrEn<='1';
		ALU_MEM_Addr<="00000000000000000000000000100001";
		MEM_DataIn<="01000000000000000000000100000010";
      wait for 100 ns;
      Mem_WrEn<='1';
		ALU_MEM_Addr<="00000000000000000000000000100001";
		MEM_DataIn<="01000000001111111000000100000010";
      wait for 100 ns;
		Mem_WrEn<='0';
		ALU_MEM_Addr<="00000000000000000000000000100001";
		MEM_DataIn<="01111111111111111000000100000010";
      wait for 100 ns;
      wait;
   end process;
END;
