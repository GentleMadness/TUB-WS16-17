----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:14:34 01/04/2017 
-- Design Name: 
-- Module Name:    PPgenBoothR4 - Behavioral 
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
use IEEE.STD_LOGIC_signed.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PPgenBoothR4 is
    Port ( a    : in  STD_LOGIC_VECTOR (15 downto 0);--multiplicand
			  w    : in  STD_LOGIC_VECTOR (2 downto 0);-- booth bits group
           pp   : out  STD_LOGIC_VECTOR (16 downto 0) -- partial product
           --sig  : out  STD_LOGIC
			 );
end PPgenBoothR4;


architecture Behavioral of PPgenBoothR4 is

	component boothEncoderR4 is
		 Port ( w : in  STD_LOGIC_VECTOR (2 downto 0);				-- w is the 3 bit window
				  sel1 : out  STD_LOGIC;
              sel2 : out  STD_LOGIC;
              s : out  STD_LOGIC);
	end component;
		
	component PPselectorBoothR4 is
		 Port ( b  : in  STD_LOGIC_VECTOR (15 downto 0);
				  ss : in  STD_LOGIC;
				  s1 : in  STD_LOGIC;
				  s2 : in  STD_LOGIC;
				  ssd: out STD_LOGIC;
				  p  : out STD_LOGIC_VECTOR (16 downto 0));
	end component;

signal select1	:	STD_LOGIC;
signal select2 :	STD_LOGIC;
signal sign,ssd		:	STD_LOGIC; --ssd is kinda redundant here. It could be removed.
signal par,p_raw:  STD_LOGIC_VECTOR (16 downto 0);

begin
En  : boothEncoderR4 	port map ( w, select1, select2, sign );
pro : PPselectorBoothR4	port map ( a(15 downto 0), sign, select1, select2, ssd,p_raw(16 downto 0) );
-- sign needs to be added to the pp if the bits group sign is negative
-- it would be too troublesome to implement a 17 or 16bit adder here only to add the sign number
-- so we simply use the '+' operator in VHDL, which is allowed in this assignment.
-- library 'IEEE.STD_LOGIC_signed.ALL' needs to be added at the beginning of this file.
par <= p_raw + sign;  
pp <= par;
end Behavioral;

