library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity procram is
  port(
    A     : in  std_logic_vector(7 downto 0);
    DI    : in  std_logic_vector(7 downto 0);
    RESET : in  std_logic;
    WR_EN : in  std_logic;
    CLK   : in  std_logic;
    DO    : out std_logic_vector(7 downto 0));
end procram;

architecture sim of procram is

-- 16-word blocks of RAM and ROM memory

  type mem_array is array (0 to 15) of std_logic_vector(7 downto 0);
  
  signal ram_data: mem_array := (others => x"00");
  signal rom_data: mem_array := (x"01",x"07",x"03",x"0a",x"02",x"10",x"04",x"02",
                                 x"05",x"00",x"09",x"00",x"00",x"00",x"00",x"00");
 
  begin

    process(clk, WR_EN, RESET, A)
      variable address : integer := 0;
    begin
      address := to_integer(unsigned(a));

      if reset = '1' then
        ram_data <= (others => x"00");
      elsif rising_edge(clk) then
        if ((WR_EN='1') and (address>15) and (address<32)) then
          ram_data (address-16) <= DI; -- Write to RAM address
        end if;
      end if;

      if (address>31) then
        DO <= (others => '0');
      elsif (address>15) then
        DO <= ram_data(address-16); -- Read from RAM address
      else
        DO <= rom_data(address); -- Read from ROM address
      end if; 

    end process;
END sim;
