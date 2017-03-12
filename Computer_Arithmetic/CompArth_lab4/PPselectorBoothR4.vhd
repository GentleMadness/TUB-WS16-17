----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:55:30 01/04/2017 
-- Design Name: 
-- Module Name:    PPselectorBoothR4 - Behavioral 
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

entity PPselectorBoothR4 is
    Port ( b  : in  STD_LOGIC_VECTOR (15 downto 0);
			  ss : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s2 : in  STD_LOGIC;
			  ssd: out STD_LOGIC;
           p  : out STD_LOGIC_VECTOR (16 downto 0));
end PPselectorBoothR4;

architecture Behavioral of PPselectorBoothR4 is
begin

p(0)  <= ss xor ( ( b(0)  and s1 ) );
p(1)  <= ss xor ( ( b(0)  and s2 ) or ( b(1)  and s1 ) );
p(2)  <= ss xor ( ( b(1)  and s2 ) or ( b(2)  and s1 ) );
p(3)  <= ss xor ( ( b(2)  and s2 ) or ( b(3)  and s1 ) );
p(4)  <= ss xor ( ( b(3)  and s2 ) or ( b(4)  and s1 ) );
p(5)  <= ss xor ( ( b(4)  and s2 ) or ( b(5)  and s1 ) );
p(6)  <= ss xor ( ( b(5)  and s2 ) or ( b(6)  and s1 ) );
p(7)  <= ss xor ( ( b(6)  and s2 ) or ( b(7)  and s1 ) );
p(8)  <= ss xor ( ( b(7)  and s2 ) or ( b(8)  and s1 ) );
p(9)  <= ss xor ( ( b(8)  and s2 ) or ( b(9)  and s1 ) );
p(10) <= ss xor ( ( b(9)  and s2 ) or ( b(10) and s1 ) );
p(11) <= ss xor ( ( b(10) and s2 ) or ( b(11) and s1 ) );
p(12) <= ss xor ( ( b(11) and s2 ) or ( b(12) and s1 ) );
p(13) <= ss xor ( ( b(12) and s2 ) or ( b(13) and s1 ) );
p(14) <= ss xor ( ( b(13) and s2 ) or ( b(14) and s1 ) );
p(15) <= ss xor ( ( b(14) and s2 ) or ( b(15) and s1 ) ); 
--- here the last part should be ( b(16) and s1 ), but b is only 16 bits.
--b(15) is the sign bit of b, so even if we extend b to 16 bit mannually, 
--b(16) is the same as b(15). So we simply use b(15) instead.
p(16) <= ss xor ( ( b(15) and s2 ) or ( b(15) and s1 ) );
ssd   <= ss;

end Behavioral;