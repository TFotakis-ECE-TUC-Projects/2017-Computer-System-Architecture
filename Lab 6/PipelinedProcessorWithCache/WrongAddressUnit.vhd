library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity WrongAddressControl is
    Port ( input : in  STD_LOGIC_VECTOR (21 downto 0);
						Instr : in  STD_LOGIC_VECTOR (31 downto 0);
					output : out  STD_LOGIC);
end WrongAddressControl;
architecture Structural of WrongAddressControl is
begin
process(input, Instr)
	begin
		if(input=std_logic_vector(to_unsigned(0, 22)) or Instr=std_logic_vector(to_unsigned(0, 32))) then
			output<='0';
		else
			output<='1';
		end if;
	end process;
end Structural;