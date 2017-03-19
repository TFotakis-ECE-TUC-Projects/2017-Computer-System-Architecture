--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:27:29 02/09/2017
-- Design Name:   
-- Module Name:   E:/Workspace Xilinx/lab1/te_Addition.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Addition
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
 
ENTITY te_Addition IS
END te_Addition;
 
ARCHITECTURE behavior OF te_Addition IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Addition
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         CarryIn : IN  std_logic;
         CarryOut : OUT  std_logic;
			Ovf :out STD_LOGIC;
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal CarryIn : std_logic := '0';

 	--Outputs
   signal CarryOut : std_logic;
	signal Ovf  : std_logic;
   signal output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Addition PORT MAP (
          A => A,
          B => B,
          CarryIn => CarryIn,
          CarryOut => CarryOut,
          output => output,
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
		A<="00000000000000000000000000000100";
		B<="00000000000000000000000000000100";
		CarryIn<='0';
      wait for 100 ns;
      A<="10000000000000000000000000000100";
		B<="10000000000000000000000000000100";
		CarryIn<='0';
      wait for 100 ns;	
      A<="01000000000000000000000000000100";
		B<="01000000000000000000000000000100";
		CarryIn<='0';
      wait for 100 ns;		
	   A<="00000000000000000000000000000100";
		B<="00000000000000000000000000000100";
		CarryIn<='1';
      wait for 100 ns;
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
