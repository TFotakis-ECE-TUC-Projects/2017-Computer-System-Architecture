--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:04:54 02/09/2017
-- Design Name:   
-- Module Name:   E:/Workspace Xilinx/lab1/te_mux8to1.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux8to1
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
 
ENTITY te_mux8to1 IS
END te_mux8to1;
 
ARCHITECTURE behavior OF te_mux8to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux8to1
    PORT(
         input : IN  std_logic_vector(7 downto 0);
         sel : IN  std_logic_vector(2 downto 0);
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(7 downto 0) := (others => '0');
   signal sel : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux8to1 PORT MAP (
          input => input,
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
		input<="01010101";
		sel<="110";
      wait for 100 ns;	
      input<="01010101";
		sel<="000";
      wait for 100 ns;
		input<="01010101";
		sel<="111";
      wait for 100 ns;
		input<="01010101";
		sel<="100";
      wait for 100 ns;
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
