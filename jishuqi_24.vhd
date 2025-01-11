library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity jishuqi_24 is
	port(clk,check_flag,clk_fen:in std_logic;
			check,set_shi_fen_miao:in std_logic_vector(3 downto 0);
			jishimoshi_011,select_positon:in std_logic_vector(2 downto 0);
			count:out std_logic;
			count_1and2:out std_logic_vector(7 downto 0));
end jishuqi_24;
architecture behavioral of jishuqi_24 is
	signal pre_count:std_logic;
	signal pre_count_1,pre_count_2:std_logic_vector(3 downto 0);
	signal zhengdianbaoshi_flag:std_logic;
	begin
		process(check,check_flag,jishimoshi_011,clk,clk_fen,pre_count_1,pre_count_2,set_shi_fen_miao,select_positon)
			begin
				if(clk'event and clk='1') then pre_count<='0';  --当时钟的上升沿到来
					if(pre_count_1=9 and check_flag='0' and jishimoshi_011="000" and clk_fen='1') then  
						--当选择计时模式000且低位的数是9且开机自检模式未被选中且已经经过60分钟获得一个上升沿
						if(pre_count_2="1111") then  --当高位处于灭零状态时如果需要亮起则说明已经超过一位数
							pre_count_2<="0001";  --因此高位直接从1开始
						end if;
						if(pre_count_2="0001" and pre_count_2/="1111") then  --当高位已经是1，往后便是正常的计数
							pre_count_2<=pre_count_2+1;	--当低位是9且有进位时，高位加1
						end if;
						pre_count_1<="0000";  --进位后低位置零
					elsif(check_flag='0' and jishimoshi_011="000") then  --当选择计时模式000且开机自检模式未被选中时
						if(clk_fen='1') then  --当已经过60分钟获得一个上升沿
							pre_count_1<=pre_count_1+1;  --低位加1
						end if;
						pre_count<='0';
						if(pre_count_1=3 and pre_count_2=2 and check_flag='0' and jishimoshi_011="000" and clk_fen='1') then  
							--当选择计时模式000且高位是2低位是3且开机自检模式未被选中且已经经过60分钟获得一个上升沿
							pre_count_1<="0000";  --低位置零
							pre_count_2<="0000";  --高位置零
						end if;
						if(pre_count_2="0000") then  --此处设置灭零，如果高位是0则不显示
							pre_count_2<="1111";  --在动态扫描模块里面将1111设置为不显示
						end if;
					elsif(pre_count_1=9  and check_flag='0' and jishimoshi_011="111" and clk_fen='1') then 
						--当选择秒表模式111且低位的数不是9且开机自检信号未被选中且已经过60秒获得一个上升沿
						if(pre_count_2=9) then  --如果高位是9，即99分钟后
							pre_count_1<="0000";  --低位置零
							pre_count_2<="0000";  --高位置零
							pre_count<='1';  
						else pre_count_2<=pre_count_2+1;  --如果高位的数不是9
							pre_count_1<="0000";  --低位向高位进位并低位置零
						end if;
					elsif(pre_count_1/=9 and check_flag='0' and jishimoshi_011="111" and clk_fen='1') then  
						--当选择秒表模式111且低位的数不是9且开机自检信号未被选中且已经过60秒获得一个上升沿
						pre_count_1<=pre_count_1+1;  --低位加1
					   pre_count<='0';  
					elsif (jishimoshi_011="011") then  --当选择全局置零模式011 
						pre_count_1<="0000";  --低位置零
						pre_count_2<="0000";  --高位置零
					elsif(jishimoshi_011="100") then  --当选择设置时间模式100
						if(select_positon="110") then  --选择需要更改的位置
							pre_count_1<=set_shi_fen_miao;  --给需要更改的数赋新值
						end if;
						if(select_positon="111") then
							pre_count_2<=set_shi_fen_miao;
						end if;
					elsif(jishimoshi_011="101") then  --当选择开机自检模式101
							pre_count_1<=check;  --把给定的统一值给预赋值信号
							pre_count_2<=check;
					end if;
				end if;
			count_1and2<=pre_count_1&pre_count_2;  --把两个四位BCD码连接成八位
			count<=pre_count;  --把预赋值信号赋给输出信号
		end process;
end behavioral;