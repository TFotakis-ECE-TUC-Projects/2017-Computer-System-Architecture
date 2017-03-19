LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
ENTITY TestALUSTAGE IS
END TestALUSTAGE;
ARCHITECTURE behavior OF TestALUSTAGE IS 
    COMPONENT ALUSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: ALUSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out
        );
   -- Stimulus process
   stim_proc: process
   begin
				--------------Addition----------------------
		RF_A<="00000000000000000000000000000100";
		RF_B<="00000000000000000000000000001000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='1';
		ALU_func<="0000";
      wait for 200 ns;
		RF_A<="00000000000000000000000000000100";
		RF_B<="00000000000000000000000000001000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
      wait for 200 ns;	
		--------------Subctration-------------------
		RF_A<="00000000000000000000000000000100";
		RF_B<="00000000000000000000000000001000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='1';
		ALU_func<="0001";
      wait for 200 ns;
		RF_A<="00000000000000000000000000000100";
		RF_B<="00000000000000000000000000001000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0001";
      wait for 200 ns;
      ------Complimentary Number--------	
		RF_A<="00000111000000011100000000000100";
		RF_B<="00000000000000000000000000001000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='1';
		ALU_func<="0100";
      wait for 200 ns;
		RF_A<="00000111000000011100000000000100";
		RF_B<="00000000000000000000000000001000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0100";
      wait for 200 ns;
		----------Left cycle rotation--------
		RF_A<="00000111000000011100000000000100";
		RF_B<="00000000000000000000000000001000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='1';
		ALU_func<="1100";
      wait for 200 ns;
      RF_A<="00000111000000011100000000000100";
		RF_B<="00000000000000000000000000001000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="1100";
      wait for 200 ns;
      wait;
   end process;
END;