LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY TestIFSTAGE IS
END TestIFSTAGE;
ARCHITECTURE behavior OF TestIFSTAGE IS 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);
   -- Clock period definitions
   constant Clk_period : time := 1 ns;
 
BEGIN
 	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          PC_Immed => PC_Immed,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
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
----------------------------------------------RESET----------------------------------------------------------------
		PC_Immed<=std_logic_vector(to_unsigned(8,32));
		PC_Sel<='0';
		PC_LdEn<='0';
		Reset<='1';
      wait for 100 ns;
		reset<='0';
--------------------------------------------Testing All Instructions------------------------------------------
		for i in 0 to 34 loop
			PC_LdEn<='1';
			wait for 10 ns;
			PC_LdEn<='0';
			wait for 10 ns;
		end loop;
----------------------------------------------RESET----------------------------------------------------------------
		Reset<='1';
      wait for 100 ns;
		reset<='0';
-----------------------------------------Test Immediate--------------------------------------------------------
		PC_Sel<='1';
		PC_LdEn<='1';
      wait for 100 ns;
		wait;
   end process;
END;