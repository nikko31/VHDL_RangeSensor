
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_7seg is
end testbench_7seg;

architecture Testbench of testbench_7seg is

    signal clock_slow    : std_logic := '0';
    signal distance_in   : std_logic_vector(15 downto 0) := (others => '0');
    signal lcd_segment   : std_logic_vector(6 downto 0) := (others => '0');
    signal lcd_position  : std_logic_vector(3 downto 0) := (others => '1');
    signal led_out       : std_logic_vector(15 downto 0) := (others => '0');
    
    constant clock_pulse : time := 1 us; -- 1 MHz clock

begin

    SEV_SEGMENT: 
        entity work.sevSeg_core 
        port map(
            clock_in     => clock_slow,
            binary_in    => distance_in,
            segment_out  => lcd_segment,
            position_out => lcd_position
        );
    LED: 
        entity work.led_core 
        port map(
            clock_in     => clock_slow,
            data_in    => distance_in,
            led_out    => led_out
        );   

    -- Simulate 1 MHz clock pulse
    clock_sim: process
    begin
        clock_slow <= '1';
        wait for clock_pulse/2;
        clock_slow <= '0';
        wait for clock_pulse/2;
    end process;            

    -- send data
    dummy_data: process
    begin
        distance_in <= std_logic_vector(to_unsigned(100, 16));
        wait;
    end process;            


end Testbench;