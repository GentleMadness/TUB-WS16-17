----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:04:56 12/03/2016 
-- Design Name: 
-- Module Name:    SignExtension - Behavioral 
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

entity Sign_Extension is
    Port ( sin : in  STD_LOGIC_VECTOR (10 downto 0);
           sout : out  STD_LOGIC_VECTOR (14 downto 0));
end Sign_Extension;

architecture Behavioral of Sign_Extension is

signal s : std_logic;
signal sign : std_logic_vector (3 downto 0);
 
begin 
s <= sin(10);
sign <= s&s&s&s;
sout <= sign & sin; 
end Behavioral;

