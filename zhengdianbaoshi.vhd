library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity zhengdianbaoshi is
	port (hz_miao:in std_logic_vector(7 downto 0);
		hz_fen:in std_logic_vector(7 downto 0);
		hz_shi:in std_logic_vector(7 downto 0);
		naozhong_shi:in std_logic_vector(7 downto 0);
		naozhong_fen:in std_logic_vector(7 downto 0);
		naozhong_miao:in std_logic_vector(7 downto 0);
		zhengdianbaoshi_000:std_logic_vector(2 downto 0);
		clk_500,clk_125,clk_250,en_baoshi:in std_logic;
		spk:out std_logic);
end zhengdianbaoshi;
architecture arc of zhengdianbaoshi is
	begin
		process(clk_125,clk_500,clk_250,hz_miao,hz_shi,hz_fen)  --此处左边是低位，右边是高位
			begin
				if(en_baoshi='1') then  --当开启报时功能时
					if(zhengdianbaoshi_000="000") then  --此处是正常的计时模式才可以报时
						if(hz_fen="10010101" and (hz_shi="00000000" or hz_shi="00010000"  --当59分时准备报时  
							or hz_shi="00100000" or hz_shi="00110000" or hz_shi="01000000"
							or hz_shi="01010000" or hz_shi="01100000" or hz_shi="01110000"
							or hz_shi="10000000" or hz_shi="10010000" or hz_shi="00000001"
							or hz_shi="00010001" or hz_shi="00100001" or hz_shi="00110001"
							or hz_shi="01000001" or hz_shi="01010001" or hz_shi="01100001"
							or hz_shi="01110001" or hz_shi="10000001" or hz_shi="10010001"
							or hz_shi="00000010" or hz_shi="00010010" or hz_shi="00100010"
							or hz_shi="00110010")) then
							if(hz_miao="00000101" or hz_miao="00100101" or hz_miao="01000101") then  --当第50、52、54秒时较低频率预报时
								spk<=clk_125;
							end if;
							if(hz_miao="01100101" or hz_miao="10000101") then  --当56、58秒时中等频率报时
								spk<=clk_250;
							end if;
							if(hz_miao="00000000") then  --当整点时较高频率报时
								spk<=clk_500;
							end if;
						end if;
						if((naozhong_shi=hz_shi or (naozhong_shi(7 downto 4)=hz_shi(7 downto 4) 
						and (naozhong_shi(3 downto 0)=hz_shi(3 downto 0)+1)))
						and naozhong_fen=hz_fen and naozhong_miao=hz_miao) then  
							--此处因为有灭零功能存在需要分不同情况判断，核心在于闹钟的时间与当前时间相同时报时
							spk<=clk_500;
						end if;
					end if;	
				end if;
		end process;
end arc;