library ieee;
use ieee.std_logic_1164.all;

entity stack is
	port(
		clk:in std_logic;
		stack_task,push:in std_logic;
		data:inout std_logic_vector(7 downto 0)
	);
end;

architecture bhv of stack is
subtype t_vector is std_logic_vector(7 downto 0);
type t_matrix is array(127 downto 0)of t_vector;
begin
	process(clk)
	variable room:t_matrix;
	variable top:integer range 0 to 127;
	begin
		if(falling_edge(clk))then
			if(stack_task='1')then
				if(push='1')then
					room(top):=data;
					top:=top+1;
					data<=(others=>'Z');
				else
					top:=top-1;
					data<=room(top);
				end if;
			else
				data<=(others=>'Z');
			end if;
		end if;
	end process;
end;