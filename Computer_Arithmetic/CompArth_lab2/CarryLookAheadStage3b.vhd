----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:08:06 12/03/2016 
-- Design Name: 
-- Module Name:    CarryLookAheadStage3b - Behavioral 
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

entity CarryLookAheadStage3b is
    Port ( g : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           p : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           ci : in  STD_LOGIC;
           co : out  STD_LOGIC_VECTOR(1 DOWNTO 0);
			  co2: out STD_LOGIC);
end CarryLookAheadStage3b;

architecture Behavioral of CarryLookAheadStage3b is

begin
co(0) <= g(0) or (p(0) and ci);
co(1) <= g(1) or (p(1) and (g(0) or (p(1) and p(0) and ci)));
co2   <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and ci);
end Behavioral;
