----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:35:19 11/13/2016 
-- Design Name: 
-- Module Name:    CarryLook-AheadStage4b - Behavioral 
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

entity CarryLookAheadStage4b is
    Port ( g : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           p : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           ci : in  STD_LOGIC;
           co : out  STD_LOGIC_VECTOR(2 DOWNTO 0);
			  co2: out STD_LOGIC);
end CarryLookAheadStage4b;

architecture Behavioral of CarryLookAheadStage4b is

begin
co(0) <= g(0) or (p(0) and ci);
co(1) <= g(1) or (p(1) and (g(0) or (p(1) and p(0) and ci)));
co(2) <= g(2) or (p(2) and (g(1) or (p(2) and p(1) and (g(0) or (p(2) and p(1) and p(0) and ci)))));
co2   <= g(3) or (p(3) and (g(2) or (p(3) and p(2) and (g(1) or (p(3) and p(2) and p(1) and (g(0) or (p(3) and p(2) and p(1) and p(0) and ci)))))));
--c(n-1) and p(n) is 1, then c(n) is 1, also delay times at testbench are mixing the simulation 
--so always spare some extra time okay!
end Behavioral;

