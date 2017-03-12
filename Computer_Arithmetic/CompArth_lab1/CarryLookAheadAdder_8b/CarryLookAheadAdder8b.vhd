----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:36:20 11/16/2016 
-- Design Name: 
-- Module Name:    CarryLookaheadAdder8b - Behavioral 
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

entity CarryLookaheadAdder8b is
    Port ( a : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           ci : in  STD_LOGIC;
           C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(7 DOWNTO 0));
end CarryLookaheadAdder8b;

architecture Behavioral of CarryLookaheadAdder8b is

component CarryLookAheadAdder4b is
    Port ( a : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           ci : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR(3 DOWNTO 0);
           cout : out  STD_LOGIC);
end component;

signal carry: STD_LOGIC;

begin
u1: CarryLookAheadAdder4b port map 
	(a(3 DOWNTO 0), b(3 DOWNTO 0),ci,S(3 DOWNTO 0),carry);
	
u2: CarryLookAheadAdder4b port map 
	(a(7 DOWNTO 4), b(7 DOWNTO 4),carry,S(7 DOWNTO 4),C);

end Behavioral;

