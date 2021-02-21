----------------------------------------------------------------------------------
-- Author:        Ferrari Nico
--
-- Description:   Echo pulse analyzer
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity echo_module is

    port (
        clock_in     : in  std_logic;
        pulse_in     : in  std_logic;
        duration_out : out std_logic_vector(15 downto 0) := (others => '0')
    );

end echo_module;

architecture Behavioral of echo_module is

begin
    process(clock_in, pulse_in)
        
        variable duration : integer := 0;
        variable counting : std_logic := '0';
        variable timeout  : std_logic := '0';
    begin
        if clock_in'event and clock_in = '1' then    

            -- count the length
            if pulse_in = '1' and timeout = '0' then
            
                if counting = '0' then
                    duration := 1;
                    counting := '1';
                else       
                    duration := duration + 1;
                end if;
                
            -- low, set the duration out signal
            elsif pulse_in = '0' then
    
                counting := '0';
                timeout := '0';
                duration_out <= std_logic_vector(to_unsigned(duration, 16));
                
            end if;

            -- start timeout as written in references
            if duration >= 30000 then
            
                timeout := '1';
                duration := 0;
                duration_out <= (others => '0');
                
            end if;
        end if;
    end process;
end Behavioral;
