library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity xuanzemoshi is
port(hz_1,hz_125:in std_logic;
		miaobiaomoshi_111:in std_logic_vector(2 downto 0);
		out_hz:out std_logic);
end xuanzemoshi;
architecture arc of xuanzemoshi is
signal pre_hz:std_logic;
	begin
	process(miaobiaomoshi_111,hz_1,hz_125)
		begin
			if(miaobiaomoshi_111="111" or miaobiaomoshi_111="100") then  --当选择秒表模式111或设置时分秒模式100时
				pre_hz<=hz_125;  --把125hz的时钟频率给预赋值信号
			else
				pre_hz<=hz_1;  --如果不是这两个模式就把1hz的时钟频率给预赋值信号
		end if;
		out_hz<=pre_hz;  --把预赋值的信号赋给输出信号
	end process;
end arc;