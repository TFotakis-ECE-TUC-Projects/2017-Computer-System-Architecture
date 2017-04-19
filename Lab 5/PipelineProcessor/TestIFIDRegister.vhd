LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY TestIFIDRegister IS
END TestIFIDRegister;
ARCHITECTURE behavior OF TestIFIDRegister IS 
    COMPONENT IFID_Register
    PORT(
         input : IN  std_logic_vector(31 downto 0);
         output : OUT  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
   --Inputs
   signal input : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
 	--Outputs
   signal output : std_logic_vector(31 downto 0);
   constant clk_period : time := 10 ns;
BEGIN
   uut: IFID_Register PORT MAP (
          input => input,
          output => output,
          clk => clk,
          reset => reset
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
		input<=std_logic_vector(to_unsigned(4287,32));
      wait for 100 ns;	
		reset<='1';
      wait;
   end process;
END;
