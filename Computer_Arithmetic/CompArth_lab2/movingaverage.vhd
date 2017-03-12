----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:14:46 12/17/2016 
-- Design Name: 
-- Module Name:    movingaverage - Behavioral 
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
 
entity movingaverage is 
    Port ( sin : in  STD_LOGIC_VECTOR (10 downto 0);
           clk : in  STD_LOGIC;
           sout : out  STD_LOGIC_VECTOR (10 downto 0);
           rst : in  STD_LOGIC);
end movingaverage; 

architecture Behavioral of movingaverage is
 
component reg16 is
    Port ( clk : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (10 downto 0);
           q0 : out  STD_LOGIC_VECTOR (10 downto 0);
           q1 : out  STD_LOGIC_VECTOR (10 downto 0);
           q2 : out  STD_LOGIC_VECTOR (10 downto 0);
           q3 : out  STD_LOGIC_VECTOR (10 downto 0);
           q4 : out  STD_LOGIC_VECTOR (10 downto 0);
           q5 : out  STD_LOGIC_VECTOR (10 downto 0);
           q6 : out  STD_LOGIC_VECTOR (10 downto 0);
           q7 : out  STD_LOGIC_VECTOR (10 downto 0);
           q8 : out  STD_LOGIC_VECTOR (10 downto 0);
           q9 : out  STD_LOGIC_VECTOR (10 downto 0); 
           q10 : out  STD_LOGIC_VECTOR (10 downto 0);
           q11 : out  STD_LOGIC_VECTOR (10 downto 0);
           q12 : out  STD_LOGIC_VECTOR (10 downto 0);
           q13 : out  STD_LOGIC_VECTOR (10 downto 0);
           q14 : out  STD_LOGIC_VECTOR (10 downto 0);
           q15 : out  STD_LOGIC_VECTOR (10 downto 0);
           rst : in  STD_LOGIC); 
end component;

component CSA_16_Input is
    Port ( s0 : in  STD_LOGIC_VECTOR (10 downto 0);
           s1 : in  STD_LOGIC_VECTOR (10 downto 0);
           s2 : in  STD_LOGIC_VECTOR (10 downto 0);
           s3 : in  STD_LOGIC_VECTOR (10 downto 0);
           s4 : in  STD_LOGIC_VECTOR (10 downto 0);
           s5 : in  STD_LOGIC_VECTOR (10 downto 0);
           s6 : in  STD_LOGIC_VECTOR (10 downto 0);
           s7 : in  STD_LOGIC_VECTOR (10 downto 0);
           s8 : in  STD_LOGIC_VECTOR (10 downto 0);
           s9 : in  STD_LOGIC_VECTOR (10 downto 0);
           s10 : in  STD_LOGIC_VECTOR (10 downto 0);
           s11 : in  STD_LOGIC_VECTOR (10 downto 0);
           s12 : in  STD_LOGIC_VECTOR (10 downto 0);
           s13 : in  STD_LOGIC_VECTOR (10 downto 0);
           s14 : in  STD_LOGIC_VECTOR (10 downto 0);
           s15 : in  STD_LOGIC_VECTOR (10 downto 0);
			  COUT : out STD_LOGIC;			  
           SUM : out  STD_LOGIC_VECTOR (10 downto 0)
			  );
end component;

signal qqq0,qqq1,qqq2,qqq3,qqq4,qqq5,qqq6,qqq7,qqq8,qqq9,qqq10,qqq11,qqq12,qqq13,qqq14,qqq15: STD_LOGIC_VECTOR (10 downto 0);
signal COUT: STD_LOGIC;			  
signal SUM: STD_LOGIC_VECTOR (10 downto 0);

begin
u0: reg16 port map(clk,sin,qqq0,qqq1,qqq2,qqq3,qqq4,qqq5,qqq6,qqq7,qqq8,qqq9,qqq10,qqq11,qqq12,qqq13,qqq14,qqq15,rst);
u1: CSA_16_Input port map(qqq0,qqq1,qqq2,qqq3,qqq4,qqq5,qqq6,qqq7,qqq8,qqq9,qqq10,qqq11,qqq12,qqq13,qqq14,qqq15,COUT,sout);

end Behavioral;

