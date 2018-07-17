library ieee;
use ieee.std_logic_1164.all;

entity memory is
	port(
		clk:in std_logic;
		ram_task,r_wn:in std_logic;
		lines,cols:in integer range 0 to 255;
		data:inout std_logic_vector(7 downto 0)
	);
end;
architecture bhv of memory is
type bank is array(0 to 255)of std_logic_vector(7 downto 0);
type banks is array(0 to 15)of bank;
begin
	process(clk)
	variable mem:banks;
	begin
		if(falling_edge(clk))then
			if(ram_task='1')then
				if(lines<=15)then
					if(r_wn='1')then	--read
						data<=mem(lines)(cols);
					else	--write
						mem(lines)(cols):=data;
						data<=(others=>'Z');
					end if;
				end if;
			else
				data<=(others=>'Z');
			end if;
		end if;
	end process;
end;