library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity controller is
	port(
		rom:out std_logic;
		romL,romC:out std_logic_vector(7 downto 0);
		ram,ramrw:out std_logic;
		ramL,ramC:out std_logic_vector(7 downto 0);
		stack,push:out std_logic;
		s:out std_logic_vector(3 downto 0);
		cf,zf,sf,odd:in std_logic;
		key0,key1,key2,key3:in std_logic;
		state:buffer integer range 0 to 3;
		ins:out std_logic_vector(7 downto 0);
		clk:in std_logic;
		beat:in integer range 0 to 255;
		jmp_flag:buffer std_logic;
		rax,wax,
		rpx,wpx,
		rxf,wxf,
		rxs,wxs,
		rds,wds,
		rdx,wdx,
		rcs,wcs,
		rip,wip,
		rsi,wsi,
		rix,wix,
		rsx,wsx
		:out std_logic;
		id:out integer range 0 to 7;
		num:out std_logic_vector(3 downto 0);
		beat_signal:out std_logic_vector(1 downto 0);
		set_beat:out integer range 0 to 255;
		rbus:in std_logic_vector(7 downto 0);
		wbus:out std_logic_vector(7 downto 0);
		rommode:buffer std_logic;
		led:out std_logic_vector(2 downto 0);
		delay:out std_logic;
		buzzer:buffer std_logic
	);
end;

