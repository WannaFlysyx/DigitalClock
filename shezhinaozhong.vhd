library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity shezhinaozhong is
	port(clk:in std_logic;
			naozhongmoshi_110:std_logic_vector(2 downto 0);
			select_positon:in std_logic_vector(2 downto 0);
			set_shi_fen_miao:in std_logic_vector(3 downto 0);
			naozhong_shi:out std_logic_vector(7 downto 0);
			naozhong_fen:out std_logic_vector(7 downto 0);
			naozhong_miao:out std_logic_vector(7 downto 0));
end shezhinaozhong;
architecture arc of shezhinaozhong is
signal pre_shi_1,pre_shi_2,pre_fen_1,pre_fen_2,pre_miao_1,pre_miao_2:std_logic_vector(3 downto 0);
	begin
	process(naozhongmoshi_110,clk,select_positon,set_shi_fen_miao,pre_fen_1,pre_fen_2,pre_miao_1,pre_miao_2,pre_shi_1,pre_shi_2)
		begin
			if(clk'event and clk='1') then  --当时钟的上升沿到来
				if(naozhongmoshi_110="110") then  --当选择设置闹钟模式110
					if(select_positon="000") then	 --选择时分秒的不同位置
						pre_miao_1<=set_shi_fen_miao;  --设置不同数值
					end if;
					if(select_positon="001") then
						pre_miao_2<=set_shi_fen_miao;  --赋给预赋值信号
					end if;
					if(select_positon="011") then
						pre_fen_1<=set_shi_fen_miao;
					end if;
					if(select_positon="100") then
						pre_fen_1<=set_shi_fen_miao;
					end if;
					if(select_positon="110") then
						pre_shi_1<=set_shi_fen_miao;
					end if;
					if(select_positon="111") then
						pre_shi_1<=set_shi_fen_miao;
					end if;
				end if;
			end if;
			naozhong_shi<=pre_shi_1&pre_shi_2;  --将预赋值信号赋给输出信号
			naozhong_fen<=pre_fen_1&pre_fen_2;
			naozhong_miao<=pre_miao_1&pre_miao_2;
	end process;
end arc;