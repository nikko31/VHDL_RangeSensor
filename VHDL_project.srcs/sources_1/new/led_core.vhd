----------------------------------------------------------------------------------
-- Author:        Ferrari Nico
--
-- Description:   LED core, for LED meter
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity led_core is
port(
        -- signals
        clock_in   : in  std_logic;
        -- data signal
        data_in    : in  std_logic_vector(15 downto 0) := (others => '0');
        led_out    : out std_logic_vector(15 downto 0) := (others => '0')
    );
end led_core;

architecture Behavioral of led_core is

begin

 -- SRF05 LED meter
   led_meter_bar:
   process(clock_in)

       variable num : integer := 0;
       variable data : integer := 0;

   begin
   
       if clock_in'event and clock_in = '1' then
                  
           num := 0;
           data := to_integer(unsigned(data_in));
          
           case data is
               when   0        => num := 0;
               when   1 to  30 => num := 1;
               when  31 to  60 => num := 3;
               when  61 to  90 => num := 7;
               when  91 to 120 => num := 15; 
               when 121 to 150 => num := 31;
               when 151 to 180 => num := 63;
               when 181 to 210 => num := 127;
               when 211 to 240 => num := 255;
               when 241 to 270 => num := 511;
               when 271 to 300 => num := 1023;
               when 301 to 330 => num := 2047;
               when 331 to 360 => num := 4095;
               when 361 to 390 => num := 8191;
               when 391 to 420 => num := 16383;
               when 421 to 450 => num := 32767;
               when others => num := 52428; -- out-of-range pattern
           end case;
           
           led_out <= std_logic_vector(to_unsigned(num, 16));

       end if;
   end process;

end Behavioral;
