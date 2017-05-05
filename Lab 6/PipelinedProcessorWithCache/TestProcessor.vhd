LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
ENTITY TestProcessor IS
END TestProcessor;
ARCHITECTURE behavior OF TestProcessor IS 
    COMPONENT processor
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         miss : OUT  std_logic
        );
    END COMPONENT;
   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
 	--Outputs
   signal miss : std_logic;
   constant clk_period : time := 10 ns;
BEGIN
   uut: processor PORT MAP (
          reset => reset,
          clk => clk,
          miss => miss
        );
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   stim_proc: process
   begin
		reset<='1';
      wait for 10 ns;
		reset<='0';
      wait;
   end process;
END;
