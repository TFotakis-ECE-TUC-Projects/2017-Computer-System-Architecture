----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:09:51 02/09/2017 
-- Design Name: 
-- Module Name:    Addition - Behavioral 
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

entity Addition is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf :out STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Addition;

architecture structual of Addition is
component FullAdder
    port ( CarryOut : out  STD_LOGIC;
           Sum : out  STD_LOGIC;
           A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           CarryIn : in  STD_LOGIC);
end component;
signal inner_carry:std_logic_vector(31 downto 0);
begin

 First_FullAdder:FullAdder port map(A=>A(0),B=>B(0),CarryIn=>CarryIn,CarryOut=>inner_carry(0),Sum=>output(0));
 FullAdder_instances:
 for i in 1 to 31 generate
   my_fullAdder:FullAdder port map(A=>A(i),B=>B(i),CarryIn=>inner_carry(i-1),CarryOut=>inner_carry(i),Sum=>output(i));
 end generate;
 CarryOut<=inner_carry(31);
 Ovf<=((((B(31)and A(31)) and ( not inner_carry(30) )) and inner_carry(31)) or ((( not(B(31)) and  not(A(31)) ) and inner_carry(30)) and not(inner_carry(31))));
end structual;

