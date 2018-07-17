library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity delayer is
	port(
		clk:in std_logic;
		dtime:in std_logic_vector(7 downto 0);
		delayer_task:in std_logic;
		signalout:out std_logic
	);
end;

architecture bhv of delayer is
signal cnt:integer range 0 to 50000;
signal tar:integer range 0 to 256;
begin
	process(clk)begin
		if(falling_edge(clk))then
			if(delayer_task='1')then
				if(tar=0)then
					tar<=conv_integer(dtime)+1;
					signalout<='0';
				elsif(tar=1)then
					signalout<='1';
				else
					if(cnt=50000)then
						cnt<=0;
						tar<=tar-1;
					else
						cnt<=cnt+1;
					end if;
					signalout<='0';
				end if;
			else
				tar<=0;
				signalout<='1';
			end if;
		end if;
	end process;
end;