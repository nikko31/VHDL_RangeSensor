----------------------------------------------------------------------------------
-- Author:        Ferrari Nico
--
-- Description:   Pulse generator
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity pulse_gen_module is

    port (
        clock_in  : in  std_logic;
        enable_in : in  std_logic;
        pwidth_in : in  std_logic_vector(3 downto 0) := (others => '0');
        pulse_out : out std_logic := '0'
    );

end pulse_gen_module;

architecture Behavioral of pulse_gen_module is

begin
    
    process(clock_in, enable_in, pwidth_in)
    
        constant pls_length  : integer := 100000;  
        variable pls_width   : integer := 10;
        variable pls_counter : integer := 1;
        variable clk_pulse   : std_logic := '0';
            
    begin

        if clock_in'event and clock_in = '1' and enable_in = '1' then  
        
            -- pulse width between 10 and 20, we can change it using pwidth_in, if it is bigger than 10
            -- trigger pulse is setted to the maximum value (20)
            
            if to_integer(unsigned(pwidth_in)) > 10 then 
                pls_width := 20;
            else
                pls_width := to_integer(unsigned(pwidth_in)) + 10; 
            end if;
                
            -- trigger pulse controller
            if pls_counter < pls_width then
                pulse_out <= '1';
            elsif pls_counter > pls_width then
                pulse_out <= '0';
            end if;
            
            -- control the period:
            -- we are using a slow clock 1mhz, to obtain the racomended 
            -- trigger frequency (10hz -> 0.1s) we have to wait 100000 clock cycles
            if pls_counter >= pls_length then
                pls_counter := 1;
            else
                pls_counter := pls_counter + 1;
            end if;
        
        end if;    
    
    end process;

end Behavioral;
