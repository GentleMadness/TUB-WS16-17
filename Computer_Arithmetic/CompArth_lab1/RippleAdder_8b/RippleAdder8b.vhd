----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:35:44 11/08/2016 
-- Design Name: 
-- Module Name:    lab102 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--
--entity FullAdder is
--	Port( a : in  STD_LOGIC;
--	    b : in  STD_LOGIC;
--		 c : in  STD_LOGIC;
--		 s : out  STD_LOGIC;
--		 co : out  STD_LOGIC);
--end FullAdder;
--
--architecture Behavioral of FullAdder is
--
--begin
--	s <= a xor b xor c;
--	co <= (a and b) or ((a xor b) and c);
--end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleAdder8b is
	Port( a : in  STD_LOGIC_VECTOR(7 downto 0);
	    b : in  STD_LOGIC_VECTOR(7 downto 0);
		 c : in  STD_LOGIC;
    	 s : out  STD_LOGIC_VECTOR(7 downto 0);
		 co: out  STD_LOGIC);
end RippleAdder8b;

architecture Behavioral of RippleAdder8b is

component FullAdder is

	Port( a : in  STD_LOGIC;
			 b : in  STD_LOGIC;
			 c : in  STD_LOGIC;
			 s : out  STD_LOGIC;
			 co : out  STD_LOGIC);
end component;

signal ci : std_logic_vector (6 downto 0);

begin
u1 : FullAdder port map (a(0),b(0),c,s(0),ci(0));
u2 : FullAdder port map (a(1),b(1),ci(0),s(1),ci(1));
u3 : FullAdder port map (a(2),b(2),ci(1),s(2),ci(2));
u4 : FullAdder port map (a(3),b(3),ci(2),s(3),ci(3));
u5 : FullAdder port map (a(4),b(4),ci(3),s(4),ci(4));
u6 : FullAdder port map (a(5),b(5),ci(4),s(5),ci(5));
u7 : FullAdder port map (a(6),b(6),ci(5),s(6),ci(6));
u8 : FullAdder port map (a(7),b(7),ci(6),s(7),co);

end Behavioral;