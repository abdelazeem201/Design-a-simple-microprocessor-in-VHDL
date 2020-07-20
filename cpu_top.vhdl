--*****************************************************************************
--
--  Title   : Top-level design for Simple CPU + memory + display
--
--  File    : cpu.vhd
--
--*****************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cpu_top is
  port( clk      : in  std_logic; -- cpu clock
        clk50    : in std_logic;  -- display clock (50 MHz)
        reset    : in  std_logic;
        an       : out std_logic_vector(3 downto 0); -- Anode for 7-segment display
        CA, CB, CC, CD, CE, CF, CG : out  std_logic  -- 7-segment display cathodes
        );
end cpu_top;

architecture rtl of cpu_top is

       signal  wr_en: std_logic := '1';
       signal  dr   : std_logic_vector( 7 downto 0) := (others => '0'); -- Data from the memory
       signal  dw   : std_logic_vector( 7 downto 0) := (others => '0'); -- Data to the memory
       signal  addr : std_logic_vector( 7 downto 0) := (others => '0'); -- Memory address
       signal pc_out   : std_logic_vector( 7 downto 0); -- Program counter value
       signal accu_out : std_logic_vector( 7 downto 0);  -- Accumulator value

       signal output : std_logic_vector (15 downto 0);
       
       component procram
         port(
           A     : in  std_logic_vector(7 downto 0);
           DI    : in  std_logic_vector(7 downto 0);
           RESET : in  std_logic;
           WR_EN : in  std_logic;
           CLK   : in  std_logic;
           DO    : out std_logic_vector(7 downto 0));
       end component;

       component cpu
         port( clk      : in  std_logic;
               reset    : in  std_logic;
               wr_en    : out  std_logic;
               dr       : in  std_logic_vector( 7 downto 0); -- Data from the memory
               dw       : out std_logic_vector( 7 downto 0); -- Data to the memory
               addr     : out std_logic_vector( 7 downto 0); -- Memory address
               pc_out   : out std_logic_vector( 7 downto 0); -- Program counter value
               accu_out : out std_logic_vector( 7 downto 0)  -- Accumulator value
               );
         end component; 

         component disp4
           Port (
           clk:       in std_logic;
           disp_in :  in  std_logic_vector(15 downto 0);
           an : out std_logic_vector (3 downto 0);
           CA, CB, CC, CD, CE, CF, CG : out std_logic);           
         end component;  

begin  --  rtl 

  output <= pc_out & accu_out;
  
  cpu_inst: cpu
    port map(
      clk => clk,
      reset => reset,
      wr_en => wr_en,
      dr => dr,
      dw => dw,
      addr => addr, 
      pc_out => pc_out,
      accu_out => accu_out
      );

  mem_inst: procram
    port map(
      A => addr,
      DI => dw,
      RESET => reset,
      WR_EN => wr_en,
      CLK => clk,
      DO => dr
     );

  display : disp4
    port map( clk50, output, an, CA, CB, CC, CD, CE, CF, CG);


end rtl;
