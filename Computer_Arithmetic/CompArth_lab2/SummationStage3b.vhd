----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:10:05 12/03/2016 
-- Design Name: 
-- Module Name:    SummationStage3b - Behavioral 
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

entity SummationStage3b is
    Port ( p : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           c : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			  ci: in  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR(2 DOWNTO 0));
end SummationStage3b;

architecture Behavioral of SummationStage3b is

begin

sum(0) <= p(0) xor ci; 
sum(1) <= p(1) xor c(0);
sum(2) <= p(2) xor c(1);

end Behavioral;



