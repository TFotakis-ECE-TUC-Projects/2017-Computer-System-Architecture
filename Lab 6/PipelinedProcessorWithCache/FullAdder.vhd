----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:42:52 02/09/2017 
-- Design Name: 
-- Module Name:    FullAdder - Behavioral 
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

entity FullAdder is
    Port ( CarryOut : out  STD_LOGIC;
           Sum : out  STD_LOGIC;
           A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           CarryIn : in  STD_LOGIC);
end FullAdder;

architecture structural of FullAdder is
component HalfAdder
port(
           inputA : in  STD_LOGIC;
           inputB : in  STD_LOGIC;
			  out1 : out  STD_LOGIC;
           out2 : out  STD_LOGIC
    );
end component;
signal signalAnd,signalXor,signalAnd2:std_logic;
begin
    HalfAdder1:HalfAdder port map(inputA=>A,inputB=>B,out1=>signalAnd,out2=>signalXor);
	 HalfAdder2:HalfAdder port map(inputA=>signalXor,inputB=>CarryIn,out1=>signalAnd2,out2=>Sum);
	 CarryOut <= signalAnd2 or signalAnd;
end structural;

