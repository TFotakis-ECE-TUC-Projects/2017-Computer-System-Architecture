----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:42:21 02/09/2017 
-- Design Name: 
-- Module Name:    Subtraction - Behavioral 
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

entity Subtraction is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Subtraction;

architecture structual of Subtraction is
component Addition
    port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf :out STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Negative_number
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal n_B:std_logic_vector(31 downto 0);
begin
   Negative_B:Negative_number port map(input=>B,output=>n_B);
   Add:Addition port map(A=>A,B=>n_B,CarryIn=>CarryIn,CarryOut=>CarryOut,Ovf=>Ovf,output=>output);
end structual;

