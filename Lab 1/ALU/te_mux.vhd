--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:39:29 02/09/2017
-- Design Name:   
-- Module Name:   E:/Workspace Xilinx/lab1/te_mux.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux2to1
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
 
ENTITY te_mux IS
END te_mux;
 
ARCHITECTURE behavior OF te_mux IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux2to1
    PORT(
         in0 : IN  std_logic;
         in1 : IN  std_logic;
         sel : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal in0 : std_logic := '0';
   signal in1 : std_logic := '0';
   signal sel : std_logic := '0';

 	--Outputs
   signal output : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux2to1 PORT MAP (
          in0 => in0,
          in1 => in1,
          sel => sel,
          output => output
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
		in0<='1';
		in1<='0';
		sel<='0';
      wait for 100 ns;	
		in0<='1';
		in1<='0';
		sel<='1';
      wait for 100 ns;	
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
