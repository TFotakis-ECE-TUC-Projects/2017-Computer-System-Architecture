library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
--use IEEE.NUMERIC_STD.ALL;
entity Cache is
port (
	clk : in std_logic;
	addr : in std_logic_vector(6 downto 0);
	dout : out std_logic_vector(31 downto 0);
	valid: out std_logic;
	tag: out std_logic_vector(2 downto 0));
end Cache;

architecture syn of Cache is

type rom_type is array (31 downto 0) of std_logic_vector (131 downto 0);

impure function InitRomFromFile (RomFileName : in string) return rom_type is

FILE romfile : text is in RomFileName;

variable RomFileLine : line;
variable rom : rom_type;

begin
	for i in 0 to 31 loop
		readline(romfile, RomFileLine);
		read (RomFileLine, rom(i));
	end loop;
return rom;
end function;

signal ROM : rom_type := InitRomFromFile("cache.data");

begin
	process (clk)
		begin
			if clk'event and clk = '1' then
				if(addr(1 downto 0)="00") then
					dout <= ROM(conv_integer(addr(6 downto 2))) (31 downto 0);
				elsif(addr(1 downto 0)="01") then
					dout <= ROM(conv_integer(addr(6 downto 2))) (63 downto 32);
				elsif(addr(1 downto 0)="10") then
					dout <= ROM(conv_integer(addr(6 downto 2))) (95 downto 64);
				else
					dout <= ROM(conv_integer(addr(6 downto 2))) (127 downto 96);
				end if;
				valid<=ROM(conv_integer(addr(6 downto 2)))(131);
				tag<=ROM(conv_integer(addr(6 downto 2)))(130 downto 128);
			end if;
	end process;
end syn;