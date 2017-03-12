--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:51:37 11/16/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/ConditionalSumAdder8b/Selector1_tb.vhd
-- Project Name:  ConditionalSumAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Selector1
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
 
ENTITY Selector1_tb IS
END Selector1_tb;
 
ARCHITECTURE behavior OF Selector1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Selector1
    PORT(
         c0 : IN  std_logic;
         c1 : IN  std_logic;
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         c : IN  std_logic;
         cout : OUT  std_logic;
         sout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal c0 : std_logic := '0';
   signal c1 : std_logic := '0';
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';
   signal c : std_logic := '0';

 	--Outputs
   signal cout : std_logic;
   signal sout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Selector1 PORT MAP (
          c0 => c0,
          c1 => c1,
          s0 => s0,
          s1 => s1,
          c => c,
          cout => cout,
          sout => sout
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		c0 <= '1';
		c1 <= '1';
		s0 <= '0';
		s1 <= '1';
		c  <= '1';
		wait for 100 ns;	
		c0 <= '1';
		c1 <= '1';
		s0 <= '1';
		s1 <= '0';
		c  <= '0';
		wait for 100 ns;	
		c0 <= '1';
		c1 <= '1';
		s0 <= '0';
		s1 <= '0';
		c  <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
