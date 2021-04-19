library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DFF is 
    port 
    (
        clk	: in std_logic := '0';
        data_in	: in std_logic := '0';
        data_out: out std_logic := '0'
    );
end DFF;

architecture DFFlogic of DFF is 

begin
process(clk) is
	begin
    	if(rising_edge(clk)) then 
        	data_out <= data_in;
    	end if;
end process;
end DFFlogic;