LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY TestCONTROL IS
END TestCONTROL;
ARCHITECTURE behavior OF TestCONTROL IS 
    COMPONENT CONTROL
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         PC_sel : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic_vector(1 downto 0);
         RF_B_sel : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         UnknownOpCode : OUT  std_logic
        );
    END COMPONENT;
   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
 	--Outputs
   signal PC_sel : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic_vector(1 downto 0);
   signal RF_B_sel : std_logic;
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal UnknownOpCode : std_logic;
   constant Clk_period : time := 10 ns;
BEGIN
   uut: CONTROL PORT MAP (
          Instr => Instr,
          Reset => Reset,
          Clk => Clk,
          PC_sel => PC_sel,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          UnknownOpCode => UnknownOpCode
        );
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
   stim_proc: process
   begin
		Instr<=std_logic_vector(to_unsigned(0,32));
		reset<='1';
      wait for 100 ns;	
		reset<='0';
		Instr(31 downto 26)<="100000";
		wait for 100 ns;
		Instr(31 downto 26)<="111111";
      wait;
   end process;
END;
