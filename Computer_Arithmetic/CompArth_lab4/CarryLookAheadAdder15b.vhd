----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:26:41 12/03/2016 
-- Design Name: 
-- Module Name:    CarryLookAheadAdder16bit - Behavioral 
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

entity CarryLookAheadAdder32b is
    Port ( a : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           ci : in  STD_LOGIC;
           --C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(31 DOWNTO 0));
end CarryLookAheadAdder32b;

architecture Behavioral of CarryLookAheadAdder32b is

component CarryLookAheadAdder8b is
    Port ( a : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           ci : in  STD_LOGIC;
           C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;  

signal carry1, carry2, carry3, carry4: STD_LOGIC;  

begin 
u1: CarryLookAheadAdder8b port map 
	(a(7 DOWNTO 0), b(7 DOWNTO 0), ci, carry1, S(7 DOWNTO 0));
	
u2: CarryLookAheadAdder8b port map 
	(a(15 DOWNTO 8), b(15 DOWNTO 8),carry1, carry2, S(15 DOWNTO 8));

u3: CarryLookAheadAdder8b port map 
	(a(23 DOWNTO 16), b(23 DOWNTO 16),carry2, carry3, S(23 DOWNTO 16));

u4: CarryLookAheadAdder8b port map 
	(a(31 DOWNTO 24), b(31 DOWNTO 24),carry3, carry4, S(31 DOWNTO 24));

end Behavioral;

