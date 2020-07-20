--*****************************************************************************
-- Company: Faculty of Engineering Zagazig University
-- Engineer: Ahmed Abdelazeem
-- 
-- Create Date:    03:15:35 07/20/2020 
-- Design Name: 7-segment display
-- Module Name:    disp4 
-- Project Name: Design a simple microprocessor in VHDL
-- Target Devices: 
-- Tool versions: 
-- Description:  Converts a std_logic_vector(15 downto 0)
--                 to a four-digit seven segment hex display output
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--**************************************************************************
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity disp4 is
    Port (
           clk:       in std_logic;
           disp_in :  in  std_logic_vector(15 downto 0);
           an : out std_logic_vector (3 downto 0);
           CA, CB, CC, CD, CE, CF, CG : out std_logic);
end disp4;

architecture Behavioral of disp4 is

procedure display_digit 
	(signal digit: in std_logic_vector (3 downto 0);
	 signal A, B, C, D, E, F, G : out std_logic) is

	 begin

    case digit is
		 when "0000" =>    -- 0
			A <= '0'; B <= '0'; C <= '0'; D <= '0'; 
			E <= '0'; F <= '0'; G <= '1';    -- 0
		 when "0001" =>    -- 1 
			A <= '1'; B <= '0'; C <= '0'; D <= '1'; 
			E <= '1'; F <= '1'; G <= '1';    -- 1
		 when "0010" =>		-- 02
			A <= '0'; B <= '0'; C <= '1'; D <= '0'; 
			E <= '0'; F <= '1'; G <= '0';    -- 2	    
		 when "0011" =>		-- 03
			A <= '0'; B <= '0'; C <= '0'; D <= '0'; 
			E <= '1'; F <= '1'; G <= '0'; 	  -- 3 
		 when "0100" =>		-- 04
			A <= '1'; B <= '0'; C <= '0'; D <= '1'; 
			E <= '1'; F <= '0'; G <= '0';    -- 4 	    
		 when "0101" =>		-- 05
			A <= '0'; B <= '1'; C <= '0'; D <= '0'; 
			E <= '1'; F <= '0'; G <= '0';    -- 5
		 when "0110" =>		-- 06
			A <= '0'; B <= '1'; C <= '0'; D <= '0'; 
			E <= '0'; F <= '0'; G <= '0'; 	  -- 6
		 when "0111" =>		-- 07
			A <= '0'; B <= '0'; C <= '0'; D <= '1'; 
			E <= '1'; F <= '1'; G <= '1';    -- 7  
		 when "1000" =>		-- 08
			A <= '0'; B <= '0'; C <= '0'; D <= '0'; 
			E <= '0'; F <= '0'; G <= '0';    -- 8 	    
		 when "1001" =>		-- 09
			A <= '0'; B <= '0'; C <= '0'; D <= '0'; 
			E <= '1'; F <= '0'; G <= '0';    -- 9 	    
		 when "1010" =>		-- A
			A <= '0'; B <= '0'; C <= '0'; D <= '1'; 
			E <= '0'; F <= '0'; G <= '0';	   
		 when "1011" =>		-- B
			A <= '1'; B <= '1'; C <= '0'; D <= '0'; 
			E <= '0'; F <= '0'; G <= '0';     
		 when "1100" =>	   -- C
			A <= '0'; B <= '1'; C <= '1'; D <= '0'; 
			E <= '0'; F <= '0'; G <= '1';     	    
		 when "1101" =>	   -- D
			A <= '1'; B <= '0'; C <= '0'; D <= '0'; 
			E <= '0'; F <= '1'; G <= '0'; 	  
		 when "1110" =>		-- E
			A <= '0'; B <= '1'; C <= '1'; D <= '0'; 
			E <= '0'; F <= '0'; G <= '0';    	    
		 when "1111" =>		-- F
			A <= '0'; B <= '1'; C <= '1'; D <= '1'; 
			E <= '0'; F <= '0'; G <= '0';    
		 when others => null;
   end case;
 end display_digit;

type digit_array is array (3 downto 0) of std_logic_vector (3 downto 0);

signal digit: digit_array;

begin 
  
 gen0 : for i in 0 to 3 generate
	digit(i) <= disp_in (((4*i)+3) downto (4*i));
 end generate;
  
 selector: process (clk, digit)
   variable counter : integer := 0;
	variable place : integer := 0;
  begin 
   if rising_edge(clk) then
     counter := counter + 1;
     if (counter > 50000) then
       counter := 0;
       place := place + 1;
		 if place > 3 then
			place := 0;
		 end if;
     end if;
   end if;   

	-- select digit to display

	if (place = 0) then 
		an <= "1110";
		display_digit(digit(0),CA,CB,CC,CD,CE,CF,CG);
	elsif (place = 1) then
		an <= "1101";
		display_digit(digit(1),CA,CB,CC,CD,CE,CF,CG);
	elsif (place = 2) then
		an <= "1011";
		display_digit(digit(2),CA,CB,CC,CD,CE,CF,CG);
	else
		an <= "0111";
		display_digit(digit(3),CA,CB,CC,CD,CE,CF,CG);
	end if;

	
 end process selector;   
 
end Behavioral;
