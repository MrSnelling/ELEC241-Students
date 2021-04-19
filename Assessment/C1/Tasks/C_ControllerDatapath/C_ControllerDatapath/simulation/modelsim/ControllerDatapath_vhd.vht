-- Copyright (C) 2019  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "02/25/2021 16:08:31"
                                                            
-- Vhdl Test Bench template for design  :  ControllerDatapath_vhd
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;
                            

ENTITY ControllerDatapath_vhd_tst IS
END ControllerDatapath_vhd_tst;
ARCHITECTURE ControllerDatapath_vhd_arch OF ControllerDatapath_vhd_tst IS                                   
	-- signals in, initial conditions set                                                  
	SIGNAL CLK : STD_LOGIC := '0';
	SIGNAL DATA : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	SIGNAL RESET : STD_LOGIC := '0';

	SIGNAL EN_ACC : STD_LOGIC := '1';
	SIGNAL EN_R1 : STD_LOGIC := '1';
	SIGNAL EN_R2 : STD_LOGIC := '1';

	SIGNAL SEL_ACC : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL SEL_R1 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL SEL_R2 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL SEL_SUM : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

	--signals out
	SIGNAL ACC : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL R1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL R2 : STD_LOGIC_VECTOR(7 DOWNTO 0);

COMPONENT ControllerDatapath_vhd
	PORT (
	--Inputs
	CLK : IN STD_LOGIC;
	DATA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	RESET : IN STD_LOGIC;
	
	EN_ACC : IN STD_LOGIC;
	EN_R1 : IN STD_LOGIC;
	EN_R2 : IN STD_LOGIC;
	
	SEL_ACC : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	SEL_R1 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	SEL_R2 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	SEL_SUM : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

	--Outputs
	ACC : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	R1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	R2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : ControllerDatapath_vhd
	PORT MAP 
	(
	-- list connections between master ports and signals
		--Inputs
		CLK => CLK,
		DATA => DATA,
		RESET => RESET,

		EN_ACC => EN_ACC,
		EN_R1 => EN_R1,
		EN_R2 => EN_R2,
		
		SEL_ACC => SEL_ACC,
		SEL_R1 => SEL_R1,
		SEL_R2 => SEL_R2,
		SEL_SUM => SEL_SUM,

		--Outputs
		ACC => ACC,
		R1 => R1,
		R2 => R2
	);
--PART 1 and PART 2
init : PROCESS
BEGIN
	RESET <= '0'; -- reset all before continuing 
	wait for 25 ps;
	RESET <= '1'; -- turn reset off
	for i in 0 to 15 loop -- loop for the clock 
		CLK <= '1';
		wait for 25 ps;

		CLK <= '0';
		wait for 25 ps;
	end loop;
    WAIT;
END PROCESS init; 

--PART 3
always : PROCESS
BEGIN
	-- step a (R1<-00000010)
	wait for 50 ps;
	-- set data and disble ACC and R2
	data <= "00000010";
	EN_ACC <= '0';
	EN_R2 <= '0';
	wait for 50 ps;
	assert (R1 = "00000010") report "step a isn't working" severity note;

	-- step b (R2<-R1)
	-- enable R2 and select R2 input to be R1_OUT
	EN_R2 <= '1';
	SEL_R2 <= "01";
	wait for 50 ps;
	assert (R2 = R1) report "step b isn't working" severity note;

	-- step c (ACC<-00000001)
	-- disable R1, enable ACC and change data
	EN_R1 <= '0';
	EN_ACC <= '1';
	data <= "00000001";
	wait for 50 ps;
	assert (ACC = "00000001") report "step c isn't working" severity note;

	-- step d (R1<-ACC)
	-- enable R1, disable R2 and choose required inputs for R1 (acc out) 
	EN_R2 <= '0';
	EN_R1 <= '1';
	SEL_R1 <= "01";
	wait for 50 ps;
	assert (R1 = "00000001") report "step d isn't working" severity note;

	-- step e (ACC<-ACC+R1)
	-- disable R1, choose required inputs for SUM (r1 out) and ACC (sum)
	EN_R1 <= '0';
	SEL_SUM <= "01";
	SEL_ACC <= "11";
	wait for 50 ps;
	assert (ACC = "00000010") report "step e isn't working" severity note;

	-- step f (2 CYCLES) (R1<-01000000 , R2<-00000000 , ACC<-00000001)
	EN_R1 <= '1';
	EN_R2 <= '1';
	data <= "01000000";
	SEL_SUM <= "11"; --turn sum off
	SEL_R1 <= "00"; --R1 uses data val
	SEL_ACC <= "01"; --ACC uses previous R1 out
	SEL_R2 <= "11";	--R2 uses Zero
	wait for 50 ps;
	assert (R1 = "01000000" and R2 = "00000000" and ACC = "00000001") report "step f.1 isn't working" severity note;
	EN_ACC <= '0'; --keep ACC the same as prev cycle
	wait for 50 ps;
	assert (R1 = "01000000" and R2 = "00000000" and ACC = "00000001") report "step f.2 isn't working" severity note;

	-- step g (R1<-00100000 , R2<-R1 , ACC<-ACC+R2)
	EN_ACC <= '1'; --Enable ACC again
	SEL_SUM <= "10"; --R2+ACC
	SEL_ACC <= "11"; --use Sum for ACC
	data <= "00100000"; --set data for R1
	SEL_R2 <= "01"; -- use prev R1 out for R2
	wait for 50 ps;
	assert (R1 = "00100000" and R2 = "01000000" and ACC = "00000001") report "step g isn't working" severity note;

	-- PART 4 -- SUM left to right ACC<-(00000001 + 00000001 + 10000000 + 01000000 + 00000001 + 00100000))
	
	-- 00000001 + 00000001
	EN_R1 <= '0';	
	EN_R2 <= '0';
	data <= "00000001";  -- set data
	SEL_SUM<="00";		 -- use data for sum
	SEL_ACC <= "11"; 	 -- use sum for acc (makes acc 00000010)	
	wait for 50 ps; 
	
	-- for the rest of the steps, as sel_sum is using data and sel_acc is using sum we can 
	-- just update data to add the next number every clock cycle
	
	-- 00000010 + 10000000	
	data <= "10000000";
	wait for 50 ps;	
	-- 10000010 + 01000000
	data <= "01000000";
	wait for 50 ps;	
	-- 11000010 + 00000001
	data <= "00000001";
	wait for 50 ps;	
	-- 11000011 + 00100000
	data <= "00100000";
	wait for 50 ps;	
	assert (ACC = "11100011") report "Part 4 isn't working" severity note;
	
	-- When the required number is achieved, we then disable R1,R2 and ACC so they finish as required
	EN_ACC <= '0';
	EN_R1 <= '0';	
	EN_R2 <= '0';
	wait for 50 ps;
	
	WAIT; -- End of test is to wait forever                                        
END PROCESS always;  
                  
END ControllerDatapath_vhd_arch;
