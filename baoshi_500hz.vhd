library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity baoshi_500hz is
port(hz_500,hz_500_flag:in std_logic;
		spk_500hz:out std_logic);
end baoshi_500hz;
architecture arc of baoshi_500hz is
signal q:std_logic_vector(9 downto 0);
signal pre_spk_500:std_logic;
	begin
	process(hz_500_flag,hz_500)  --500hz报时
		begin
			if(hz_500'event and hz_500='1') then pre_spk_500<='0';
				if(hz_500_flag='1') then 
					pre_spk_500<='1';
			end if;
			end if;
		spk_500hz<=pre_spk_500;
	end process;
end arc;