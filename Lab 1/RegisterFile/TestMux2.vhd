LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
ENTITY TestMux2 IS
END TestMux2;
ARCHITECTURE behavior OF TestMux2 IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Mux2
    PORT(
         input : IN  std_logic_vector(1 downto 0);
         output : OUT  std_logic;
         control : IN  std_logic
        );
    END COMPONENT;
   --Inputs
   signal input : std_logic_vector(1 downto 0) := (others => '0');
   signal control : std_logic := '0';
 	--Outputs
   signal output : std_logic;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux2 PORT MAP (
          input => input,
          output => output,
          control => control
        );
		  
   stim_proc: process
   begin		
      input<="00";
		control<='0';
      wait for 100 ns;
		input<="01";
		control<='0';
      wait for 100 ns;
		input<="10";
		control<='0';
      wait for 100 ns;
		input<="11";
		control<='0';
      wait for 100 ns;
		
		input<="00";
		control<='1';
      wait for 100 ns;
		input<="01";
		control<='1';
      wait for 100 ns;
		input<="10";
		control<='1';
      wait for 100 ns;
		input<="11";
		control<='1';
      wait for 100 ns;
      wait;
   end process;
END;