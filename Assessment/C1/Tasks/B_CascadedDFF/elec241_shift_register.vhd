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
		enable	: in std_logic;
		data_in	: in std_logic;
		data_out	: out std_logic
	);

end entity;

architecture rtl of elec241_shift_register is
	signal 	Q0, Q1, Q2 : std_logic;
begin

process(clk) is
begin
    if rising_edge(clk) then
        if enable = '0' then
            data_out <= '0';
        else
	    	Q0 <= data_in;
		if rising_edge(clk) then
			Q1 <= Q0;
			if rising_edge(clk) then
				Q2 <= Q1;
			end if;
		end if;
        end if;
    end if;
end process;
end rtl;
