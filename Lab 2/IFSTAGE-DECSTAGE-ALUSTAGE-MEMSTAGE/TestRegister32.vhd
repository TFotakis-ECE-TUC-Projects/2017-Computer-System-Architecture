LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY TestRegister32 IS
END TestRegister32;
 
ARCHITECTURE behavior OF TestRegister32 IS 
    COMPONENT Register32
    PORT(
         data : IN  std_logic_vector(31 downto 0);
         dout : OUT  std_logic_vector(31 downto 0);
         we : IN  std_logic;
         reset : IN  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
   --Inputs
   signal data : std_logic_vector(31 downto 0) := (others => '0');
   signal we : std_logic := '0';
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Register32 PORT MAP (
          data => data,
          dout => dout,
          we => we,
          reset => reset,
          clk => clk
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
		data<=std_logic_vector(to_unsigned(12,32));
		we<='0';
		reset<='1';
      wait for 100 ns;
		reset<='0';
		wait for 100 ns;
		
		we<='1';
		wait for 100 ns;
		data<=std_logic_vector(to_unsigned(5,32));
		wait for 100 ns;
		we<='0';
      wait;
   end process;

END;
