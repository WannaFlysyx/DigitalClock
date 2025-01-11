library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity baoshi_250hz is
port(hz_250,hz_250_flag:in std_logic;
		spk_250hz:out std_logic);
end baoshi_250hz;
architecture arc of baoshi_250hz is
signal q:std_logic_vector(9 downto 0);
signal pre_spk_250:std_logic;
	begin
	process(hz_250_flag,hz_250)  --250hz报时
		begin
			if(hz_250'event and hz_250='1') then pre_spk_250<='0';
				if(hz_250_flag='1') then 
					pre_spk_250<='1';
			end if;
			end if;
		spk_250hz<=pre_spk_250;
	end process;
end arc;