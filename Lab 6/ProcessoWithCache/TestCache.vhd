LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
ENTITY TestCache IS
END TestCache;
ARCHITECTURE behavior OF TestCache IS 
    COMPONENT Cache
    PORT(
         clk : IN  std_logic;
         addr : IN  std_logic_vector(6 downto 0);
         dout : OUT  std_logic_vector(31 downto 0);
         valid : OUT  std_logic;
         tag : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal clk : std_logic := '0';
   signal addr : std_logic_vector(6 downto 0) := (others => '0');
 	--Outputs
   signal dout : std_logic_vector(31 downto 0);
   signal valid : std_logic;
   signal tag : std_logic_vector(2 downto 0);
   constant clk_period : time := 10 ns;
BEGIN
   uut: Cache PORT MAP (
          clk => clk,
          addr => addr,
          dout => dout,
          valid => valid,
          tag => tag
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
		addr<="0000000";
      wait for 100 ns;
		addr<="0000100";
		wait for 100 ns;
		addr<="0000101";
		wait for 100 ns;
		addr<="0001010";
      wait;
   end process;
END;
