library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer2to1 is
    Port ( high : in  STD_LOGIC;
           low : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           z : out  STD_LOGIC);
end Multiplexer2to1;

architecture Behavioral of Multiplexer2to1 is

begin
	z <= ((not sel) and low) or (sel and high);
end Behavioral;

