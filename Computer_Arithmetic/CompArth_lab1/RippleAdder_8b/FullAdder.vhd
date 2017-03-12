library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
	Port ( a : in  STD_LOGIC;
		b : in  STD_LOGIC;
		c : in  STD_LOGIC;
		s : out  STD_LOGIC;
		co : out  STD_LOGIC);
end FullAdder;

architecture Behavioral of FullAdder is

begin
		s <= a xor b xor c;
		co <= (a and b) or ((a xor b) and c);
end Behavioral;
