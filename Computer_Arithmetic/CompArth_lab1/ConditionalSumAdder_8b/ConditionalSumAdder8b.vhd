----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:09:23 11/16/2016 
-- Design Name: 
-- Module Name:    ConditionalSumAdder8b - Behavioral 
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

entity ConditionalSumAdder8b is
    Port ( A : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           B : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           S : out  STD_LOGIC_VECTOR(7 DOWNTO 0);
           Cout : out  STD_LOGIC);
end ConditionalSumAdder8b;

architecture Behavioral of ConditionalSumAdder8b is

component HalfAdder is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : out  STD_LOGIC;
           s : out  STD_LOGIC);
end component;
component ResultGeneration is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c0 : out  STD_LOGIC;
           s0 : out  STD_LOGIC;
           c1 : out  STD_LOGIC;
           s1 : out  STD_LOGIC);
end component;
component Selector1 is						---Simple one
    Port ( c0 : in  STD_LOGIC;
           c1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           c : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           sout : out  STD_LOGIC);
end component;
component Selector2 is
    Port ( c0 : in  STD_LOGIC;
           c1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           sel0 : in  STD_LOGIC;
           sel1 : in  STD_LOGIC;
           cout0 : out  STD_LOGIC;
           cout1 : out  STD_LOGIC;
           sout0 : out  STD_LOGIC;
           sout1 : out  STD_LOGIC);
end component;
component Selector3 is						---Simple one
    Port ( c0 : in  STD_LOGIC;
           c1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s0prev : in  STD_LOGIC;
           s1prev : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           sout2 : out  STD_LOGIC;
           sout3 : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end component;
component Selector4 is
    Port ( c0 : in  STD_LOGIC;
           c1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s0prev : in  STD_LOGIC;
           s1prev : in  STD_LOGIC;
           sel0 : in  STD_LOGIC;
           sel1 : in  STD_LOGIC;
           cout0 : out  STD_LOGIC;
           cout1 : out  STD_LOGIC;
           sout0 : out  STD_LOGIC;
           sout1 : out  STD_LOGIC;
           sout0prev : out  STD_LOGIC;
           sout1prev : out  STD_LOGIC);
end component;
component Selector5 is
    Port ( c0 : in  STD_LOGIC;
           c1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s06 : in  STD_LOGIC;
           s16 : in  STD_LOGIC;
           s05 : in  STD_LOGIC;
           s15 : in  STD_LOGIC;
           s04 : in  STD_LOGIC;
           s14 : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           sout7 : out  STD_LOGIC;
           sout6 : out  STD_LOGIC;
           sout5 : out  STD_LOGIC;
           sout4 : out  STD_LOGIC);
end component;
signal c: 		STD_LOGIC;							--HA to Selector1
signal clow: 	STD_LOGIC_VECTOR(6 DOWNTO 0);
signal chigh: 	STD_LOGIC_VECTOR(6 DOWNTO 0);
signal slow: 	STD_LOGIC_VECTOR(6 DOWNTO 0);
signal shigh: 	STD_LOGIC_VECTOR(6 DOWNTO 0);
signal c2:		STD_LOGIC;							--Selector1 to Selector3
signal coutL: 	STD_LOGIC_VECTOR(2 DOWNTO 0);
signal coutH: 	STD_LOGIC_VECTOR(2 DOWNTO 0);
signal soutL: 	STD_LOGIC_VECTOR(2 DOWNTO 0);
signal soutH: 	STD_LOGIC_VECTOR(2 DOWNTO 0);
signal c3:		STD_LOGIC;							--Selector3 to Selector5
signal coutLOW:		STD_LOGIC;							
signal coutHIGH:		STD_LOGIC;							
signal soutLOW:		STD_LOGIC;							
signal soutHIGH:		STD_LOGIC;	
signal soutLOWpre:	STD_LOGIC;	
signal soutHIGHpre:	STD_LOGIC;							
begin
-----STAGE_1-----
u1 : HalfAdder port map			(A(0), B(0), c, S(0));									--to Select1 and S
u2 : ResultGeneration port map(A(1), B(1),clow(0),slow(0),chigh(0),shigh(0)); --to Select1
u3 : ResultGeneration port map(A(2), B(2),clow(1),slow(1),chigh(1),shigh(1)); --to Select2 and Select3
u4 : ResultGeneration port map(A(3), B(3),clow(2),slow(2),chigh(2),shigh(2)); --to Select2
u5 : ResultGeneration port map(A(4), B(4),clow(3),slow(3),chigh(3),shigh(3)); --to Select2 and Select5
u6 : ResultGeneration port map(A(5), B(5),clow(4),slow(4),chigh(4),shigh(4)); --to Select2
u7 : ResultGeneration port map(A(6), B(6),clow(5),slow(5),chigh(5),shigh(5)); --to Select2 and Select4
u8 : ResultGeneration port map(A(7), B(7),clow(6),slow(6),chigh(6),shigh(6)); --to Select2
-----STAGE_2-----
u9 : Selector1 port map			(clow(0), chigh(0), slow(0), shigh(0), c, c2, S(1));																--to Select3 and S			
u10: Selector2 port map			(clow(2), chigh(2), slow(2), shigh(2), clow(1), chigh(1), coutL(0), coutH(0), soutL(0), soutH(0)); --to Select3
u11: Selector2 port map			(clow(4), chigh(4), slow(4), shigh(4), clow(3), chigh(3), coutL(1), coutH(1), soutL(1), soutH(1)); --to Select4 and Select 5
u12: Selector2 port map			(clow(6), chigh(6), slow(6), shigh(6), clow(5), chigh(5), coutL(2), coutH(2), soutL(2), soutH(2)); --to Select4
-----STAGE_3-----
u13: Selector3 port map			(coutL(0), coutH(0), soutL(0), soutH(0), slow(1), shigh(1), c2, S(2), S(3), c3);							--to Select5 and S
u14: Selector4 port map			(coutL(2), coutH(2), soutL(2), soutH(2), slow(5), shigh(5), coutL(1), coutH(1), coutLOW, coutHIGH, soutLOW, soutHIGH, soutLOWpre, soutHIGHpre);
-----STAGE_4-----
u15: Selector5 port map			(coutLOW, coutHIGH, soutLOW, soutHIGH, soutLOWpre, soutHIGHpre, soutL(1), soutH(1), slow(3), shigh(3), c3, Cout, S(7), S(6), S(5), S(4));
end Behavioral;

