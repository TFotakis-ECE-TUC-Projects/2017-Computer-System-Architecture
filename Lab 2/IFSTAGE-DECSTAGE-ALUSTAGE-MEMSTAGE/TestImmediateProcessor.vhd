LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY TestImmediateProcessor IS
END TestImmediateProcessor;
ARCHITECTURE behavior OF TestImmediateProcessor IS 
    COMPONENT ImmediateProcessor
    PORT(
         Data : IN  std_logic_vector(15 downto 0);
         Dout : OUT  std_logic_vector(31 downto 0);
         Instr : IN  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal Data : std_logic_vector(15 downto 0) := (others => '0');
   signal Instr : std_logic_vector(5 downto 0) := (others => '0');
 	--Outputs
   signal Dout : std_logic_vector(31 downto 0);
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: ImmediateProcessor PORT MAP (
          Data => Data,
          Dout => Dout,
          Instr => Instr
        );
   -- Stimulus process
   stim_proc: process
   begin
--	"000000" | "000001" | "000011" | "000111" | "001111" | "011111" | "110000" | "111000" | "111111" | "111001" | "110010" | "110011"
		Data<=std_logic_vector(to_signed(125,16));
		wait for 100 ns;
		Instr<="000000";
      wait for 100 ns;
		Instr<="000001";
      wait for 100 ns;
		Instr<="000011";
      wait for 100 ns;
		Instr<="000111";
      wait for 100 ns;
		Instr<="001111";
      wait for 100 ns;
		Instr<="011111";
      wait for 100 ns;
		Instr<="110000";
      wait for 100 ns;
		Instr<="111000";
      wait for 100 ns;
		Instr<="111111";
      wait for 100 ns;
		Instr<="111001";
      wait for 100 ns;
		Instr<="110010";
      wait for 100 ns;
		Instr<="110011";
      wait for 100 ns;	
----------------------------------------Other------------------
		Instr<="000010";
      wait for 100 ns;
		
      wait;
   end process;
END;