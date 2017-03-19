LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY TestDecoder5to32 IS
END TestDecoder5to32;
ARCHITECTURE behavior OF TestDecoder5to32 IS 
    COMPONENT Decoder5to32
    PORT(
         input : IN  std_logic_vector(4 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal input : std_logic_vector(4 downto 0) := (others => '0');
 	--Outputs
   signal output : std_logic_vector(31 downto 0);
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder5to32 PORT MAP (
          input => input,
          output => output
        );
   -- Stimulus process
   stim_proc: process
   begin
		input<=std_logic_vector(to_unsigned(0,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(1,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(2,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(3,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(4,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(5,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(6,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(7,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(8,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(9,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(10,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(11,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(12,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(13,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(14,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(15,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(16,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(17,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(18,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(19,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(20,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(21,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(22,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(23,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(24,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(25,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(26,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(27,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(28,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(29,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(30,5));
      wait for 10 ns;
		input<=std_logic_vector(to_unsigned(31,5));
      wait for 10 ns;
      wait;
   end process;
END;
