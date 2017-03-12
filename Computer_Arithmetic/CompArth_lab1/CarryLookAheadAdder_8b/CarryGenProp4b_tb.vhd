--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:58:43 11/16/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/CarryLookAheadAdder8b/CarryGenProp4b_tb.vhd
-- Project Name:  CarryLookAheadAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CarryGenProp4b
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
 
ENTITY CarryGenProp4b_tb IS
END CarryGenProp4b_tb;
 
ARCHITECTURE behavior OF CarryGenProp4b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CarryGenProp4b
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         g : OUT  std_logic_vector(3 downto 0);
         p : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal g : std_logic_vector(3 downto 0);
   signal p : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CarryGenProp4b PORT MAP (
          a => a,
          b => b,
          g => g,
          p => p
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		a <= "0000";
		b <= "0011";
		wait for 100 ns;
		a <= "0011";
		b <= "0011";
		
      -- insert stimulus here 

      wait;
   end process;

END;
