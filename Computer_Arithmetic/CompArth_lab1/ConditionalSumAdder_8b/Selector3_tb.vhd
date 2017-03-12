--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:52:02 11/16/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/ConditionalSumAdder8b/Selector3_tb.vhd
-- Project Name:  ConditionalSumAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Selector3
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Selector3_tb IS
END Selector3_tb;
 
ARCHITECTURE behavior OF Selector3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Selector3
    PORT(
         c0 : IN  std_logic;
         c1 : IN  std_logic;
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         s0prev : IN  std_logic;
         s1prev : IN  std_logic;
         sel : IN  std_logic;
         sout2 : OUT  std_logic;
         sout3 : OUT  std_logic;
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal c0 : std_logic := '0';
   signal c1 : std_logic := '0';
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';
   signal s0prev : std_logic := '0';
   signal s1prev : std_logic := '0';
   signal sel : std_logic := '0';

 	--Outputs
   signal sout2 : std_logic;
   signal sout3 : std_logic;
   signal cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Selector3 PORT MAP (
          c0 => c0,
          c1 => c1,
          s0 => s0,
          s1 => s1,
          s0prev => s0prev,
          s1prev => s1prev,
          sel => sel,
          sout2 => sout2,
          sout3 => sout3,
          cout => cout
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		c0<='0';
		c1<='0';
		s0<='1';
		s1<='1';
		s0prev<='0';
		s1prev<='1';
		sel<='0';
		wait for 100 ns;
		c0<='0';
		c1<='0';
		s0<='1';
		s1<='1';
		s0prev<='0';
		s1prev<='1';
		sel<='1';
      -- insert stimulus here 

      wait;
   end process;

END;
