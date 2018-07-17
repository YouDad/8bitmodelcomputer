library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port(
		clk:in std_logic;
		xf:in std_logic_vector(7 downto 0);
		rbus:in std_logic_vector(7 downto 0);
		rctr:in std_logic;
		wctr:in std_logic;
		s:in std_logic_vector(0 to 3);
		wbus:out std_logic_vector(7 downto 0);
		cf,zf,sf,odd:out std_logic;
		vals:out std_logic_vector(7 downto 0)
	);
end;

architecture bhv of alu is
begin
	process(rctr,rbus,wctr,xf,s)
	variable ans,v:std_logic_vector(7 downto 0);
	variable tmp_c:std_logic_vector(6 downto 0);
	begin
		if(rctr='1')then
			v:=rbus;
		end if;
		if(wctr='1')then
			wbus<=ans;
		else
			wbus<="ZZZZZZZZ";
			case s is
				when"1111"=>
					ans:=xf;
		vals<=ans;
		sf<=ans(7);
		zf<=not(ans(0)or ans(1)or ans(2)or ans(3)or ans(4)or ans(5)or ans(6)or ans(7));
		odd<=ans(0);
				when"0000"=>	-->inc
					ans(0):=xf(0) xor '1';
					ans(1):=xf(1) xor xf(0);
					ans(2):=xf(2) xor (xf(0) and xf(1));
					ans(3):=xf(3) xor (xf(0) and xf(1) and xf(2));
					ans(4):=xf(4) xor (xf(0) and xf(1) and xf(2) and xf(3));
					ans(5):=xf(5) xor (xf(0) and xf(1) and xf(2) and xf(3) and xf(4));
					ans(6):=xf(6) xor (xf(0) and xf(1) and xf(2) and xf(3) and xf(4) and xf(5));
					ans(7):=xf(7) xor (xf(0) and xf(1) and xf(2) and xf(3) and xf(4) and xf(5) and xf(6));
					cf<=xf(0) and xf(1) and xf(2) and xf(3) and xf(4) and xf(5) and xf(6) and xf(7);
		vals<=ans;
		sf<=ans(7);
		zf<=not(ans(0)or ans(1)or ans(2)or ans(3)or ans(4)or ans(5)or ans(6)or ans(7));
		odd<=ans(0);
				when"0001"=>	-->dec
					ans(0):=xf(0) xor '1';
					ans(1):=xf(1) xor '1' xor xf(0);
					ans(2):=xf(2) xor '1' xor (xf(1)or xf(0));
					ans(3):=xf(3) xor '1' xor (xf(2)or xf(1)or xf(0));
					ans(4):=xf(4) xor '1' xor (xf(3)or xf(2)or xf(1)or xf(0));
					ans(5):=xf(5) xor '1' xor (xf(4)or xf(3)or xf(2)or xf(1)or xf(0));
					ans(6):=xf(6) xor '1' xor (xf(5)or xf(4)or xf(3)or xf(2)or xf(1)or xf(0));
					ans(7):=xf(7) xor '1' xor (xf(6)or xf(5)or xf(4)or xf(3)or xf(2)or xf(1)or xf(0));
					cf<=not(xf(7)or xf(6)or xf(5)or xf(4)or xf(3)or xf(2)or xf(1)or xf(0));
		vals<=ans;
		sf<=ans(7);
		zf<=not(ans(0)or ans(1)or ans(2)or ans(3)or ans(4)or ans(5)or ans(6)or ans(7));
		odd<=ans(0);
				when"0010"=>	-->add
					tmp_c(0):=xf(0) and v(0);
					tmp_c(1):=(xf(1) and v(1))or(tmp_c(0) and xf(1))or(tmp_c(0) and v(1));
					tmp_c(2):=(xf(2) and v(2))or(tmp_c(1) and xf(2))or(tmp_c(1) and v(2));
					tmp_c(3):=(xf(3) and v(3))or(tmp_c(2) and xf(3))or(tmp_c(2) and v(3));
					tmp_c(4):=(xf(4) and v(4))or(tmp_c(3) and xf(4))or(tmp_c(3) and v(4));
					tmp_c(5):=(xf(5) and v(5))or(tmp_c(4) and xf(5))or(tmp_c(4) and v(5));
					tmp_c(6):=(xf(6) and v(6))or(tmp_c(5) and xf(6))or(tmp_c(5) and v(6));
					ans(0):=xf(0) xor v(0);
					ans(1):=xf(1) xor v(1) xor tmp_c(0);
					ans(2):=xf(2) xor v(2) xor tmp_c(1);
					ans(3):=xf(3) xor v(3) xor tmp_c(2);
					ans(4):=xf(4) xor v(4) xor tmp_c(3);
					ans(5):=xf(5) xor v(5) xor tmp_c(4);
					ans(6):=xf(6) xor v(6) xor tmp_c(5);
					ans(7):=xf(7) xor v(7) xor tmp_c(6);
					cf<=(xf(7) and v(7))or(tmp_c(6) and xf(7))or(tmp_c(6) and v(7));
		vals<=ans;
		sf<=ans(7);
		zf<=not(ans(0)or ans(1)or ans(2)or ans(3)or ans(4)or ans(5)or ans(6)or ans(7));
		odd<=ans(0);
				when"0011"=>	-->or
					ans:=xf or v;
		vals<=ans;
		sf<=ans(7);
		zf<=not(ans(0)or ans(1)or ans(2)or ans(3)or ans(4)or ans(5)or ans(6)or ans(7));
		odd<=ans(0);
				when"1000"=>	-->xor
					ans:=xf xor v;
		vals<=ans;
		sf<=ans(7);
		zf<=not(ans(0)or ans(1)or ans(2)or ans(3)or ans(4)or ans(5)or ans(6)or ans(7));
		odd<=ans(0);
				when"1001"=>	-->and
					ans:=xf and v;
		vals<=ans;
		sf<=ans(7);
		zf<=not(ans(0)or ans(1)or ans(2)or ans(3)or ans(4)or ans(5)or ans(6)or ans(7));
		odd<=ans(0);
				when"1010"=> -->shl
					ans:=xf(6 downto 0)&'0';
					cf<=xf(7);
		vals<=ans;
		sf<=ans(7);
		zf<=not(ans(0)or ans(1)or ans(2)or ans(3)or ans(4)or ans(5)or ans(6)or ans(7));
		odd<=ans(0);
				when"1011"=> -->shr
					ans:='0'&xf(7 downto 1);
					cf<=xf(0);
		vals<=ans;
		sf<=ans(7);
		zf<=not(ans(0)or ans(1)or ans(2)or ans(3)or ans(4)or ans(5)or ans(6)or ans(7));
		odd<=ans(0);
				when others=>
			end case;
		end if;
	end process;
end;