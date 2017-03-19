LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
ENTITY TestProcessor IS
END TestProcessor;
ARCHITECTURE behavior OF TestProcessor IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT processor
    PORT(
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0);
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
 	--Outputs
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);
   signal Instr : std_logic_vector(31 downto 0);
   -- Clock period definitions
   constant Clk_period : time := 10 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: processor PORT MAP (
          Reset => Reset,
          Clk => Clk,
          RF_A => RF_A,
          RF_B => RF_B,
          Instr => Instr
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
      wait for 20 ns;
		Reset<='0';
      wait;
   end process;
END;