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
				input  : in  std_logic_vector(3 downto 0); -- Binary input (0..15)
				reset  : in  std_logic;			   -- Asynchronous reset (sets output to blank)
				en     : in  std_logic;			   -- Input enable. Output is latched when 0
				output : out std_logic_vector(0 to 6)  	   -- Decoded output for each of the 7 LEDs
			);
		end component;
		
	--declare signals
	signal A : std_logic;
	signal B : std_logic;
	signal C : std_logic;
	signal D : std_logic;
	signal E : std_logic;
	signal R : std_logic;
	signal Y : std_logic_vector(0 to 6);

begin

--Instantiate a component of type seven_seg_decode
u1: seven_seg_decode PORT MAP (
	reset => R,
	en => E,
	input(3) => A,
	input(2) => B,
	input(1) => C,
	input(0) => D,
	output => Y
);

process
	--declarations go here
	begin
	--assert the input signals
	--wait, then check output signal
	for i in 0 to 3 loop

		if 	i = 0 then 	R <= '1';	E <= '0';
		elsif 	i = 1 then 	R <= '0';	E <= '1';
		elsif 	i = 2 then	R <= '0';	E <= '0';
		else 			R <= '1';	E <= '1';
		end if;

		A <= '0';
		B <= '0';
		C <= '0';
		D <= '0';
		wait for 100 ns;
		if i = 0 then 
			assert (R = '1') report "Reset is not working" severity failure;
			assert (E = '0') report "Enable is not working" severity failure;
			assert (Y = "0000000") report "Reset is not working" severity failure;	
		elsif i = 1 then 
			assert (R = '0') report "Reset is not working" severity failure;
			assert (E = '1') report "Enable is not working" severity failure;
			assert (Y = "1111110") report "input = 0000 is generating an incorrect output" severity failure;
		elsif i = 2 then
			assert (R = '0') report "Reset is not working" severity failure;
			assert (E = '0') report "Enable is not working" severity failure;
			assert (Y = "1000111") report "Reset is not working" severity failure;	-- previous Y value
		else 	
			assert (R = '1') report "Reset is not working" severity failure;
			assert (E = '1') report "Enable is not working" severity failure;
			assert (Y = "0000000") report "Reset is not working" severity failure;
		end if;

		A <= '0';
		B <= '0';
		C <= '0';
		D <= '1';
		wait for 100 ns;
		if i = 1 then assert (Y = "0110000") report "input = 0001 is generating an incorrect output" severity failure; end if;

		A <= '0';
		B <= '0';
		C <= '1';
		D <= '0';
		wait for 100 ns;
		if i = 1 then assert (Y = "1101101") report "input = 0010 is generating an incorrect output" severity failure; end if;

		A <= '0';
		B <= '0';
		C <= '1';
		D <= '1';		
		wait for 100 ns;
		if i = 1 then assert (Y = "1111001") report "input = 0011 is generating an incorrect output" severity failure; end if;

		A <= '0';
		B <= '1';
		C <= '0';
		D <= '0';
		wait for 100 ns;
		if i = 1 then assert (Y = "0110011") report "input = 0100 is generating an incorrect output" severity failure; end if;

		A <= '0';
		B <= '1';
		C <= '0';
		D <= '1';		
		wait for 100 ns;
		if i = 1 then assert (Y = "1011011") report "input = 0101 is not working" severity failure; end if;

		A <= '0';
		B <= '1';
		C <= '1';
		D <= '0';		
		wait for 100 ns;
		if i = 1 then assert (Y = "1011111") report "input = 0110 is generating an incorrect output" severity failure; end if;

		A <= '0';
		B <= '1';
		C <= '1';
		D <= '1';		
		wait for 100 ns;
		if i = 1 then assert (Y = "1110000") report "input = 0111 is generating an incorrect output" severity failure; end if;

		A <= '1';
		B <= '0';
		C <= '0';
		D <= '0';
		wait for 100 ns;
		if i = 1 then assert (Y = "1111111") report "input = 1000 is generating an incorrect output" severity failure; end if;
		
		A <= '1';
		B <= '0';
		C <= '0';
		D <= '1';		
		wait for 100 ns;
		if i = 1 then assert (Y = "1111011") report "input = 1001 is generating an incorrect output" severity failure; end if;

		A <= '1';
		B <= '0';
		C <= '1';
		D <= '0';		
		wait for 100 ns;
		if i = 1 then assert (Y = "1110111") report "input = 1010 is generating an incorrect output" severity failure; end if;

		A <= '1';
		B <= '0';
		C <= '1';
		D <= '1';
		wait for 100 ns;
		if i = 1 then assert (Y = "0011111") report "input = 1011 is generating an incorrect output" severity failure; end if;

		A <= '1';
		B <= '1';
		C <= '0';
		D <= '0';
		wait for 100 ns;
		if i = 1 then assert (Y = "1001110") report "input = 1100 is generating an incorrect output" severity failure; end if;
		
		A <= '1';
		B <= '1';
		C <= '0';
		D <= '1';		
		wait for 100 ns;
		if i = 1 then assert (Y = "0111101") report "input = 1101 is generating an incorrect output" severity failure; end if;

		A <= '1';
		B <= '1';
		C <= '1';
		D <= '0';			
		wait for 100 ns;
		if i = 1 then assert (Y = "1001111") report "input = 1110 is generating an incorrect output" severity failure; end if;
		
		A <= '1';
		B <= '1';
		C <= '1';
		D <= '1';
		wait for 100 ns;
		if i = 1 then assert (Y = "1000111") report "input = 1111 is generating an incorrect output" severity failure; end if;
	end loop;
	wait;--end of test is to wait forever
	end process; 
end test_arch;