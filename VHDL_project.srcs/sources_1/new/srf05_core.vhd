----------------------------------------------------------------------------------
-- Author:        Ferrari Nico
--
-- Description:   SRF05 core, handles all the sensor functionality
----------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all; 

entity srf05_core is

    port (
        clock_in       : in  std_logic := '0';
        enable_in      : in  std_logic := '0';
        echo_pulse_in  : in  std_logic := '0';
        inc_pwidth_in  : in  std_logic := '0';
        trig_pulse_out : out std_logic := '0';
        distance_out   : out std_logic_vector(15 downto 0) := (others => '0')
    );
    
end srf05_core;

architecture Behavioral of srf05_core is
  
    signal int_duration : std_logic_vector(15 downto 0) := (others => '0');
    
    -- minimum trigger pulse -> 10us
    -- initialize trigger pulse with 5 -> (minimum trigger pulse) + 5 us -> 15 us trigger pulse
    signal int_pwidth : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(5, 4));     
    
begin
    
    ECHO_MODULE: 
        entity work.echo_module 
        port map(
            clock_in  => clock_in,
            pulse_in  => echo_pulse_in,
            duration_out => int_duration
        );
    
    PULSE_MODULE: 
        entity work.pulse_gen_module 
        port map(
            clock_in  => clock_in,
            enable_in => enable_in,
            pwidth_in => int_pwidth,
            pulse_out => trig_pulse_out
        );
    
    DIV_MODULE: 
        entity work.divider_module 
        port map (
            clock_in  => clock_in,
            data_in   => int_duration,
            data_out  => distance_out
        );
        
    increment_pwidth: 
    process(inc_pwidth_in)
    begin
        if inc_pwidth_in = '1' then
            int_pwidth <= std_logic_vector(to_unsigned(10, 4));
        else
            int_pwidth <= std_logic_vector(to_unsigned(5, 4));
        end if;
    end process;

end Behavioral;
