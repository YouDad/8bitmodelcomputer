library ieee;
use ieee.std_logic_1164.all;

entity num_scan is
	port(
		clk:in std_logic;
		id:in integer range 0 to 7;
		num:in std_logic_vector(3 downto 0);
		data:out std_logic_vector(3 downto 0);
		sel:out std_logic_vector(5 downto 0);
		dignum0,dignum1,dignum2,dignum3,dignum4,dignum5
		:out std_logic_vector(3 downto 0)
	);
end;

architecture scan of num_scan is
signal cnt:integer range 0 to 16383;
signal v:std_logic_vector(23 downto 0);
begin
	dignum0<=v(3 downto 0);
	dignum1<=v(7 downto 4);
	dignum2<=v(11 downto 8);
	dignum3<=v(15 downto 12);
	dignum4<=v(19 downto 16);
	dignum5<=v(23 downto 20);
	process(clk)
	variable which:integer range 0 to 5;
	begin
		if(falling_edge(clk))then
			case id is
				when 0=>v(3 downto 0)<=num;
				when 1=>v(7 downto 4)<=num;
				when 2=>v(11 downto 8)<=num;
				when 3=>v(15 downto 12)<=num;
				when 4=>v(19 downto 16)<=num;
				when 5=>v(23 downto 20)<=num;
				when others=>
			end case;
			if(cnt=16383)then
				cnt<=0;
				if(which/=5)then
					which:=which+1;
				else
					which:=0;
				end if;
				case which is
					when 0=>sel<="111110";data<=v(3 downto 0);
					when 1=>sel<="111101";data<=v(7 downto 4);
					when 2=>sel<="111011";data<=v(11 downto 8);
					when 3=>sel<="110111";data<=v(15 downto 12);
					when 4=>sel<="101111";data<=v(19 downto 16);
					when 5=>sel<="011111";data<=v(23 downto 20);
				end case;
			else
				cnt<=cnt+1;
			end if;
		end if;
	end process;
end;