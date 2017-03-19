LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
ENTITY TestRegisterFile IS
END TestRegisterFile;
ARCHITECTURE behavior OF TestRegisterFile IS 
    COMPONENT RegisterFile
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         reset : IN  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);
   -- Clock period definitions
   constant clk_period : time := 1 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
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
-----------------------------Reset Circuit------------------------------------
		Ard1<="00000";
		Ard2<="00000";
		Awr<="00000";
		Din<=std_logic_vector(to_unsigned(0,32));
		WrEn<='0';
		reset<='1';
      wait for 100 ns;
		reset<='0';
-----------------------------Load Register0---------------------------------
		Awr<="00000";
		Din<=std_logic_vector(to_unsigned(35,32));
		WrEn<='1';
      wait for 50 ns;
		WrEn<='0';
		wait for 50 ns;
-----------------------------Load Register1---------------------------------
		Awr<="00001";
		WrEn<='1';
      wait for 50 ns;
		WrEn<='0';
		wait for 50 ns;
-----------------------------Read Register1---------------------------------
		Ard1<="00001";
		Ard1<="00001";
		wait for 100 ns;
-----------------------------Load & Read Register2---------------------------------
		Ard2<="00010";
		Awr<="00010";
		Din<=std_logic_vector(to_unsigned(65,32));
		WrEn<='1';
      wait for 50 ns;
		WrEn<='0';
		wait for 50 ns;
      wait;
   end process;
END;