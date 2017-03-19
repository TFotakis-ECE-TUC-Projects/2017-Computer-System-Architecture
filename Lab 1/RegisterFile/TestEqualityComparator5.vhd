LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY TestEqualityComparator5 IS
END TestEqualityComparator5;
ARCHITECTURE behavior OF TestEqualityComparator5 IS 
    COMPONENT EqualityComparator5
    PORT(
         inA : IN  std_logic_vector(4 downto 0);
         inB : IN  std_logic_vector(4 downto 0);
         output : OUT  std_logic
        );
    END COMPONENT;
   --Inputs
   signal inA : std_logic_vector(4 downto 0) := (others => '0');
   signal inB : std_logic_vector(4 downto 0) := (others => '0');
 	--Outputs
   signal output : std_logic;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: EqualityComparator5 PORT MAP (
          inA => inA,
          inB => inB,
          output => output
        );
   -- Stimulus process
   stim_proc: process
   begin
		inA<="00100";
		inB<="10000";
      wait for 100 ns;
		inB<="00100";
      wait;
   end process;
END;
