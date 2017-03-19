LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY TestMux16 IS
END TestMux16; 
ARCHITECTURE behavior OF TestMux16 IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Mux16
    PORT(
         input : IN  std_logic_vector(15 downto 0);
         output : OUT  std_logic;
         control : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal input : std_logic_vector(15 downto 0) := (others => '0');
   signal control : std_logic_vector(3 downto 0) := (others => '0');
 	--Outputs
   signal output : std_logic;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux16 PORT MAP (
          input => input,
          output => output,
          control => control
        );

   -- Stimulus process
   stim_proc: process
   begin		
		input<="1111111111111110";
		control<="0000";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111111111111101";
		control<="0001";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111111111111011";
		control<="0010";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111111111110111";
		control<="0011";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111111111101111";
		control<="0100";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111111111011111";
		control<="0101";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111111110111111";
		control<="0110";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111111101111111";
		control<="0111";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		
		input<="1111111011111111";
		control<="1000";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111110111111111";
		control<="1001";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111101111111111";
		control<="1010";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1111011111111111";
		control<="1011";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1110111111111111";
		control<="1100";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1101111111111111";
		control<="1101";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="1011111111111111";
		control<="1110";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
		
		input<="0111111111111111";
		control<="1111";
      wait for 10 ns;
		input<=not input;
      wait for 10 ns;
      wait;
   end process;
END;