architecture controll of controller is
constant INIT:integer range 0 to 3:=0;
constant LOAD:integer range 0 to 3:=1;
constant EXEC:integer range 0 to 3:=2;
constant OVER:integer range 0 to 3:=3;
begin
	process(clk)
	variable cs,ip,								--load
				ds,si,								--stos|lods
				instruction							--global
				:std_logic_vector(7 downto 0);
	variable cs_flag,								--over
				fcf,fsf,fzf,fodd,					--flag
				last0,last1,last2,last3			--wait
				:std_logic;
	variable key_pressed							--wait
				:integer range 0 to 4;
	begin
		if(rising_edge(clk))then
			case state is
				when INIT=>
					case beat is
						when 00=>
							buzzer<='1';
							beat_signal<="01";s<="1111";
							rommode<='1';delay<='0';
							fcf:='0';fsf:='0';fzf:='0';fodd:='0';cs_flag:='0';id<=7;
							last0:=key0;last1:=key1;last2:=key2;last3:=key3;key_pressed:=4;
							rom<='0';ram<='0';stack<='0';
						when 01=>wax<='0';wpx<='0';wds<='0';wdx<='0';wcs<='0';wip<='0';wsi<='0';wix<='0';wxf<='0';wxs<='0';wsx<='0';
						when 02=>rax<='1';rpx<='1';rds<='1';rdx<='1';rcs<='1';rip<='1';rsi<='1';rix<='1';rxf<='1';rxs<='1';rsx<='1';
									wbus<="00000000";
						when 03=>rax<='0';rpx<='0';rds<='0';rdx<='0';rcs<='0';rip<='0';rsi<='0';rix<='0';rxf<='0';rxs<='0';rsx<='0';
						when 04=>state<=LOAD;wbus<="ZZZZZZZZ";beat_signal<="00";
						when others=>state<=LOAD;wbus<="ZZZZZZZZ";beat_signal<="00";
					end case;
				when LOAD=>
					case beat is																					-->load instruction
						when 00=>
						wax<='0';wpx<='0';wds<='0';wdx<='0';wcs<='0';         wsi<='0';wix<='0';wxf<='0';wxs<='0';wsx<='0';
						rax<='0';rpx<='0';rds<='0';rdx<='0';rcs<='0';rip<='0';rsi<='0';rix<='0';rxf<='0';rxs<='0';rsx<='0';
						rom<='0';ram<='0';stack<='0';s<="1111";id<=7;
									beat_signal<="01";
									jmp_flag<='0';
									cs_flag:='0';
									wip<='1';
						when 01=>ip:=rbus;
									wip<='0';
									wcs<='1';
						when 02=>cs:=rbus;
									wcs<='0';
									if(rommode='1')then
										rom<='1';romL<=cs;romC<=ip;
									else
										ram<='1';ramL<=cs;ramC<=ip;ramrw<='1';
									end if;
						when 03=>instruction:=rbus;ins<=rbus;
									rom<='0';ram<='0';
									beat_signal<="00";
									state<=EXEC;
						when others=>beat_signal<="00";state<=EXEC;
					end case;
				when EXEC=>
					if(instruction(7)='1')then																	-->mov ix,@i7<
						case beat is
							when 00=>beat_signal<="01";rix<='1';wbus<='0'&instruction(6 downto 0);
							when 01=>rix<='0';state<=OVER;beat_signal<="00";wbus<="ZZZZZZZZ";
							when others=>state<=OVER;beat_signal<="00";wbus<="ZZZZZZZZ";
						end case;
					elsif(instruction(7 downto 8-2)="01")then												-->mov @r,@r<
						case beat is
							when 00=>beat_signal<="01";
								case instruction(2 downto 0) is
									when"000"=>wax<='1';
									when"001"=>wpx<='1';
									when"010"=>wds<='1';
									when"011"=>wdx<='1';
									when"100"=>wcs<='1';
									when"101"=>wip<='1';
									when"110"=>wsi<='1';
									when"111"=>wix<='1';
								end case;
							when 01=>
								case instruction(5 downto 3) is
									when"000"=>rax<='1';
									when"001"=>rpx<='1';
									when"010"=>rds<='1';
									when"011"=>rdx<='1';
									when"100"=>rcs<='1';
									when"101"=>rip<='1';
									when"110"=>rsi<='1';
									when"111"=>rix<='1';
								end case;
								case instruction(2 downto 0) is
									when"000"=>wax<='0';
									when"001"=>wpx<='0';
									when"010"=>wds<='0';
									when"011"=>wdx<='0';
									when"100"=>wcs<='0';
									when"101"=>wip<='0';
									when"110"=>wsi<='0';
									when"111"=>wix<='0';
								end case;
								state<=OVER;
								beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00100000")then														-->jmp cs:px<
						case beat is
							when 00=>beat_signal<="01";wpx<='1';
							when 01=>rip<='1';jmp_flag<='1';
								state<=OVER;
								beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00100001")then														-->jmp ax:px<
						case beat is
							when 00=>beat_signal<="01";wax<='1';
							when 01=>rcs<='1';
							when 02=>wax<='0';rcs<='0';wpx<='1';
							when 03=>rip<='1';jmp_flag<='1';
								state<=OVER;
								beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00100010")then														-->jc cs:px<
						case beat is
							when 00=>beat_signal<="01";
								if(fcf='0')then
									state<=OVER;beat_signal<="00";
								else
									wpx<='1';
								end if;
							when 01=>rip<='1';jmp_flag<='1';
								state<=OVER;
								beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00100011")then														-->stos<
						case beat is
							when 00=>beat_signal<="01";wds<='1';
							when 01=>ds:=rbus;wds<='0';wsi<='1';
							when 02=>si:=rbus;wsi<='0';wdx<='1';
							when 03=>ram<='1';ramrw<='0';ramL<=ds;ramC<=si;
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00100100")then														-->jz cs:px<
						case beat is
							when 00=>beat_signal<="01";
								if(fzf='0')then
									state<=OVER;beat_signal<="00";
								else
									wpx<='1';
								end if;
							when 01=>rip<='1';jmp_flag<='1';
								state<=OVER;
								beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00100101")then														-->j<
						case beat is
							when 00=>beat_signal<="01";
								stack<='1';push<='0';
							when 01=>rxf<='1';stack<='0';
							when 02=>fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00100110")then														-->js cs:px<
						case beat is
							when 00=>beat_signal<="01";
								if(fsf='0')then
									state<=OVER;beat_signal<="00";
								else
									wpx<='1';
								end if;
							when 01=>rip<='1';jmp_flag<='1';
								state<=OVER;
								beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00100111")then														-->jodd cs:px
						case beat is
							when 00=>beat_signal<="01";
								if(fodd='0')then
									state<=OVER;beat_signal<="00";
								else
									wpx<='1';
								end if;
							when 01=>rip<='1';jmp_flag<='1';
								state<=OVER;
								beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction(7 downto 8-5)="00101")then											-->push @r<
						case beat is
							when 00=>beat_signal<="01";
								case instruction(2 downto 0) is
									when"000"=>wax<='1';
									when"001"=>wpx<='1';
									when"010"=>wds<='1';
									when"011"=>wdx<='1';
									when"100"=>wcs<='1';
									when"101"=>wip<='1';
									when"110"=>wsi<='1';
									when"111"=>wix<='1';
								end case;
							when 01=>stack<='1';push<='1';
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction(7 downto 8-5)="00110")then											-->pop @r<
						case beat is
							when 00=>beat_signal<="01";
								stack<='1';push<='0';
							when 01=>
								stack<='0';push<='0';
								case instruction(2 downto 0) is
									when"000"=>rax<='1';
									when"001"=>rpx<='1';
									when"010"=>rds<='1';
									when"011"=>rdx<='1';
									when"100"=>rcs<='1';
									when"101"=>rip<='1';
									when"110"=>rsi<='1';
									when"111"=>rix<='1';
								end case;
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction(7 downto 8-5)="00111")then											-->inc @r<
						case beat is
							when 00=>beat_signal<="01";
								case instruction(2 downto 0) is
									when"000"=>wax<='1';
									when"001"=>wpx<='1';
									when"010"=>wds<='1';
									when"011"=>wdx<='1';
									when"100"=>wcs<='1';
									when"101"=>wip<='1';
									when"110"=>wsi<='1';
									when"111"=>wix<='1';
								end case;
							when 01=>rxf<='1';s<="0000";
							when 02=>rxf<='0';
								case instruction(2 downto 0) is
									when"000"=>wax<='0';
									when"001"=>wpx<='0';
									when"010"=>wds<='0';
									when"011"=>wdx<='0';
									when"100"=>wcs<='0';
									when"101"=>wip<='0';
									when"110"=>wsi<='0';
									when"111"=>wix<='0';
								end case;
								wxs<='1';
                     when 03=>fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;
								case instruction(2 downto 0) is
									when"000"=>rax<='1';
									when"001"=>rpx<='1';
									when"010"=>rds<='1';
									when"011"=>rdx<='1';
									when"100"=>rcs<='1';
									when"101"=>rip<='1';
									when"110"=>rsi<='1';
									when"111"=>rix<='1';
								end case;
							when 04=>
								state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction(7 downto 8-5)="00011")then											-->dec @r<
						case beat is
							when 00=>beat_signal<="01";
								case instruction(2 downto 0) is
									when"000"=>wax<='1';
									when"001"=>wpx<='1';
									when"010"=>wds<='1';
									when"011"=>wdx<='1';
									when"100"=>wcs<='1';
									when"101"=>wip<='1';
									when"110"=>wsi<='1';
									when"111"=>wix<='1';
								end case;
							when 01=>rxf<='1';s<="0001";
							when 02=>rxf<='0';
								case instruction(2 downto 0) is
									when"000"=>wax<='0';
									when"001"=>wpx<='0';
									when"010"=>wds<='0';
									when"011"=>wdx<='0';
									when"100"=>wcs<='0';
									when"101"=>wip<='0';
									when"110"=>wsi<='0';
									when"111"=>wix<='0';
								end case;
								wxs<='1';
                     when 03=>fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;
								case instruction(2 downto 0) is
									when"000"=>rax<='1';
									when"001"=>rpx<='1';
									when"010"=>rds<='1';
									when"011"=>rdx<='1';
									when"100"=>rcs<='1';
									when"101"=>rip<='1';
									when"110"=>rsi<='1';
									when"111"=>rix<='1';
								end case;
							when 04=>
								state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction(7 downto 8-5)="00010")then											-->out @o<
						case beat is
							when 00=>beat_signal<="01";wdx<='1';
							when 01=>
							if(instruction(2 downto 0)="110")then
								led<=rbus(2 downto 0);
							elsif(instruction(2 downto 0)="111")then
								buzzer<=not buzzer;
							else
								if(instruction(0)='0')then
									num<=rbus(3 downto 0);
								else
									num<=rbus(7 downto 4);end if;
									id<=conv_integer(instruction(2 downto 0));
							end if;
							when 02=>
								state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00001111")then														-->xor ax,px<
						case beat is
							when 00=>beat_signal<="01";wax<='1';s<="1000";
							when 01=>rxf<='1';
							when 02=>rxf<='0';wax<='0';wpx<='1';
							when 03=>rxs<='1';
							when 04=>rxs<='0';wpx<='0';wxs<='1';fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;
							when 05=>rax<='1';
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00001110")then														-->mode<
						wbus<="00000000";rcs<='1';rip<='1';rommode<=not rommode;jmp_flag<='1';state<=OVER;beat_signal<="00";
					elsif(instruction="00001101")then														-->shl ax,1<
						case beat is
							when 00=>beat_signal<="01";wax<='1';s<="1010";
							when 01=>rxf<='1';
							when 02=>rxf<='0';wax<='0';wxs<='1';
							when 03=>fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;rax<='1';
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00001100")then														-->or ax,px<
						case beat is
							when 00=>beat_signal<="01";wax<='1';s<="0011";
							when 01=>rxf<='1';
							when 02=>rxf<='0';wax<='0';wpx<='1';
							when 03=>rxs<='1';
							when 04=>rxs<='0';wpx<='0';wxs<='1';fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;
							when 05=>rax<='1';
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00001011")then														-->lods<
						case beat is
							when 00=>beat_signal<="01";wds<='1';
							when 01=>ds:=rbus;wds<='0';wsi<='1';
							when 02=>si:=rbus;wsi<='0';
							when 03=>ram<='1';ramrw<='1';ramL<=ds;ramC<=si;
							when 04=>rdx<='1';ram<='0';
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00001010")then														-->shr ax,1<
						case beat is
							when 00=>beat_signal<="01";wax<='1';s<="1011";
							when 01=>rxf<='1';
							when 02=>rxf<='0';wax<='0';wxs<='1';
							when 03=>fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;rax<='1';
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00001001")then														-->wait<
						if(key0/=last0 or key_pressed=0)then
							jmp_flag<='0';
							last0:=key0;
							key_pressed:=0;
							case beat is
								when 00=>beat_signal<="01";
											wsx<='1';s<="1000";
								when 01=>rxf<='1';
								when 02=>rxf<='0';wsx<='0';wbus<="00000001";rxs<='1';
								when 03=>rxs<='0';wxs<='1';fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;wbus<="ZZZZZZZZ";
								when 04=>rsx<='1';
								state<=OVER;beat_signal<="00";
								key_pressed:=4;
								when others=>state<=OVER;beat_signal<="00";
							end case;
						elsif(key1/=last1 or key_pressed=1)then
							jmp_flag<='0';
							last1:=key1;
							key_pressed:=1;
							case beat is
								when 00=>beat_signal<="01";
											wsx<='1';s<="1000";
								when 01=>rxf<='1';
								when 02=>rxf<='0';wsx<='0';wbus<="00000010";rxs<='1';
								when 03=>rxs<='0';wxs<='1';fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;wbus<="ZZZZZZZZ";
								when 04=>rsx<='1';
								state<=OVER;beat_signal<="00";
								key_pressed:=4;
								when others=>state<=OVER;beat_signal<="00";
							end case;
						elsif(key2/=last2 or key_pressed=2)then
							jmp_flag<='0';
							last2:=key2;
							key_pressed:=2;
							case beat is
								when 00=>beat_signal<="01";
											wsx<='1';s<="1000";
								when 01=>rxf<='1';
								when 02=>rxf<='0';wsx<='0';wbus<="00000100";rxs<='1';
								when 03=>rxs<='0';wxs<='1';fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;wbus<="ZZZZZZZZ";
								when 04=>rsx<='1';
								state<=OVER;beat_signal<="00";
								key_pressed:=4;
								when others=>state<=OVER;beat_signal<="00";
							end case;
						elsif(key3/=last3 or key_pressed=3)then
							jmp_flag<='0';
							last3:=key3;
							key_pressed:=3;
							case beat is
								when 00=>beat_signal<="01";
											wsx<='1';s<="1000";
								when 01=>rxf<='1';
								when 02=>rxf<='0';wsx<='0';wbus<="00001000";rxs<='1';
								when 03=>rxs<='0';wxs<='1';fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;wbus<="ZZZZZZZZ";
								when 04=>rsx<='1';
								state<=OVER;beat_signal<="00";
								key_pressed:=4;
								when others=>state<=OVER;beat_signal<="00";
							end case;
						else
							jmp_flag<='1';
							key_pressed:=4;
						end if;
					elsif(instruction="00001000")then														-->and ax,px<
						case beat is
							when 00=>beat_signal<="01";wax<='1';s<="1001";
							when 01=>rxf<='1';
							when 02=>rxf<='0';wax<='0';wpx<='1';
							when 03=>rxs<='1';
							when 04=>rxs<='0';wpx<='0';wxs<='1';fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;
							when 05=>rax<='1';
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction(7 downto 8-6)="000001")then										-->in ss<
						case beat is
							when 00=>beat_signal<="01";wsx<='1';s<="1001";
							when 01=>rxf<='1';
							when 02=>rxf<='0';wsx<='0';rxs<='1';
							case instruction(1 downto 0) is
								when"00"=>wbus<="00000001";
								when"01"=>wbus<="00000010";
								when"10"=>wbus<="00000100";
								when"11"=>wbus<="00001000";
							end case;
							when 03=>state<=OVER;beat_signal<="00";
										fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00000011")then														-->reset
						rsx<='1';wbus<="11111111";state<=OVER;beat_signal<="00";
					elsif(instruction="00000010")then														-->jz ax:px<
						case beat is
							when 00=>beat_signal<="01";
								if(fzf='0')then
									state<=OVER;beat_signal<="00";
								else
									wax<='1';
								end if;
							when 01=>rcs<='1';
							when 02=>wax<='0';rcs<='0';wpx<='1';
							when 03=>rip<='1';jmp_flag<='1';
								state<=OVER;
								beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00000001")then														-->add ax,px<
						case beat is
							when 00=>beat_signal<="01";wax<='1';s<="0010";
							when 01=>rxf<='1';
							when 02=>rxf<='0';wax<='0';wpx<='1';
							when 03=>rxs<='1';
							when 04=>rxs<='0';wpx<='0';wxs<='1';fcf:=cf;fzf:=zf;fsf:=sf;fodd:=odd;
							when 05=>rax<='1';
							state<=OVER;beat_signal<="00";
							when others=>state<=OVER;beat_signal<="00";
						end case;
					elsif(instruction="00000000")then														-->delay<
						case beat is
							when 00=>beat_signal<="01";
							when 01=>delay<='1';
							when 02=>
							when 03=>
							when 04=>state<=OVER;beat_signal<="00";delay<='0';
							when others=>state<=OVER;beat_signal<="00";
						end case;
					end if;
				when OVER=>
					if(jmp_flag='0')then																			-->process cs,ip
						case beat is
							when 00=>beat_signal<="01";wip<='1';
							wax<='0';wpx<='0';wds<='0';wdx<='0';wcs<='0';         wsi<='0';wix<='0';wxf<='0';wxs<='0';wsx<='0';
							rax<='0';rpx<='0';rds<='0';rdx<='0';rcs<='0';rip<='0';rsi<='0';rix<='0';rxf<='0';rxs<='0';rsx<='0';
							rom<='0';ram<='0';stack<='0';wbus<="ZZZZZZZZ";s<="1111";id<=7;
							when 01=>rxf<='1';s<="0000";
							when 02=>wip<='0';rxf<='0';wxs<='1';
							when 03=>cs_flag:=cf;rip<='1';
										if(cs_flag='0')then
											state<=LOAD;
											beat_signal<="00";
										end if;
							when 04=>rip<='0';wxs<='0';wcs<='1';
							when 05=>rxf<='1';s<="0000";
							when 06=>rxf<='0';wcs<='0';wxs<='1';
                     when 07=>rcs<='1';state<=LOAD;beat_signal<="00";
							when others=>state<=LOAD;beat_signal<="00";
						end case;
					else
						wax<='0';wpx<='0';wds<='0';wdx<='0';wcs<='0';wip<='0';wsi<='0';wix<='0';wxf<='0';wxs<='0';wsx<='0';
						rax<='0';rpx<='0';rds<='0';rdx<='0';rcs<='0';rip<='0';rsi<='0';rix<='0';rxf<='0';rxs<='0';rsx<='0';
						rom<='0';ram<='0';stack<='0';wbus<="ZZZZZZZZ";s<="1111";id<=7;
						state<=LOAD;beat_signal<="00";
					end if;
			end case;
		end if;
	end process;
end;