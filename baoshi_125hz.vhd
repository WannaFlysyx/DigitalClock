library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity baoshi_125hz is
port(hz_125,hz_125_flag:in std_logic;
		spk_125hz:out std_logic);
end baoshi_125hz;
architecture arc of baoshi_125hz is
signal q:std_logic_vector(9 downto 0);
signal pre_spk_125:std_logic;
	begin
	process(hz_125_flag,hz_125)  --125hz报时
		begin
			if(hz_125'event and hz_125='1') then  pre_spk_125<='0';
				if(hz_125_flag='1') then
					pre_spk_125<='1';
			end if;
			end if;
		spk_125hz<=pre_spk_125;
	end process;
end arc;