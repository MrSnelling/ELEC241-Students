library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--nothing here
entity elec241_shift_register_test is
end elec241_shift_register_test;

architecture test_arch of elec241_shift_register_test is

component elec241_shift_register 
    	generic 
	(	NUM_STAGES : natural
	);
	port 
	(	clk	: in std_logic := '0';
		data_in	: in std_logic := '0';
		data_out: out std_logic := '0'
	); end component;

component DFF
    	port 
	(	clk	: in std_logic;
		data_in	: in std_logic;
		data_out: out std_logic
	); end component;   

signal C  : std_logic;
signal DIn : std_logic;
signal DOut : std_logic;
signal Y : std_logic_vector(0 to 4);
signal Q : std_logic_vector(0 to 2);

begin

--Instantiate a component of type seven_seg_decode
u1: elec241_shift_register  
	GENERIC MAP 
	(	NUM_STAGES => 4
	)
	PORT MAP 
	(	clk => C, 
	        data_in => DIn,
	        data_out => DOut
	);

u2: for i in 0 to (3) generate
	D_Flip_Flop:
	DFF 
	PORT MAP 
	(	clk => C,
	       	data_in => Y(i),
	       	data_out => Y(i+1)
	);
	end generate;
Y(0) <= DIn;
DOut <= Y(4);

Q(0 to 2) <= Y(1 to 3);

clock : PROCESS
begin
    for i in 0 to 10 loop
	    C <= '0';
	    wait for 50 ps;
		if i = 7 then assert (Q = "010") report "error in input 00 end of cascade (loop 7)" severity failure; 	-- 00 where msd is C and lsd is DIn
		elsif i = 8 then assert (Q = "001") report "error in input 00 end of cascade (8)" severity failure;
		elsif i = 9 then assert (Q = "000") report "error in input 00 end of cascade (9)" severity failure;
		elsif i = 10 then assert (Q = "000") report "error in input 00 end of cascade (10)" severity failure;
	end if;
	    C <= '1';
	    wait for 50 ps;
		if i = 7 then assert (Q = "001") report "error in input 10 end of cascade (loop 7)" severity failure;	-- 10 where msd is C and lsd is DIn
		elsif i = 8 then assert (Q = "000") report "error in input 10 end of cascade (loop 8)" severity failure;
		elsif i = 9 then assert (Q = "000") report "error in input 10 end of cascade (loop 9)" severity failure;
		elsif i = 10 then assert (Q = "000") report "error in input 10 end of cascade (loop 10)" severity failure;
	end if;
    end loop;
    wait;
end process clock; 

cascade : process
begin
    for i in 0 to 2 loop
    	
	DIn <= '0';
	wait for 50 ps;
	if i = 0 then assert (Q = "000") report "error in input 00 in Loop 1" severity failure; -- 00 where msd is C and lsd is DIn
	elsif i = 1 then assert (Q = "100") report "error in input 00 in Loop 2" severity failure;
        elsif i = 2 then assert (Q = "101") report "error in input 00 in Loop 3" severity failure;
	end if;

	wait for 50 ps;
	if i = 0 then assert (Q = "000") report "error in input 01 in Loop 1" severity failure; -- 01 where msd is C and lsd is DIn
        elsif i = 1 then assert (Q = "010") report "error in input 01 in Loop 2" severity failure;
        elsif i = 2 then assert (Q = "010") report "error in input 01 in Loop 3" severity failure;
        end if;

        DIn <= '1';
	wait for 50 ps;
	if i = 0 then assert (Q = "000") report "error in input 10 in Loop 1" severity failure; -- 10 where msd is C and lsd is DIn
        elsif i = 1 then assert (Q = "010") report "error in input 10 in Loop 2" severity failure;
        elsif i = 2 then assert (Q = "010") report "error in input 10 in Loop 3" severity failure;
        end if;
	
	wait for 50 ps;
        if i = 0 then assert (Q = "100") report "error in input 11 in Loop 1" severity failure; -- 11 where msd is C and lsd is DIn 
        elsif i = 1 then assert (Q = "101") report "error in input 11 in Loop 2" severity failure;
        elsif i = 2 then assert (Q = "101") report "error in input 11 in Loop 3" severity failure;
        end if;	
	    
    end loop;
    DIn <= '0';
    wait for 50 ps;
    wait; --end of test is to wait forever
end process cascade; 
    
end test_arch;