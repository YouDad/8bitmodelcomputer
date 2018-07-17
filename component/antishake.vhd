library ieee;
use ieee.std_logic_1164.all;

entity antishake is
	port(
		clk:in std_logic;
		keyin:in std_logic;
		keyout:out std_logic
	);
end;

architecture bhv of antishake is
signal last:std_logic;
signal cnt:integer range 0 to 500000;
begin
	process(clk)begin
		if(falling_edge(clk))then
			if(last/=keyin)then
				last<=keyin;
				cnt<=0;
			else
				if(cnt=500000)then
					keyout<=keyin;
					cnt<=0;
				else
					cnt<=cnt+1;
				end if;
			end if;
		end if;
	end process;
end;