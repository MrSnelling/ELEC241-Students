library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--nothing here
entity seven_seg_decode_test is
end seven_seg_decode_test;

architecture test_arch of seven_seg_decode_test is

	--declare components
	component seven_seg_decode
		port(
				input  : in  std_logic_vector(3 downto 0); 	-- Binary input (0..15)
				reset  : in  std_logic;			  	 		-- Asynchronous reset (sets output to blank)
				en     : in  std_logic;			   			-- Input enable. Output is latched when 0
				output : out std_logic_vector(0 to 6)  	   	-- Decoded output for each of the 7 LEDs
		);
	end component;
		
	--declare signals to be used X testbench
	signal X : std_logic_vector(3 downto 0); -- X is the input
	signal E : std_logic;	-- E is the enable
	signal R : std_logic;	-- R is the reset
	signal Y : std_logic_vector(0 to 6);	--Y is the output

begin

--Instantiate a component of type seven_seg_decode
u1: seven_seg_decode PORT MAP (
	reset => R,		-- R is the reset
	en => E,		-- E is the enable
	input(3 downto 0) => X(3 downto 0),
	output => Y		--Y is the output
);

process
	begin
	for i in 0 to 3 loop

		if 	i = 0 then 	R <= '1';	E <= '0';		-- X loop 0 , Reset is high and enable is low	// as reset is high, output defaults to 0000000
		elsif 	i = 1 then 	R <= '0';	E <= '1';	-- X loop 1 , Reset is low and enable is high	// as enable is high, the output changes depending on ABCD
		elsif 	i = 2 then	R <= '0';	E <= '0'; 	-- X loop 2 , Reset is low and enable is low 	// as enable is low, output is the same as previous ouput
		else 			R <= '1';	E <= '1';		-- X loop 3 , Reset is high and enable is high	// as reset is high, output defaults to 0000000
		end if;


		-- For each iteration of the 16 options of X, the input is asserted to the required value and then we implement a wait. 
		-- This wait means we can see the wave on the testbench simulation.0s
		-- We then use the assert command to check our answer for Y. If it is incorrect, the simulation will fail and the error message will be shown.
		X <= "0000";	
		wait for 100 ps;
		-- In the iteration of X that is 0000, we chose to use the assert command to check that the reset and enable inputs are also working.0s
		-- These are only performed at this stage as they are only changed at the beginning of each loop.
		if i = 0 then 
			assert (R = '1') report "Reset is not working" severity failure;
			assert (E = '0') report "Enable is not working" severity failure;
			assert (Y = "0000000") report "Reset is not working" severity failure;	-- reset high means Y should = 0.
		elsif i = 1 then 
			assert (R = '0') report "Reset is not working" severity failure;
			assert (E = '1') report "Enable is not working" severity failure;
			assert (Y = "1111110") report "input = 0000 is generating an incorrect output" severity failure; -- value of Y when X = 0000 and E = 1 and R = 0.
		elsif i = 2 then
			assert (R = '0') report "Reset is not working" severity failure;
			assert (E = '0') report "Enable is not working" severity failure;
			assert (Y = "1000111") report "Reset is not working" severity failure;	-- previous Y value from X = 1111, E = 1 and R = 0.
		else 	
			assert (R = '1') report "Reset is not working" severity failure;
			assert (E = '1') report "Enable is not working" severity failure;
			assert (Y = "0000000") report "Reset is not working" severity failure;	-- reset high means Y should = 0.
		end if;

		-- The rest of the iterations of X are then simulated and if it is loop 1 (when reset is low and enable is high) the assert command is used.
		X <= "0001";
		wait for 100 ps;
		if i = 1 then assert (Y = "0110000") report "input = 0001 is generating an incorrect output" severity failure; end if;

		X <= "0010";
		wait for 100 ps;
		if i = 1 then assert (Y = "1101101") report "input = 0010 is generating an incorrect output" severity failure; end if;

		X <= "0011";
		wait for 100 ps;
		if i = 1 then assert (Y = "1111001") report "input = 0011 is generating an incorrect output" severity failure; end if;

		X <= "0100";
		wait for 100 ps;
		if i = 1 then assert (Y = "0110011") report "input = 0100 is generating an incorrect output" severity failure; end if;

		X <= "0101";		
		wait for 100 ps;
		if i = 1 then assert (Y = "1011011") report "input = 0101 is not working" severity failure; end if;

		X <= "0110";		
		wait for 100 ps;
		if i = 1 then assert (Y = "1011111") report "input = 0110 is generating an incorrect output" severity failure; end if;

		X <= "0111";		
		wait for 100 ps;
		if i = 1 then assert (Y = "1110000") report "input = 0111 is generating an incorrect output" severity failure; end if;

		X <= "1000";
		wait for 100 ps;
		if i = 1 then assert (Y = "1111111") report "input = 1000 is generating an incorrect output" severity failure; end if;
		
		X <= "1001";
		wait for 100 ps;
		if i = 1 then assert (Y = "1111011") report "input = 1001 is generating an incorrect output" severity failure; end if;

		X <= "1010";	
		wait for 100 ps;
		if i = 1 then assert (Y = "1110111") report "input = 1010 is generating an incorrect output" severity failure; end if;

		X <= "1011";
		wait for 100 ps;
		if i = 1 then assert (Y = "0011111") report "input = 1011 is generating an incorrect output" severity failure; end if;

		X <= "1100";
		wait for 100 ps;
		if i = 1 then assert (Y = "1001110") report "input = 1100 is generating an incorrect output" severity failure; end if;
		
		X <= "1101";
		wait for 100 ps;
		if i = 1 then assert (Y = "0111101") report "input = 1101 is generating an incorrect output" severity failure; end if;

		X <= "1110";		
		wait for 100 ps;
		if i = 1 then assert (Y = "1001111") report "input = 1110 is generating an incorrect output" severity failure; end if;
		
		X <= "1111";
		wait for 100 ps;
		if i = 1 then assert (Y = "1000111") report "input = 1111 is generating an incorrect output" severity failure; end if;
	end loop;
	wait;--end of test is to wait forever
	end process; 
end test_arch;