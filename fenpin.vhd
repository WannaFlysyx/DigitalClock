library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity fenpin is
	port (clk:in std_logic;
		hz_1:out std_logic;
		hz_500:out std_logic;
		hz_250:out std_logic;
		hz_125:out std_logic;
		hz_64:out std_logic);
end fenpin;
architecture behavioral of fenpin is
signal q:std_logic_vector(9 downto 0);
	begin
		process(clk)
	begin
		if(rising_edge(clk)) then  --当时钟上升沿到来时
			q<=q+1;  --不断往上加1
		end if;
		hz_500<=q(1);	--每加2次从低往高第二位会改变一次
		hz_250<=q(2);  --每加4次从低往高第二位会改变一次
		hz_125<=q(3);	--每加8次从低往高第二位会改变一次
		hz_64<=q(4);   --每加16次从低往高第二位会改变一次
		hz_1<=q(9);    --每加1000次从低往高第二位会改变一次
	end process;
end behavioral;