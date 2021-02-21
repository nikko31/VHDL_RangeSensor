----------------------------------------------------------------------------------
-- Author:        Ferrari Nico
--
-- Description:   7-segment display
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity sevSeg_core is

    port (
        clock_in     : in  std_logic;
        binary_in    : in  std_logic_vector(15 downto 0);
        segment_out  : out std_logic_vector(6 downto 0) := (others => '0');
        position_out : out std_logic_vector(3 downto 0) := (others => '1')
    );

end sevSeg_core;

architecture Behavioral of sevSeg_core is

    signal bcd0, bcd1, bcd2, bcd3 : std_logic_vector(3 downto 0);
    
begin
    
    BIN2BCD_MODULE: 
        entity work.bin_to_4bcd_module 
        port map (
            binary_in => binary_in,
            bcd0 => bcd0,
            bcd1 => bcd1,
            bcd2 => bcd2,
            bcd3 => bcd3
        );
    
    
    -- 7-segment display
    seven_segment_display:
    process(clock_in, bcd0, bcd1, bcd2, bcd3)
    
        type bcd_array is array(3 downto 0) of std_logic_vector(3 downto 0); 
        variable bcd : bcd_array := (bcd0, bcd1, bcd2, bcd3);
        
        variable seg_position : integer := 0;
        variable clk_counter  : integer := 1;
    
    begin

        bcd := (bcd0, bcd1, bcd2, bcd3);
        
        if clock_in'event and clock_in = '1' then 

            if clk_counter >= 1000 then -- 1000 * 1us = 1 kHz update

                -- iterate trough each of the positions
                if seg_position < 4 then
                                                       
                    -- convert BCD into 7-segment                 
                    case bcd(seg_position) is       -- abcdefg
                        when "0000" => segment_out <= "0000001";  -- 0
                        when "0001" => segment_out <= "1001111";  -- 1
                        when "0010" => segment_out <= "0010010";  -- 2
                        when "0011" => segment_out <= "0000110";  -- 3
                        when "0100" => segment_out <= "1001100";  -- 4 
                        when "0101" => segment_out <= "0100100";  -- 5
                        when "0110" => segment_out <= "0100000";  -- 6
                        when "0111" => segment_out <= "0001111";  -- 7
                        when "1000" => segment_out <= "0000000";  -- 8
                        when "1001" => segment_out <= "0000100";  -- 9
                        when others => segment_out <= "1111111"; 
                    end case;
                    
                    -- set the 7-segment position                 
                    case seg_position is
                        when 0 => position_out <= "0111";
                        when 1 => position_out <= "1011";
                        when 2 => position_out <= "1101";
                        when 3 => position_out <= "1110";
                        when others => position_out <= "1111"; 
                    end case;
                               
                    seg_position := seg_position + 1;                    
                    clk_counter := 1;
                    
                else
                    seg_position := 0;
                end if;
                
            else             
                clk_counter := clk_counter + 1;            
            end if;
            
        end if; -- clock

    end process;    

end Behavioral;
