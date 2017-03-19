LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY TestMux2x32to32 IS
END TestMux2x32to32;
ARCHITECTURE behavior OF TestMux2x32to32 IS 
    COMPONENT Mux2x32to32
    PORT(
         inA : IN  std_logic_vector(31 downto 0);
         inB : IN  std_logic_vector(31 downto 0);
         output : OUT  std_logic_vector(31 downto 0);
         control : IN  std_logic
        );
    END COMPONENT;
   --Inputs
   signal inA : std_logic_vector(31 downto 0) := (others => '0');
   signal inB : std_logic_vector(31 downto 0) := (others => '0');
   signal control : std_logic := '0';
 	--Outputs
   signal output : std_logic_vector(31 downto 0);
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux2x32to32 PORT MAP (
          inA => inA,
          inB => inB,
          output => output,
          control => control
        );
   -- Stimulus process
   stim_proc: process
   begin
		inA<=std_logic_vector(to_unsigned(131,32));
		inB<=std_logic_vector(to_unsigned(21,32));
		control<='0';
      wait for 100 ns;	
		control<='1';
      wait;
   end process;
END;
