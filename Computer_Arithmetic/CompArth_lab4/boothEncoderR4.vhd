----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:38:59 01/04/2017 
-- Design Name: 
-- Module Name:    boothEncoderR4 - Behavioral 
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

entity boothEncoderR4 is
    Port ( w : in  STD_LOGIC_VECTOR (2 downto 0);				-- w is the 3 bit window
           sel1 : out  STD_LOGIC;
           sel2 : out  STD_LOGIC;
           s : out  STD_LOGIC);
end boothEncoderR4;

 architecture Behavioral of boothEncoderR4 is

begin
sel1 <= w(0) xor w(1);
sel2 <= (w(0) and w(1) and not w(2)) or (not w(0) and not w(1) and w(2));
s    <= w(2);
end Behavioral;

