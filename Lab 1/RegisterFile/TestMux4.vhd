LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY TestMux4 IS
END TestMux4; 
ARCHITECTURE behavior OF TestMux4 IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Mux4
    PORT(
         input : IN  std_logic_vector(3 downto 0);
         output : OUT  std_logic;
         control : IN  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal input : std_logic_vector(3 downto 0) := (others => '0');
   signal control : std_logic_vector(1 downto 0) := (others => '0');
 	--Outputs
   signal output : std_logic;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux4 PORT MAP (
          input => input,
          output => output,
          control => control
        );

   -- Stimulus process
   stim_proc: process
   begin
		input<="1110";
		control<="00";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
      input<="1101";
		control<="01";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
		input<="1011";
		control<="10";
      wait for 100 ns;
		input<=not input;
      wait for 100 ns;
		
      input<="0111";
		control<="11";
      wait for 100 ns;
		input<=not input;
		wait;
   end process;
END;