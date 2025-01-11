library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity fengmingqi is
port(baoshi,hz_500:in std_logic;
		spk_baoshi:out std_logic);
end fengmingqi;
architecture arc of fengmingqi is
signal q:std_logic_vector(9 downto 0);
signal pre_spk:std_logic;
	begin
	process(baoshi,hz_500)  --闹钟报时
		begin
			if(hz_500'event and hz_500='1') then  pre_spk<='0';
				if(baoshi='1') then
					pre_spk<='1';
			end if;
			end if;
	end process;
	spk_baoshi<=pre_spk;
end arc;