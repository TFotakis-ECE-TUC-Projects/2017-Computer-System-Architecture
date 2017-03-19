----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:47:17 02/09/2017 
-- Design Name: 
-- Module Name:    mux4to1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux4to1 is
    Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC);
end mux4to1;

architecture structural of mux4to1 is
component mux2to1
    Port ( in0 : in  STD_LOGIC;
           in1 : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC);
end component;
signal inner_signal_A,inner_signal_B:std_logic;
begin
   mux2to1_A: mux2to1 port map(in0=>input(0),
	                            in1=>input(1),
										 sel=>sel(0),
										 output=>inner_signal_A);
   mux2to1_B: mux2to1 port map(in0=>input(2),
	                            in1=>input(3),
										 sel=>sel(0),
										 output=>inner_signal_B);
	mux2to1_C: mux2to1 port map(in0=>inner_signal_A,
	                            in1=>inner_signal_B,
										 sel=>sel(1),
										 output=>output);
end structural;

