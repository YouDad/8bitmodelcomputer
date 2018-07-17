library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rom is
	port(
		clk:in std_logic;
		rom_task:in std_logic;
		lines,cols:in std_logic_vector(7 downto 0);
		data:out std_logic_vector(7 downto 0)
	);
end;

architecture bhv of rom is
type bank is array(0 to 255)of std_logic_vector(7 downto 0);
type banks is array(0 to 4)of bank;
begin
	process(clk)
	constant mem:banks:=((
	"00001001",-->wait<
   "00001001",-->wait<
   "00001001",-->wait<
   "00001001",-->wait<
   "00000011",-->reset<
   "10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01110111",-->mov si,ix<
   "01011111",-->mov dx,ix<
   "00010101",-->out 5<
   "00010100",-->out 4<
   "00010011",-->out 3<
   "00010010",-->out 2<
   "00010001",-->out 1<
   "00010000",-->out 0<
   "00001001",-->wait<
   "00000101",-->in 1<
   "10011111",-->mov ix,31<
   "01001111",-->mov px,ix<
   "00100100",-->jz cs:px<
   "00000110",-->in 2<
   "11010100",-->mov ix,84<
   "01001111",-->mov px,ix<
   "00100100",-->jz cs:px<
   "00000111",-->in 3<
   "11101010",-->mov ix,106<
   "01001111",-->mov px,ix<
   "00100100",-->jz cs:px<
   "10001111",-->mov ix,15<
   "01001111",-->mov px,ix<
   "00100000",-->jmp cs:px<
   "00000110",-->in 2<
   "10000001",-->mov ix,1<
   "01000111",-->mov ax,ix<
   "10000000",-->mov ix,0<
   "01001111",-->mov px,ix<
   "00000010",-->jz ax:px<
   "00000111",-->in 3<
   "11111000",-->mov ix,120<
   "01001111",-->mov px,ix<
   "00100100",-->jz cs:px<
   "00000100",-->in 0<
   "11000000",-->mov ix,64<
   "01001111",-->mov px,ix<
   "00100100",-->jz cs:px<
   "00111010",-->inc ds<
   "01000010",-->mov ax,ds<
   "10001000",-->mov ix,8<
   "01001111",-->mov px,ix<
   "00001000",-->and ax,px<
   "10110111",-->mov ix,55<
   "01001111",-->mov px,ix<
   "00100100",-->jz cs:px<
   "10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01011010",-->mov dx,ds<
   "00010101",-->out 5<
   "00010100",-->out 4<
   "00001011",-->lods<
   "00010001",-->out 1<
   "00010000",-->out 0<
   "10001111",-->mov ix,15<
   "01001111",-->mov px,ix<
   "00100000",-->jmp cs:px<
   "00101010",-->push ds<
   "00100101",-->j<
   "11001000",-->mov ix,72<
   "01001111",-->mov px,ix<
   "00100100",-->jz cs:px<
   "11001010",-->mov ix,74<
   "01001111",-->mov px,ix<
   "00100000",-->jmp cs:px<
   "10001000",-->mov ix,8<
   "01010111",-->mov ds,ix<
   "00011010",-->dec ds<
   "01011010",-->mov dx,ds<
   "00010101",-->out 5<
   "00010100",-->out 4<
   "00001011",-->lods<
   "00010001",-->out 1<
   "00010000",-->out 0<
   "10001111",-->mov ix,15<
   "01001111",-->mov px,ix<
   "00100000",-->jmp cs:px<
   "00000101",-->in 1<
   "10000001",-->mov ix,1<
   "01000111",-->mov ax,ix<
   "10000000",-->mov ix,0<
   "01001111",-->mov px,ix<
   "00000010",-->jz ax:px<
   "00000100",-->in 0<
   "11100000",-->mov ix,96<
   "01001111",-->mov px,ix<
   "00100100",-->jz cs:px<
   "00111110",-->inc si<
   "00111110",-->inc si<
   "00011110",-->dec si<
   "01011110",-->mov dx,si<
   "00010011",-->out 3<
   "00010010",-->out 2<
   "00001011",-->lods<
   "00010001",-->out 1<
   "00010000",-->out 0<
   "10001111",-->mov ix,15<
   "01001111",-->mov px,ix<
   "00100000",-->jmp cs:px<
   "01000011",-->mov ax,dx<
   "00001101",-->shl ax,1<
   "00000100",-->in 0<
   "11110001",-->mov ix,113<
   "01001111",-->mov px,ix<
   "00100100",-->jz cs:px<
   "00111000",-->inc ax<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00010001",-->out 1<
   "00010000",-->out 0<
   "10001111",-->mov ix,15<
   "01001111",-->mov px,ix<
   "00100000",-->jmp cs:px<
   "10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "00011111",-->dec ix<
   "01110111",-->mov si,ix<
   "00001011",-->lods<
   "01000011",-->mov ax,dx<
   "10000111",-->mov ix,7<
   "01001111",-->mov px,ix<
   "00001000",-->and ax,px<
   "10000000",-->mov ix,0<
   "00011111",-->dec ix<
   "00011111",-->dec ix<
   "00011111",-->dec ix<
   "01001111",-->mov px,ix<
   "00100001",-->jmp ax:px<
   "00000000",
   "00000000",
   "00000000",
   "00000000",
	"00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000",
	"10101001",-->mov ix,41<
   "01001111",-->mov px,ix<
   "00100000"-->jmp cs:px<
	),(--1
	"00001110",-->mode<
   "01010000",-->mov ds,ax<
   "10000000",-->mov ix,0<
   "01110111",-->mov si,ix<
   "11111111",-->mov ix,127<
   "00111111",-->inc ix<
   "01001111",-->mov px,ix<
   "10000001",-->mov ix,1<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11011111",-->mov ix,95<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000010",-->mov ix,2<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010101",-->mov ix,21<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010100",-->mov ix,20<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11000011",-->mov ix,67<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11011111",-->mov ix,95<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010011",-->mov ix,19<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010010",-->mov ix,18<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001011",-->mov ix,75<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000001",-->mov ix,1<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11011000",-->mov ix,88<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010001",-->mov ix,17<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010000",-->mov ix,16<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10001110",-->mov ix,14<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01110111",-->mov si,ix<
   "10000001",-->mov ix,1<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11000111",-->mov ix,71<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001111",-->mov ix,79<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10100001",-->mov ix,33<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
	"10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01110111",-->mov si,ix<
   "01011111",-->mov dx,ix<
   "00010101",-->out 5<
   "00010100",-->out 4<
   "00010011",-->out 3<
   "00010010",-->out 2<
   "00010001",-->out 1<
   "00010000",-->out 0<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "10001111",-->mov ix,15<
   "01001111",-->mov px,ix<
   "00100001",-->jmp ax:px<
	"00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000",
	"10000001",-->mov ix,1<
   "01001111",-->mov px,ix<
   "00100000"-->jmp cs:px<
	),(--2
	"01010000",-->mov ds,ax<
   "10000000",-->mov ix,0<
   "01110111",-->mov si,ix<
   "11111111",-->mov ix,127<
   "00111111",-->inc ix<
   "01001111",-->mov px,ix<
   "10000001",-->mov ix,1<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11011111",-->mov ix,95<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010101",-->mov ix,21<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010100",-->mov ix,20<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11000011",-->mov ix,67<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11011111",-->mov ix,95<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010011",-->mov ix,19<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010010",-->mov ix,18<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10111000",-->mov ix,56<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11011000",-->mov ix,88<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010001",-->mov ix,17<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010000",-->mov ix,16<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01110111",-->mov si,ix<
   "10000010",-->mov ix,2<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11000111",-->mov ix,71<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001111",-->mov ix,79<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10100001",-->mov ix,33<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
	"10001110",-->mov ix,14<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
	"10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01110111",-->mov si,ix<
   "01011111",-->mov dx,ix<
   "00010101",-->out 5<
   "00010100",-->out 4<
   "00010011",-->out 3<
   "00010010",-->out 2<
   "00010001",-->out 1<
   "00010000",-->out 0<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "10001111",-->mov ix,15<
   "01001111",-->mov px,ix<
   "00100001",-->jmp ax:px<
	"00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000",
	"10000000",-->mov ix,0<
   "01001111",-->mov px,ix<
   "00100000"-->jmp cs:px<
	),(--3
	"01010000",-->mov ds,ax<
   "10000000",-->mov ix,0<
   "01110111",-->mov si,ix<
   "11111111",-->mov ix,127<
   "00111111",-->inc ix<
   "01001111",-->mov px,ix<
   "11111111",-->mov ix,127<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11000111",-->mov ix,71<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10001101",-->mov ix,13<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10001101",-->mov ix,13<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10001101",-->mov ix,13<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001000",-->mov ix,72<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000100",-->mov ix,4<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11000111",-->mov ix,71<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000001",-->mov ix,1<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11011000",-->mov ix,88<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010110",-->mov ix,22<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10011011",-->mov ix,27<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10011011",-->mov ix,27<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010110",-->mov ix,22<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10011011",-->mov ix,27<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010110",-->mov ix,22<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10011011",-->mov ix,27<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010110",-->mov ix,22<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10001110",-->mov ix,14<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01110111",-->mov si,ix<
   "10000011",-->mov ix,3<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11000111",-->mov ix,71<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "01011001",-->mov dx,px<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001111",-->mov ix,79<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10100001",-->mov ix,33<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01110111",-->mov si,ix<
   "01011111",-->mov dx,ix<
   "00010101",-->out 5<
   "00010100",-->out 4<
   "00010011",-->out 3<
   "00010010",-->out 2<
   "00010001",-->out 1<
   "00010000",-->out 0<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "10001111",-->mov ix,15<
   "01001111",-->mov px,ix<
   "00100001",-->jmp ax:px<
	"00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000",
	"10000000",-->mov ix,0<
   "01001111",-->mov px,ix<
   "00100000"-->jmp cs:px<
	),(--4
	"01010000",-->mov ds,ax<
   "10000000",-->mov ix,0<
   "01110111",-->mov si,ix<
   "11111111",-->mov ix,127<
   "00111111",-->inc ix<
   "01001111",-->mov px,ix<
   "10100000",-->mov ix,32<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11000111",-->mov ix,71<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11011111",-->mov ix,95<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10011011",-->mov ix,27<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010111",-->mov ix,23<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10111000",-->mov ix,56<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10111100",-->mov ix,60<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001111",-->mov ix,79<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10001111",-->mov ix,15<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010100",-->mov ix,20<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001111",-->mov ix,79<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10100100",-->mov ix,36<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10111100",-->mov ix,60<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001111",-->mov ix,79<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10001111",-->mov ix,15<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000110",-->mov ix,6<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001111",-->mov ix,79<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10100000",-->mov ix,32<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10010111",-->mov ix,23<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10001110",-->mov ix,14<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01110111",-->mov si,ix<
   "10000100",-->mov ix,4<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11000111",-->mov ix,71<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "00000001",-->add ax,px<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "11001111",-->mov ix,79<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
   "10100001",-->mov ix,33<
   "01000111",-->mov ax,ix<
   "01011000",-->mov dx,ax<
   "00100011",-->stos<
   "00111110",-->inc si<
	"10000000",-->mov ix,0<
   "01010111",-->mov ds,ix<
   "01110111",-->mov si,ix<
   "01011111",-->mov dx,ix<
   "00010101",-->out 5<
   "00010100",-->out 4<
   "00010011",-->out 3<
   "00010010",-->out 2<
   "00010001",-->out 1<
   "00010000",-->out 0<
   "10000000",-->mov ix,0<
   "01000111",-->mov ax,ix<
   "10001111",-->mov ix,15<
   "01001111",-->mov px,ix<
   "00100001",-->jmp ax:px<
	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",	"00000000",
	"10000000",-->mov ix,0<
   "01001111",-->mov px,ix<
   "00100000"-->jmp cs:px<
	));
	begin
		if(falling_edge(clk))then
			if(rom_task='1')then
				data<=mem(conv_integer(lines))(conv_integer(cols));
			else
				data<=(others=>'Z');
			end if;
		end if;
	end process;
end;