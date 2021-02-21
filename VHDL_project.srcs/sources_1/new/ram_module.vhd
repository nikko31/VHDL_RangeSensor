----------------------------------------------------------------------------------
-- Author:        Ferrari Nico
--
-- Description:   block RAM module
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ram_module is

    generic(
        ram_length  : integer;
        ram_depth   : integer;
        ram_addrlen : integer
    );
       port(
        clock_in    : in  std_logic;
        read_en     : in  std_logic;
        reset       : in  std_logic;
        write_en    : in  std_logic;
        read_addr   : in  std_logic_vector(ram_addrlen-1 downto 0) := (others => '0');
        write_addr  : in  std_logic_vector(ram_addrlen-1 downto 0) := (others => '0');
        write_data  : in  std_logic_vector(ram_depth-1 downto 0) := (others => '0');
        read_data   : out std_logic_vector(ram_depth-1 downto 0) := (others => '0')
    );
    
end ram_module;

architecture Behavioral of ram_module is

    subtype ram_data is std_logic_vector(ram_depth-1 downto 0);
    type ram_type is array(0 to ram_length-1) of ram_data;
    
    -- create RAM array
    signal ram : ram_type := (others => (others => '0'));
begin
    process(clock_in,reset)
    begin
        if (reset = '1') then
            ram <= (others => (others => '0'));
            read_data <= (others => '0');
        elsif rising_edge(clock_in) then
    
            if write_en = '1' then            
                ram(to_integer(unsigned(write_addr))) <= write_data;
            end if;

            if read_en = '1' then
                read_data <= ram(to_integer(unsigned(read_addr)));
            end if;
                        
        end if;
    
    end process;
end Behavioral;
