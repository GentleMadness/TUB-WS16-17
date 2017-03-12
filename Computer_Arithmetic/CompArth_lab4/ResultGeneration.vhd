library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ResultGeneration is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c0 : out  STD_LOGIC;
           s0 : out  STD_LOGIC;
           c1 : out  STD_LOGIC;
           s1 : out  STD_LOGIC);
end ResultGeneration;

architecture Behavioral of ResultGeneration is

begin
	c0 <= a and b;
	s0 <= a xor b;
	c1 <= a or b;
	s1 <= a xnor b;
end Behavioral;