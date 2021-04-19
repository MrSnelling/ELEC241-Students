library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DFF is 
    port 
    (
        clk	: in std_logic := '0'; -- clocked input 1 or 0
        data_in	: in std_logic := '0'; -- binary input 1 or 0
        data_out: out std_logic := '0' -- binary output 1 or 0
    );
end DFF;

architecture DFFlogic of DFF is 

begin
process(clk) is
	begin
    	if(rising_edge(clk)) then -- only enter statement on the rising edge of the clock signal
        	data_out <= data_in; -- copy the input to the output. output will show inout delayed by one clock cycle
    	end if;
end process;
end DFFlogic;