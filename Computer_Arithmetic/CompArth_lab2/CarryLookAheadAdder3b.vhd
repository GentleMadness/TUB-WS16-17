----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:55 12/03/2016 
-- Design Name: 
-- Module Name:    CarryLookAheadAdder3b - Behavioral 
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

entity CarryLookAheadAdder3b is
    Port ( a : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           ci : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR(2 DOWNTO 0);
           cout : out  STD_LOGIC);
end CarryLookAheadAdder3b;

architecture Behavioral of CarryLookAheadAdder3b is
------First Stage
component CarryGenProp3b is
    Port ( a : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           g : out  STD_LOGIC_VECTOR(2 DOWNTO 0);
           p : out  STD_LOGIC_VECTOR(2 DOWNTO 0));
end component;
------Second Stage
component CarryLookAheadStage3b is
    Port ( g : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           p : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           ci : in  STD_LOGIC;
           co : out  STD_LOGIC_VECTOR(1 DOWNTO 0);
			  co2: out STD_LOGIC);
end component; 
------Third Stage
component SummationStage3b is
    Port ( p : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           c : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			  ci: in  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR(2 DOWNTO 0));
end component;

signal p1: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal g1: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal c1: STD_LOGIC_VECTOR(2 DOWNTO 0);

begin
u0: CarryGenProp3b port map 
	(a(2 DOWNTO 0), b(2 DOWNTO 0), g1(2 DOWNTO 0), p1(2 DOWNTO 0));

u1: CarryLookAheadStage3b port map
	(g1(2 DOWNTO 0), p1(2 DOWNTO 0), ci, c1(1 DOWNTO 0), cout);

u2: SummationStage3b port map
	(p1(2 DOWNTO 0), c1(1 DOWNTO 0), ci, s(2 DOWNTO 0));
end Behavioral;