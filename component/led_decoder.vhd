library ieee;
use ieee.std_logic_1164.all;
entity led_decoder is
	port(
		src:in std_logic_vector(3 downto 0);
		dest:out std_logic_vector(0 to 7)
	);
end;
architecture decode of led_decoder is begin
	process(src)begin
		case src is
			when"0000"=>dest<="00000011";
			when"0001"=>dest<="10011111";
			when"0010"=>dest<="00100101";
			when"0011"=>dest<="00001101";
			when"0100"=>dest<="10011001";
			when"0101"=>dest<="01001001";
			when"0110"=>dest<="01000001";
			when"0111"=>dest<="00011111";
			when"1000"=>dest<="00000001";
			when"1001"=>dest<="00001001";
			when"1010"=>dest<="00010001";
			when"1011"=>dest<="11000001";
			when"1100"=>dest<="01100011";
			when"1101"=>dest<="10000101";
			when"1110"=>dest<="01100001";
			when"1111"=>dest<="01110001";
		end case;
	end process;
end;