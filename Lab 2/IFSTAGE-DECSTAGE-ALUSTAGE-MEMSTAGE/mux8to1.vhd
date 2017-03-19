----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:57:53 02/09/2017 
-- Design Name: 
-- Module Name:    mux8to1 - Behavioral 
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

entity mux8to1 is
    Port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC);
end mux8to1;

architecture structural of mux8to1 is
component mux4to1
    Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC);
end component;
signal inner_output_A,inner_output_B,inner_signal_A,inner_signal_B:std_logic;
begin
  Mux4to1_A:mux4to1 port map(input(0)=>input(0),
                             input(1)=>input(1),
									  input(2)=>input(2),
									  input(3)=>input(3),
									  sel(0)=>sel(0),
									  sel(1)=>sel(1),
									  output=>inner_output_A);
  Mux4to1_B:mux4to1 port map(input(0)=>input(4),
                             input(1)=>input(5),
									  input(2)=>input(6),
									  input(3)=>input(7),
									  sel(0)=>sel(0),
									  sel(1)=>sel(1),
									  output=>inner_output_B);
  inner_signal_A<=inner_output_A and (not sel(2));
  inner_signal_B<=inner_output_B and  sel(2);
  output<=  inner_signal_A or inner_signal_B ;
end structural;

