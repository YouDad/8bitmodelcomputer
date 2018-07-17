library ieee;
use ieee.std_logic_1164.all;

entity beater is
	port(
		clk:in std_logic;
		beat_signal:in std_logic_vector(1 downto 0);
		set_beat:in integer range 0 to 255;
		beat:out integer range 0 to 255;
		delay:in std_logic
	);
end;

architecture bhv of beater is
begin
	process(clk,delay)
	variable cnt:integer range 0 to 255;
	begin
		if(falling_edge(clk) and delay='1')then
			case beat_signal is
				when"00"=>cnt:=0;
				when"01"=>cnt:=cnt+1;
				when"10"=>cnt:=cnt;
				when"11"=>cnt:=set_beat;
			end case;
			beat<=cnt;
		end if;
	end process;
end;