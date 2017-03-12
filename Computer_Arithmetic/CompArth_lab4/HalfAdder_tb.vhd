--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:44:40 11/16/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/ConditionalSumAdder8b/HalfAdder_tb.vhd
-- Project Name:  ConditionalSumAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: HalfAdder
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
 
ENTITY HalfAdder_tb IS
END HalfAdder_tb;
 
ARCHITECTURE behavior OF HalfAdder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HalfAdder
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         c : OUT  std_logic;
         s : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	--Outputs
   signal c : std_logic;
   signal s : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HalfAdder PORT MAP (
          a => a,
          b => b,
          c => c,
          s => s
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		a<='0';
		b<='1';

      -- insert stimulus here 

      wait;
   end process;

END;
