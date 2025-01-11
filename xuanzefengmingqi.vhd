library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity xuanzefengmingqi is
port(spk_500hz,spk_250hz,spk_125hz:in std_logic;
		xiang:out std_logic);
end xuanzefengmingqi;
architecture arc of xuanzefengmingqi is
	begin
	process(spk_125hz,spk_250hz,spk_500hz)
		begin
			if(spk_125hz='1' or spk_250hz='1' or spk_500hz='1') then
				xiang<='1';
			else xiang<='0';
		end if;
	end process;
end arc;