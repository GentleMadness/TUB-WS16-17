----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:06:02 12/03/2016 
-- Design Name: 
-- Module Name:    CarryGenPro3b - Behavioral 
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
entity CarryGenProp3b is
    Port ( a : in  STD_LOGIC_VECTOR (2 downto 0);
           b : in  STD_LOGIC_VECTOR (2 downto 0);
           g : out  STD_LOGIC_VECTOR (2 downto 0);
           p : out  STD_LOGIC_VECTOR (2 downto 0));
end CarryGenProp3b;

architecture Behavioral of CarryGenProp3b is

component CarryGenProp is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           g : out  STD_LOGIC;	--g stands for Generate and is same as Carry
           p : out  STD_LOGIC);  --p stands for Propagate and is same as Sum
end component;

begin

u1: CarryGenProp port map
		(a(0), b(0), g(0), p(0));
u2: CarryGenProp port map
		(a(1), b(1), g(1), p(1));
u3: CarryGenProp port map
		(a(2), b(2), g(2), p(2));
end Behavioral;

