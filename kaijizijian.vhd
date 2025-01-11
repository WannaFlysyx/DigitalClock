library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity kaijizijian is
	port(checkmoshi_101:in std_logic_vector(2 downto 0);
			hz_1:in std_logic;
			out_key:out std_logic_vector(3 downto 0);
			check_flag:out std_logic);
end kaijizijian;
architecture behavioral of kaijizijian is
signal pre_out_key:std_logic_vector(3 downto 0);
signal pre_check_flag:std_logic;
	begin
		process(checkmoshi_101,hz_1)
			begin
				if(hz_1'event and hz_1='1') then  --当时钟上升沿到来
					if(checkmoshi_101="101") then  --选择了101开机自检模式的时候
						if(pre_check_flag='0') then
							pre_out_key<=pre_out_key+1;  --不断增加的预赋值信号
							pre_check_flag<='1';  --给时分秒赋值的信号
							if(pre_out_key="1001") then  --使检查的数值在0-9之间循环
								pre_out_key<="0000";
							end if;
						else 
							pre_check_flag<='0';  --赋完值之后立刻归零防止多次赋值
						end if;
					end if;
				end if;
			out_key<=pre_out_key;  --把预赋值的数值给输出信号
			check_flag<=pre_check_flag;
		end process;
end behavioral;