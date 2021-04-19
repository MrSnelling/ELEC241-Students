-- Quartus Prime VHDL Template
-- Basic Shift Register

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elec241_shift_register is

	generic
	(
		NUM_STAGES : natural := 4
	);

	port 
	(
		clk		: in std_logic;
		data_in	: in std_logic;
		data_out	: out std_logic := '0'
	);

end entity;

architecture rtl of elec241_shift_register is

	component DFF is 
		port(
		clk	: in std_logic;
        	data_in	: in std_logic;
        	data_out: out std_logic
		);
	end component;

	signal 	Q : std_logic_vector(NUM_STAGES downto 0):= (others => '0');

begin 
	G1 : for i in 0 to (NUM_STAGES-1) generate

	D_Flip_Flop:
	DFF port map (
	clk => clk,
        data_in => Q(i),
        data_out => Q(i+1)
	);
	end generate;

	data_out <= Q(NUM_STAGES);

end rtl;


