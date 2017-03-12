library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity divider_control is
    Port ( clk : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC_VECTOR (1 downto 0);
           rst : in  STD_LOGIC);
end divider_control;

architecture Behavioral of divider_control is
	type state_type is (state_1, state_2, state_3, state_4); 
   signal state, next_state : state_type; 
   --Declare internal signals for all outputs of the state-machine
   signal output_i : STD_LOGIC_VECTOR (1 downto 0);  -- example output signal
   
 
begin

	--Insert the following in the architecture after the begin keyword
   SYNC_PROC: process (clk)
   begin
      if (clk'event and clk = '1') then
         if (rst = '1') then
            state <= state_1;
            output <= (others=>'0');
         else
            state <= next_state;
            output <= output_i;
         -- assign other outputs to internal signals
         end if;        
      end if;
   end process;
 
   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
      --insert statements to decode internal output signals
      --below is simple example
      case (state) is
			when state_1 =>
					output_i <= "00";
			when state_2 =>
					output_i <= "00";
			when state_3 =>
					output_i <= "01";
			when state_4 =>
					output_i <= "10";
      end case;
   end process;
 
   NEXT_STATE_DECODE: process (state, input)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
         when state_1 =>
            if input(0) = '1' then
               next_state <= state_2;					
            end if;
         when state_2 =>
            if input(1)= '1' then
               next_state <= state_3;
				else
					next_state <= state_1;
            end if;
         when state_3 =>
				if input(0)='0' and input(1)='1' then
					next_state <= state_4;
				end if;
         when state_4 =>
				if input(0)='1' then
					next_state <= state_1;
				end if;
      end case;      
   end process;
end Behavioral;
