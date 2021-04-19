-- Quartus Prime VHDL Template
-- Basic Shift Register

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elec241_shift_register is

	generic
	(
		NUM_STAGES : natural := 4 -- set number of stages to be used in generate to 4
	);

	port 
	(
		clk		: in std_logic; -- clocked input 1 or 0
		data_in	: in std_logic; -- binary input 1 or 0
		data_out	: out std_logic := '0' -- binary output 1 or 0
	);

end entity;

architecture rtl of elec241_shift_register is

	component DFF is 
		port(
		clk	: in std_logic; -- clocked binary input 1 or 0
        	data_in	: in std_logic; -- binary input 1 or 0
        	data_out: out std_logic -- binary output 1 or 0
		);
	end component;

	signal 	Q : std_logic_vector(NUM_STAGES downto 0):= (others => '0'); -- set the value of Q to all 0s

begin 
	G1 : for i in 0 to (NUM_STAGES-1) generate
    -- generate 3 D type flip flops
	D_Flip_Flop:
	DFF port map (
	clk => clk, -- map the clock to clock 
	data_in => Q(i), -- DFF input mapped to Q for each generation of the DFF
	data_out => Q(i+1) -- DFF output mapped to Q for each generation of the DFF + 1 to be stepped by a clock cycle
	);
	end generate;

	data_out <= Q(NUM_STAGES); -- Set data out to be the last output from the shift register 

end rtl;


