----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:46:25 11/16/2016 
-- Design Name: 
-- Module Name:    Selector3 - Behavioral 
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

entity Selector3 is
    Port ( c0 : in  STD_LOGIC;
           c1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s0prev : in  STD_LOGIC;
           s1prev : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           sout2 : out  STD_LOGIC;
           sout3 : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end Selector3;

architecture Behavioral of Selector3 is

component Multiplexer2to1 is
    Port ( high : in  STD_LOGIC;
           low : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           z : out  STD_LOGIC);
end component;

begin

u1 : Multiplexer2to1 port map (c1, c0, sel, cout);
u2 : Multiplexer2to1 port map (s1prev, s0prev, sel, sout2);
u3 : Multiplexer2to1 port map (s1, s0, sel , sout3);

end Behavioral;

