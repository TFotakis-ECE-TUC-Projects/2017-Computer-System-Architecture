library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ImmediateProcessor is
    Port (Data : in  	STD_LOGIC_VECTOR (15 downto 0);
				Dout : out  	STD_LOGIC_VECTOR (31 downto 0);
				Instr : in  	STD_LOGIC_VECTOR (5 downto 0));
end ImmediateProcessor;
architecture Behavioral of ImmediateProcessor is
begin
	ConvertImmediate:  process(Instr, Data)
	begin
		case Instr is
			when "000011" | "000111" | "001111" | "011111" | "110000" | "111000" | "101111" | "111100" | "111110" => --SignExt
				for i in 0 to 15 loop
					Dout(16+i)<=Data(15);
				end loop;
				Dout(15 downto 0)<=Data;
			when "111111" | "000000" | "000001" | "100111"  => --SignExt(Imm)<<2
				for i in 0 to 13 loop
					Dout(18+i)<=Data(15);
				end loop;
				Dout(17 downto 2)<=Data;
				Dout(1 downto 0)<="00";
			when "111001"=> --Imm<<16zerofill
				Dout(31 downto 16)<=Data;
				Dout(15 downto 0)<=std_logic_vector(to_unsigned(0,16));
			when "110010" | "110011"=> --ZeroFill
				Dout(31 downto 16)<=std_logic_vector(to_unsigned(0,16));
				Dout(15 downto 0)<=Data;
			when others => Dout<=std_logic_vector(to_unsigned(0,32));
		end case;
	end process ConvertImmediate;
end Behavioral;