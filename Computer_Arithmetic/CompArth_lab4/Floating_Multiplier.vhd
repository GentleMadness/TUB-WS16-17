----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:51:50 01/26/2017 
-- Design Name: 
-- Module Name:    Floating_Multiplier - Behavioral 
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

entity Floating_Multiplier is
    Port ( A : in  STD_LOGIC_VECTOR (22 downto 0);
           B : in  STD_LOGIC_VECTOR (22 downto 0);
           P : out  STD_LOGIC_VECTOR (22 downto 0);
			  Sign_flag : out STD_LOGIC;
			  Zero_flag : out STD_LOGIC; 
			  Over_flag : out STD_LOGIC;
			  Under_flag: out STD_LOGIC);
end Floating_Multiplier;
 
architecture Behavioral of Floating_Multiplier is

component R4_BoothMultiplier is
    Port ( a : in  STD_LOGIC_VECTOR (15 downto 0);--multipicant
           b : in  STD_LOGIC_VECTOR (15 downto 0);--multiplier
           res : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ConditionalSumAdder8b is
    Port ( A : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           B : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           S : out  STD_LOGIC_VECTOR(7 DOWNTO 0);
           Cout : out  STD_LOGIC);
end component;

signal m_A, m_B: STD_LOGIC_VECTOR (15 downto 0);
signal res: STD_LOGIC_VECTOR (31 downto 0);
signal norm_res: STD_LOGIC_VECTOR (13 downto 0);
signal sig_A, sig_B: STD_LOGIC_VECTOR (13 downto 0);
signal s_P, c0, c1, c2: STD_LOGIC;
signal exA, exB, e_sum, e_sub, e, new_e: STD_LOGIC_VECTOR (7 downto 0);

begin
------------ Unpacking A ------------------- 
exA <= A(21 downto 14);     -- exponent A
sig_A <= A(13 downto 0);    -- significant A
m_A <= "01" & sig_A; -- for 16-bit multiplier

------------ Unpacking B -------------------
exB <= B(21 downto 14);     -- exponent B
sig_B <= B(13 downto 0);    -- significant B
m_B <= "01" & sig_B; -- for 16-bit multiplier

-- Output Sign bit
s_P <= (A(22) XOR B(22));

-- Muliplicantion
Multiplier: R4_BoothMultiplier port map (m_A, m_B, res);

--Normalization of the multiplicant
norm_res <= res(28 downto 15) when res(29) = '1'
									   else res(27 downto 14);

-- New Exponents	
e <= "0000000" & res(29); -- if res(29) = 1, exponent+1; else e=0;
Add_Exponent: ConditionalSumAdder8b port map (A(21 downto 14), B(21 downto 14), e_sum, c0); 
subtract127 : ConditionalSumAdder8b port map (e_sum, "10000001", e_sub, c1);
normalize_e : ConditionalSumAdder8b port map (e_sub, e, new_e, c2);

-- Check 0 at unpacking stage
P <= s_P & "0000000000000000000000" 
     when A(21 downto 0) = "0000000000000000000000" or 
			 B(21 downto 0) = "0000000000000000000000" 
	  else s_P & new_e & norm_res;

-- Flag Generation Stage
-- Zero flag	
Zero_flag <= '1' 
     when A(21 downto 0) = "0000000000000000000000" or 
			 B(21 downto 0) = "0000000000000000000000" 
     else '0';
	
-- Sign flag
Sign_flag <= s_P;

-- Over_flag / Under_flag
-- ignore 0: exA /= 0, exB /= 0
Over_flag <= '1'
     when new_e = "11111111"
	  else (c0 and (c1 or c2));  

Under_flag <= '1'
     when e_sub ="00000000" 
	  else '1' when(e_sub(7)='1' and exA(7)='0' and exB(7)='0')
	  else '0';
end Behavioral;

