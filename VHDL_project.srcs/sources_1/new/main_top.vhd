----------------------------------------------------------------------------------
-- Author:        Ferrari Nico
--
-- Description:   Top file
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


entity main_top is
    
    port(
        -- General
        clock_in       : in  std_logic;
        enable_in      : in  std_logic;
        reset_in       : in  std_logic;
        button_in      : in  std_logic;
        -- SRF05
        echo_pulse_in  : in  std_logic;
        inc_pwidth     : in  std_logic;        
        trig_pulse_out : out std_logic;
        -- LCD
        lcd_segment    : out std_logic_vector(6 downto 0) := (others => '0');
        lcd_position   : out std_logic_vector(3 downto 0) := (others => '1');
        
        -- VGA        
        vga_red        : out std_logic_vector(3 downto 0) := (others => '0');
        vga_blue       : out std_logic_vector(3 downto 0) := (others => '0');
        vga_green      : out std_logic_vector(3 downto 0) := (others => '0');
        vga_hsync      : out std_logic := '0';
        led_out        : out std_logic_vector(15 downto 0) := (others => '0');
        vga_vsync      : out std_logic := '0'
    );

end main_top;

architecture Behavioral of main_top is
    
    -- clock signals
    signal clock_vga  : std_logic := '0';
    signal clock_slow : std_logic := '0';
    
    -- sensor signals
    signal int_distance : std_logic_vector(15 downto 0) := (others => '0');
   
begin   

    CLOCK_GEN: 
        entity work.clk_gen 
        port map(
            clock_100mhz_in  => clock_in,
            clock_108mhz_out => clock_vga,
            clock_1mhz_out   => clock_slow
        );

    SRF05: 
        entity work.srf05_core 
        port map(
            clock_in       => clock_slow,
            enable_in      => enable_in,
            echo_pulse_in  => echo_pulse_in,
            inc_pwidth_in  => inc_pwidth,
            trig_pulse_out => trig_pulse_out,
            distance_out   => int_distance
        );

    SEV_SEGMENT: 
        entity work.sevSeg_core 
        port map(
            clock_in     => clock_slow,
            binary_in    => int_distance,
            segment_out  => lcd_segment,
            position_out => lcd_position
        );
    LED: 
                entity work.led_core 
                port map(
                    clock_in   => clock_in,
                    data_in    => int_distance,
                    led_out    => led_out
        );
    
    VGA:
        entity work.vga_core
        port map(
            clock_in   => clock_vga,
            clock_slow => clock_slow,
            reset_in   => reset_in,
            data_in    => int_distance,
            vga_hsync  => vga_hsync,
            vga_vsync  => vga_vsync,
            vga_red    => vga_red,
            vga_blue   => vga_blue,
            vga_green  => vga_green,
            central_btn  => button_in
        );



end Behavioral;
