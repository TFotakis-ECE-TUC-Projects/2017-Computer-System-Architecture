----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:31:40 02/09/2017 
-- Design Name: 
-- Module Name:    Negative_number - Behavioral 
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

entity Negative_number is
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Negative_number;

architecture structual of Negative_number is
component Complementary_number
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Addition
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf :out STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal inner_output:std_logic_vector(31 downto 0);
signal carry_out:std_logic;
signal inner_Ovf:std_logic;
begin
 Compl_Number:Complementary_number port map(input=>input,output=>inner_output);
 Add:Addition port map(A=>inner_output,
                       B=>"00000000000000000000000000000001",
							  CarryIn=>'0',
							  CarryOut=>carry_out,
							  Ovf =>inner_Ovf,
							  output=>output);

end structual;

