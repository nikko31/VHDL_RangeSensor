----------------------------------------------------------------------------------
-- Author:        Ferrari Nico
--
-- Description:   print the Italian flag
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity italian_flag_pattern is

    -- horiz limits 
    generic( 
        h_green    : integer;-- := 426;
        h_white    : integer-- := 852
    );
    port(
        enable_in : in  std_logic;  --display enable
        row       : in  integer;    --row pixel coord
        column    : in  integer;    --column pixel coord
        red       : out std_logic_vector(3 downto 0) := (others => '0');  --red magnitude output
        green     : out std_logic_vector(3 downto 0) := (others => '0');  --green magnitude output
        blue      : out std_logic_vector(3 downto 0) := (others => '0')   --blue magnitude output
    );

end italian_flag_pattern;

architecture Behavioral of italian_flag_pattern is

begin 
    
    process(enable_in, row, column)    
    begin
        if enable_in = '1' then
            
            if (column < h_green) then
                red   <= (others => '0');
                green <= (others => '1');
                blue  <= (others => '0');      
            elsif (column < h_white ) then
                red   <= (others => '1');
                green <= (others => '1');
                blue  <= (others => '1');      
            else
                red   <= (others => '1');
                green <= (others => '0');
                blue  <= (others => '0');
            end if;
        else --black screen
            red   <= (others => '0');
            green <= (others => '0');
            blue  <= (others => '0');
        end if;
  end process;

end Behavioral;