--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:17:54 11/09/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/CompArthL1_ConditionalSumAdder8b/ResultGeneration_tb.vhd
-- Project Name:  CompArthL1_ConditionalSumAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ResultGeneration
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
 
ENTITY ResultGeneration_tb IS
END ResultGeneration_tb;
 
ARCHITECTURE behavior OF ResultGeneration_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ResultGeneration
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         c0 : OUT  std_logic;
         s0 : OUT  std_logic;
         c1 : OUT  std_logic;
         s1 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	--Outputs
   signal c0 : std_logic;
   signal s0 : std_logic;
   signal c1 : std_logic;
   signal s1 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ResultGeneration PORT MAP (
          a => a,
          b => b,
          c0 => c0,
          s0 => s0,
          c1 => c1,
          s1 => s1
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
	--	wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			a <= '0';
			b <= '0';
		wait for 10 ns;	
			a <= '1';
			b <= '0';
		wait for 10 ns;	
			a <= '0';
			b <= '1';
		wait for 10 ns;	
			a <= '1';
			b <= '1';
		wait for 10 ns;	
			a <= '1';
			b <= '0';
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
