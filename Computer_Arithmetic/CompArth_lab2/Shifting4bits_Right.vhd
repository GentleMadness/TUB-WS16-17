----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:28:44 12/17/2016 
-- Design Name: 
-- Module Name:    Shifting4bits_Right - Behavioral 
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

entity Shifting4bits_Right is
    Port ( CSA_sum : in  STD_LOGIC_VECTOR (14 downto 0);
           Final_Res : out  STD_LOGIC_VECTOR (10 downto 0));
end Shifting4bits_Right;

architecture Behavioral of Shifting4bits_Right is

begin
	Final_Res <= CSA_sum (14 downto 4);

end Behavioral; 

