--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:34:34 11/09/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/CompArithlab102/WithTestBench/RppleAdder8b_tb.vhd
-- Project Name:  WithTestBench
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RippleAdder8b
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
 
ENTITY RippleAdder8b_tb IS
END RippleAdder8b_tb;
 
ARCHITECTURE behavior OF RippleAdder8b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RippleAdder8b
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         b : IN  std_logic_vector(7 downto 0);
         c : IN  std_logic;
         s : OUT  std_logic_vector(7 downto 0);
         co : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(7 downto 0) := (others => '0');
   signal b : std_logic_vector(7 downto 0) := (others => '0');
   signal c : std_logic := '0';

 	--Outputs
   signal s : std_logic_vector(7 downto 0);
   signal co : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RippleAdder8b PORT MAP (
          a => a,
          b => b,
          c => c,
          s => s,
          co => co
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 10 ns;
			c <= '0';
			a <= "01001010";
			b <= "10100101";
		wait for 10 ns;
			c <= '0';
			a <= "01111010";
			b <= "10100111";
		wait for 10 ns;
			c <= '0';
			a <= "01101010";
			b <= "10000110";
		wait for 10 ns;
			c <= '1';
			a <= "10101010";
			b <= "00111001";
		wait for 10us;
			c <= '1';
			a <= "11111000";
			b <= "00110010";
		wait;
   end process;

END;
