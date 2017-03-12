----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:05:38 11/16/2016 
-- Design Name: 
-- Module Name:    Selector5 - Behavioral 
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

entity Selector5 is
    Port ( c0 : in  STD_LOGIC;
           c1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s06 : in  STD_LOGIC;
           s16 : in  STD_LOGIC;
           s05 : in  STD_LOGIC;
           s15 : in  STD_LOGIC;
           s04 : in  STD_LOGIC;
           s14 : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           sout7 : out  STD_LOGIC;
           sout6 : out  STD_LOGIC;
           sout5 : out  STD_LOGIC;
           sout4 : out  STD_LOGIC);
end Selector5;

architecture Behavioral of Selector5 is

component Multiplexer2to1 is
    Port ( high : in  STD_LOGIC;
           low : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           z : out  STD_LOGIC);
end component;

begin

u1: Multiplexer2to1 port map (c1, c0, sel, cout);
u2: Multiplexer2to1 port map (s1, s0, sel, sout7);
u3: Multiplexer2to1 port map (s16, s06, sel, sout6);
u4: Multiplexer2to1 port map (s15, s05, sel, sout5);
u5: Multiplexer2to1 port map (s14, s04, sel, sout4);

end Behavioral;
