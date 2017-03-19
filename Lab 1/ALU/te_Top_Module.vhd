--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:08:13 02/09/2017
-- Design Name:   
-- Module Name:   E:/Workspace Xilinx/lab1/te_Top_Module.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Top_module
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY te_Top_Module IS
END te_Top_Module;
 
ARCHITECTURE behavior OF te_Top_Module IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Top_module
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Top_module PORT MAP (
          A => A,
          B => B,
          Op => Op,
          output => output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
	--	wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		-----Addition--------
		-----Addition examples------
		A<="00000000000000000000000000000100";
		B<="00000000000000000000000000000100";
		Op<="0000";
      wait for 100 ns;
		A<="00000000000000000000000000001000";
		B<="00000000000000000000000000010100";
		Op<="0000";
      wait for 100 ns;
		--Addition examples to show overflow--
		A<="01000000000000000000000000000100";
		B<="01000000000000000000000000000100";
		Op<="0000";
      wait for 100 ns;
		A<="10000000000000000000000000000000";
		B<="10000000000000000000000000000000";
		Op<="0000";
      wait for 100 ns;
      ------Subtraction--------		
	   A<="00000000000000000000000000000100";
		B<="00000000000000000000000000000010";
		Op<="0001";
      wait for 100 ns;
		A<="00000000000000000000000000001000";
		B<="00000000000000000000000000010100";
		Op<="0001";
      wait for 100 ns;
		A<="00000000000000000000000000001000";
		B<="00000000000000000000000000010000";
		Op<="0001";
      wait for 100 ns;	
		A<="00000000000000000000000000010000";
		B<="00000000000000000000000000000100";
		Op<="0001";
      wait for 100 ns;
		--Subtraction examples to show overflow--
		A<="01000000000000000000000000000100";
		B<="10111111111111111111111111111111";
		Op<="0001";
      wait for 100 ns;
		A<="10000000000000000000000000000000";
		B<="01111111111111111111111111111111";
		Op<="0001";
      wait for 100 ns;
		------Logic And--------	
		A<="00000000000000000000000000000100";
		B<="00000000000000000000000000000010";
		Op<="0010";
      wait for 100 ns;
		------Logic Or--------	
		A<="00000000000000000000000000000100";
		B<="00000000000000000000000000000010";
		Op<="0011";
      wait for 100 ns;
		------Complimentary Number--------	
		A<="00000111000000011100000000000100";
		Op<="0100";
      wait for 100 ns;
		------Arithmetic shift--------	
		A<="11000000000000000000000000000100";
		Op<="1000";
      wait for 100 ns;
		------Right Logic Shift--------	
		A<="11000000000000000000000000000100";
		Op<="1001";
      wait for 100 ns;
		------Left Logic Shift--------	
		A<="00000000000000000000000000000111";
		Op<="1010";
      wait for 100 ns;
		------Left cycle rotation--------	
		A<="10000000000000000000000000000100";
		Op<="1100";
      wait for 100 ns;
		------Right cycle rotation--------	
		A<="00000000000000000000000000000101";
		Op<="1101";
      wait for 100 ns;
     -- wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
