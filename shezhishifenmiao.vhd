library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity shezhishifenmiao is
	port(clk:in std_logic;
			shezhishijianmoshi_100:in std_logic_vector(2 downto 0);
			select_positon:in std_logic_vector(2 downto 0);
			set_shi_fen_miao:in std_logic_vector(3 downto 0);
			shi:buffer std_logic_vector(7 downto 0);
			fen:buffer std_logic_vector(7 downto 0);
			miao:buffer std_logic_vector(7 downto 0);
			out_flag:out std_logic);
end shezhishifenmiao;
architecture arc of shezhishifenmiao is
signal pre_shi_1,pre_fen_1,pre_miao_1,pre_shi_2,pre_fen_2,pre_miao_2:std_logic_vector(3 downto 0);
signal pre_out_flag:std_logic;
	begin
	process(shezhishijianmoshi_100,clk,select_positon,set_shi_fen_miao,pre_fen_1,pre_fen_2,pre_miao_1,pre_miao_2,pre_shi_1,pre_shi_2)
		begin
			if(clk'event and clk='1') then 
				if(shezhishijianmoshi_100="100") then  
					if(pre_out_flag='0') then 
						pre_out_flag<='1';
						case select_positon is
							when "000"=>pre_shi_1<=set_shi_fen_miao;
							when "001"=>pre_shi_2<=set_shi_fen_miao;
							when "011"=>pre_fen_1<=set_shi_fen_miao;
							when "100"=>pre_fen_2<=set_shi_fen_miao;
							when "110"=>pre_miao_1<=set_shi_fen_miao;
							when "111"=>pre_miao_2<=set_shi_fen_miao;
							when others=>pre_shi_1<="XXXX";pre_shi_2<="XXXX";pre_fen_1<="XXXX";pre_fen_2<="XXXX";pre_miao_1<="XXXX";pre_miao_2<="XXXX";
						end case;
					else pre_out_flag<='0';
					end if;
					
				end if;
		shi<=pre_shi_1&pre_shi_2;
		fen<=pre_fen_1&pre_fen_2;
		miao<=pre_miao_1&pre_miao_2;
		out_flag<=pre_out_flag;
			end if;
			
	end process;
end arc;