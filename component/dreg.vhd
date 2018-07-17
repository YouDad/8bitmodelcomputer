library ieee;
use ieee.std_logic_1164.all;

entity dreg is
	port(
		clk:in std_logic;
		rctr:in std_logic;
		wctr:in std_logic;
		rbus:in std_logic_vector(7 downto 0);
		wbus:out std_logic_vector(7 downto 0);
		vals:out std_logic_vector(7 downto 0)
	);
end;

architecture bhv of dreg is
signal v:std_logic_vector(7 downto 0);
begin
	vals<=v;
	process(clk)begin
		if(falling_edge(clk))then
			if(rctr='1')then
				v<=rbus;
			end if;
			if(wctr='1')then
				wbus<=v;
			else
				wbus<=(others=>'Z');
			end if;
		end if;
	end process;
end;