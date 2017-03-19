--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:00:34 02/09/2017
-- Design Name:   
-- Module Name:   E:/Workspace Xilinx/lab1/Te_FullAdder.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FullAdder
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
 
ENTITY Te_FullAdder IS
END Te_FullAdder;
 
ARCHITECTURE behavior OF Te_FullAdder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FullAdder
    PORT(
         CarryOut : OUT  std_logic;
         Sum : OUT  std_logic;
         A : IN  std_logic;
         B : IN  std_logic;
         CarryIn : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal CarryIn : std_logic := '0';

 	--Outputs
   signal CarryOut : std_logic;
   signal Sum : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FullAdder PORT MAP (
          CarryOut => CarryOut,
          Sum => Sum,
          A => A,
          B => B,
          CarryIn => CarryIn
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
		A<='0';
		B<='0';
		CarryIn<='0';
      wait for 100 ns;	
		A<='1';
		B<='0';
      wait for 100 ns;
		A<='0';
		B<='1';
      wait for 100 ns;
		A<='1';
		B<='1';
		CarryIn<='1';
      wait for 100 ns;			
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
