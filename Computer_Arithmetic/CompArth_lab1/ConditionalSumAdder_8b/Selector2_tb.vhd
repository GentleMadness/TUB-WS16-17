--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:04:34 11/16/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/ConditionalSumAdder8b/Selector2_tb.vhd
-- Project Name:  ConditionalSumAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Selector2
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
 
ENTITY Selector2_tb IS
END Selector2_tb;
 
ARCHITECTURE behavior OF Selector2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Selector2
    PORT(
         c0 : IN  std_logic;
         c1 : IN  std_logic;
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         sel0 : IN  std_logic;
         sel1 : IN  std_logic;
         cout0 : OUT  std_logic;
         cout1 : OUT  std_logic;
         sout0 : OUT  std_logic;
         sout1 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal c0 : std_logic := '0';
   signal c1 : std_logic := '0';
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';
   signal sel0 : std_logic := '0';
   signal sel1 : std_logic := '0';

 	--Outputs
   signal cout0 : std_logic;
   signal cout1 : std_logic;
   signal sout0 : std_logic;
   signal sout1 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Selector2 PORT MAP (
          c0 => c0,
          c1 => c1,
          s0 => s0,
          s1 => s1,
          sel0 => sel0,
          sel1 => sel1,
          cout0 => cout0,
          cout1 => cout1,
          sout0 => sout0,
          sout1 => sout1
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      c0 <= '1';
		c1 <= '0';
		s0 <= '1';
		s1 <= '0';
		sel0<= '0';
		sel1<= '0';
		wait for 100 ns;	
	   c0 <= '1';
		c1 <= '0';
		s0 <= '1';
		s1 <= '0';
		sel0<= '0';
		sel1<= '1';
		wait for 100 ns;	
	   c0 <= '1';
		c1 <= '0';
		s0 <= '1';
		s1 <= '0';
		sel0<= '1';
		sel1<= '0';
		wait for 100 ns;	
	   c0 <= '1';
		c1 <= '0';
		s0 <= '1';
		s1 <= '0';
		sel0<= '1';
		sel1<= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
