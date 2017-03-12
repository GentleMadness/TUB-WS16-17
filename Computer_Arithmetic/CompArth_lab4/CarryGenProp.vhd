----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:02:37 11/13/2016 
-- Design Name: 
-- Module Name:    CarryGenProp4b - Behavioral 
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

entity CarryGenProp is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           g : out  STD_LOGIC;	--g stands for Generate and is same as Carry
           p : out  STD_LOGIC);--p stands for Propagate and is same as Sum
end CarryGenProp;

architecture Behavioral of CarryGenProp is

begin

g <= a and b; --In the case of binary addition, A + B generates if and only if both A and B are 1.
p <= a xor b; --only different of xor and or is in the 1 1 input situation, and since generate is 1 in that situation
              -- c_i = G0+p0*c_i-1 p0 becomes irrelevant and we even dont have to generate it in the 1 1 case
-- For binary arithmetic, or is faster than xor and takes fewer transistors to implement. 
-- However, for a multiple-level carry lookahead adder, it is simpler to use xor.

end Behavioral;

