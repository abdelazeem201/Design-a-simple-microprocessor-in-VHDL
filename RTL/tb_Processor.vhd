LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY tb_Processor IS
END tb_Processor;
 
ARCHITECTURE behavior OF tb_Processor IS 
    -- Component Declaration for the single-cycle MIPS Processor in VHDL
    COMPONENT Processor
    PORT(
         clk : IN  std_logic;
         current_instruction : OUT  std_logic_vector(2 downto 0);
         value : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal clk : std_logic := '0';
   --Outputs
   signal current_instruction : std_logic_vector(2 downto 0);
   signal value : std_logic_vector(7 downto 0);
   -- Clock period definitions
   constant clk_period : time := 10 ns;
BEGIN
 -- Instantiate the for the single-cycle Processor in VHDL
   uut: Processor PORT MAP (
          clk => clk,
          value => value,
          current_instruction => current_instruction
        );

   -- Clock process definitions
   clk_process :process
   begin
  clk <= '0';
  wait for clk_period/2;
  clk <= '1';
  wait for clk_period/2;
   end process;
   -- Stimulus process
   stim_proc: process
   begin  
      wait for 100 ns;
      
	  wait for clk_period*10;
      -- insert stimulus here 
      wait;
   end process;

END;