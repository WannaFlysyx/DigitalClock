library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity DynamicScan is
	port(clk:in std_logic;
			h,m,s:in	std_logic_vector(7 downto 0);
			ledag:out std_logic_vector(6 downto 0);
			sel:buffer std_logic_vector(2 downto 0));
end DynamicScan;
architecture arc of DynamicScan is
signal key :std_logic_vector(3 downto 0);
signal pre_kaijizijian:std_logic_vector(3 downto 0);
begin	
	one:process(clk)  --动态扫描核心：人眼暂留
		variable sell:std_logic_vector(2 downto 0);
		begin	
			if(clk'event and clk='1')  --当时钟信号的上升沿来
				then sell:=sell+1;  --sell作为临时变量，需要及时赋值所以使用variable
			end if;
			sel<=sell;  --将临时变量的值赋给位选信号
		end process;
	two:process(key)	--每一个位上显示的数字
			begin
				case key is  --根据不同的数字给数码管不同的信号使其显示相应的数字
					when "0000"=>ledag<="0111111";  --0
					when "0001"=>ledag<="0000110";  --1
					when "0010"=>ledag<="1011011";  --2
					when "0011"=>ledag<="1001111";  --3
					when "0100"=>ledag<="1100110";  --4
					when "0101"=>ledag<="1101101";  --5
					when "0110"=>ledag<="1111101";  --6
					when "0111"=>ledag<="0000111";  --7
					when "1000"=>ledag<="1111111";  --8
					when "1001"=>ledag<="1101111";  --9
					when "1110"=>ledag<="1000000";  --“-”
					when others=>ledag<="0000000";  --此处用来灭零
				end case;
		end process;
	three:process(sel,s,m,h)  --时分秒的显示
		begin
			case sel is  --用八位BCD码表示两位十进制数
				when "111"=>key<=s(7 downto 4);  --选取八位BCD码的高位作为较大的那个数的数值  
				when "110"=>key<=s(3 downto 0);	--选取八位BCD码的低位作为较小的那个数的数值
				when "101"=>key<="1110";			--中间用符号“-”来间隔时分秒
				when "100"=>key<=m(7 downto 4);
				when "011"=>key<=m(3 downto 0);
				when "010"=>key<="1110";
				when "001"=>key<=h(7 downto 4);
				when "000"=>key<=h(3 downto 0);
				when others =>key<= "XXXX";
			end case;
		end process;
end arc;
