LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY TestMux8 IS
END TestMux8; 
ARCHITECTURE behavior OF TestMux8 IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Mux8
    PORT(
         input : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic;
         control : IN  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal input : std_logic_vector(7 downto 0) := (others => '0');
   signal control : std_logic_vector(2 downto 0) := (others => '0');
 	--Outputs
   signal output : std_logic;
BEGIN 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux8 PORT MAP (
          input => input,
          output => output,
          control => control
        );

   -- Stimulus process
   stim_proc: process
   begin		
		input<="11111110";
		control<="000";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
		input<="11111101";
		control<="001";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
		input<="11111011";
		control<="010";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
		input<="11110111";
		control<="011";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
		input<="11101111";
		control<="100";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
		input<="11011111";
		control<="101";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
		input<="10111111";
		control<="110";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
		input<="01111111";
		control<="111";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
      wait;
   end process;
END;