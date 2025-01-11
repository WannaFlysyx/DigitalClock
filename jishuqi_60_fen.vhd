library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity jishuqi_60_fen is
	port(clk,check_flag,clk_miao:in std_logic;
			jishimoshi_011:in std_logic_vector(2 downto 0);
			select_positon:in std_logic_vector(2 downto 0);
			set_shi_fen_miao:in std_logic_vector(3 downto 0);
			check:in std_logic_vector(3 downto 0);
			count:out std_logic;
			count_1and2:out std_logic_vector(7 downto 0));
end jishuqi_60_fen;
architecture behavioral of jishuqi_60_fen is
	signal pre_count:std_logic;
	signal pre_count_1,pre_count_2:std_logic_vector(3 downto 0);
	begin
		process(jishimoshi_011,clk,clk_miao,pre_count_1,pre_count_2,select_positon,set_shi_fen_miao)  --111作为重置选项
			begin
					if(clk'event and clk='1') then  --当时钟的上升沿到来
					if(pre_count_1=9 and check_flag='0' and jishimoshi_011="000" and clk_miao='1') then  
						--当选择计时模式000且低位的数是9且开机自检模式未被选中且已经经过60秒获得一个上升沿
							if(pre_count_2=5) then  --如果高位的数是5，即59
								pre_count_1<="0000";  --低位置零
								pre_count_2<="0000";  --高位置零
								pre_count<='1';  --给分钟一个上升信号
							else pre_count_2<=pre_count_2+1;  --如果高位的数不是5
								pre_count_1<="0000";  --低位向高位进位
							end if;
							elsif(pre_count_1/=9 and check_flag='0' and jishimoshi_011="000") then  
								--当选择计时模式000且低位的数不是9且开机自检模式未被选中
								if(clk_miao='1') then  --已经经过60秒获得一个上升沿
									pre_count_1<=pre_count_1+1;  --低位自加1
								end if;
							   pre_count<='0';  --把给分钟的上升信号置零
						elsif(pre_count_1=9  and check_flag='0' and jishimoshi_011="111" and clk_miao='1') then	
							--当选择秒表模式111且低位的数是9且开机自检信号未被选中且已经经过60秒获得一个上升沿
							if(pre_count_2=5) then  --如果高位的数是9，即99
								pre_count_1<="0000";  --低位置零
								pre_count_2<="0000";  --高位置零
								pre_count<='1';  --给分钟一个上升信号
							else pre_count_2<=pre_count_2+1;  --如果高位的数不是9
								pre_count_1<="0000";  --低位向高位进位并低位置零
							end if;
						elsif(pre_count_1/=9 and check_flag='0' and jishimoshi_011="111") then  --当选择秒表模式111且低位的数不是9且开机自检信号未被选中
								if(clk_miao='1') then  --已经经过60秒获得一个上升沿
									pre_count_1<=pre_count_1+1;  --低位自加1
								end if;
							   pre_count<='0';  --把给分钟的上升信号置零
						elsif(jishimoshi_011="100") then  --当选择设置时间模式100
							if(select_positon="011") then  --选择需要更改的位置
								pre_count_1<=set_shi_fen_miao;  --给需要更改的数赋新值
							end if;
							if(select_positon="100") then
								pre_count_2<=set_shi_fen_miao;
							end if;
						elsif (jishimoshi_011="011") then --当选择全局置零模式011
							pre_count_1<="0000";  --低位置零
							pre_count_2<="0000";  --高位置零
						elsif(jishimoshi_011="101") then  --当选择开机自检模式101
							--if(check_flag='1') then 
								pre_count_1<=check;  --把给定的统一值给预赋值信号
								pre_count_2<=check;
							--end if;
						end if;
				end if;
			count_1and2<=pre_count_1&pre_count_2;  --把两个四位BCD码连接成八位
			count<=pre_count;  --把预赋值信号赋给输出信号
		end process;
end behavioral;