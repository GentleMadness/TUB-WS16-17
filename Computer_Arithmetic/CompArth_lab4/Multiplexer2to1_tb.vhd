--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:27:18 11/10/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/CompArthL1_ConditionalSumAdder8b/Multiplexer2to1_tb.vhd
-- Project Name:  CompArthL1_ConditionalSumAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Multiplexer2to1
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
 
ENTITY Multiplexer2to1_tb IS
END Multiplexer2to1_tb;
 
ARCHITECTURE behavior OF Multiplexer2to1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Multiplexer2to1
    PORT(
         high : IN  std_logic;
         low : IN  std_logic;
         sel : IN  std_logic;
         z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal high : std_logic := '0';
   signal low : std_logic := '0';
   signal sel : std_logic := '0';

 	--Outputs
   signal z : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 --  constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Multiplexer2to1 PORT MAP (
          high => high,
          low => low,
          sel => sel,
          z => z
        );

   -- Clock process definitions
--   <clock>_process :process
--  begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--  end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			high <= '1';
			low <= '0';
			sel <= '0';
		wait for 10 ns;	
			high <= '1';
			low <= '0';
			sel <= '1';
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
