-- Quartus Prime VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg_decode is

	port(
		input	 : in	 std_logic_vector(3 downto 0); -- Binary input (0..15)
		reset	 : in	 std_logic;							 -- Asynchronous reset (sets output to blank)
		en     : in  std_logic;							 -- Input enable. Output is latched when 0
		output : out std_logic_vector(0 to 6)  -- Decoded output for each of the 7 LEDs
	);

end entity;

architecture v1 of seven_seg_decode is
-- MODIFY THE CODE BELOW THIS LINE --
begin

process (reset, en, input) is
 	begin
		if(reset = '1') then	-- if reset is high, output is always set to 0000000 
		
			output(0 to 6) <= "0000000";
								
		else					-- otherwise if rest is low....
			 if (en = '1') then -- and if enable is on, output will be latched (changed)

			 	-- boolean for output 0 (LED 0)
				output(0) <=	(input(3) and not input(2) and not input(1))
								or (input(3) and not input(0))
								or (not input(3) and input(2) and input(0)) 
								or (not input(3) and input(1)) 
								or (input(2) and input(1))
								or (not input(2) and not input(0));
				-- boolean for output 1 (LED 0)				
				output(1) <=	(not input(3) and input(1) and input(0))
								or (not input(3) and not input(0) and not input(1))
								or (input(3) and input(2) and not input(1) and input(0)) 
								or (not input(2) and not input(1))
								or (not input(2) and not input(0));
				-- boolean for output 2 (LED 0)				
				output(2) <=	(not input(3) and not input(1))
								or (not input(3) and input(0))
								or (not input(3) and input(2) and input(1) and not input(0))
								or (input(3) and not input(2))
								or (input(3) and input(2) and not input(1) and input(0));
				-- boolean for output 3 (LED 3)				
				output(3) <=	(input(3) and not input(2) and input(0))
								or (input(3) and not input(1)) 
								or (not input(3) and not input(2) and input(1))
								or (not input(3) and not input(2) and not input(0)) 
								or (input(2) and input(1) and not input(0))
								or (input(2) and not input(1) and input(0));
				-- boolean for output 4 (LED 4)				
				output(4) <=   (input(3) and input(2))
								or (input(3) and input(1))
								or (not input(0) and not input(2))
								or (input(1) and not input(0));
				-- boolean for output 5 (LED 5)				
				output(5) <=	(input(3) and input(2) and input(1))
								or (input(3) and input(1) and not input(0))
								or (input(3) and not input(2) and input(0))
								or (input(3) and not input(2) and not input(1))
								or (not input(3) and input(2) and not input(1)) 
								or (not input(3) and not input(1) and not input(0))
								or (not input(0) and input(2));
				-- boolean for output 6 (LED 6)
				output(6) <=	(not input(3) and input(2) and not input(1))
								or (not input(3) and input(1) and not input(2)) 
								or (not input(3) and input(1) and not input(0))
								or (input(3) and input(2) and input(1))
								or (input(3) and not input(2) and not input(0)) 
								or (input(3) and not input(2) and not input(1))
								or (input(3) and input(1) and input(0))
								or (input(2) and not input(1) and input(0));				
				end if;
				-- if enable is not high, output doesnt change
		end if;	
		
	end process;

end v1;

