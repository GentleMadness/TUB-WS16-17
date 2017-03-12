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

entity CarryLookAheadAdder15b is
    Port ( a : in  STD_LOGIC_VECTOR(14 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(14 DOWNTO 0);
           ci : in  STD_LOGIC;
           C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(14 DOWNTO 0));
end CarryLookAheadAdder15b;

architecture Behavioral of CarryLookAheadAdder15b is

component CarryLookAheadAdder8b is
    Port ( a : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           ci : in  STD_LOGIC;
           C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;  

component CarryLookAheadAdder4b is
    Port ( a : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           ci : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR(3 DOWNTO 0);
           cout : out  STD_LOGIC);
end component;

component CarryLookAheadAdder3b is
    Port ( a : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           ci : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR(2 DOWNTO 0);
           cout : out  STD_LOGIC);
end component;

signal carry, carry2: STD_LOGIC;  

begin 
u1: CarryLookAheadAdder8b port map 
	(a(7 DOWNTO 0), b(7 DOWNTO 0),ci,carry, S(7 DOWNTO 0));
	
u2: CarryLookAheadAdder4b port map 
	(a(11 DOWNTO 8), b(11 DOWNTO 8), carry, S(11 DOWNTO 8), carry2);

u3: CarryLookAheadAdder3b port map 
	(a(14 DOWNTO 12), b(14 DOWNTO 12), carry2, S(14 DOWNTO 12),C);
end Behavioral;

