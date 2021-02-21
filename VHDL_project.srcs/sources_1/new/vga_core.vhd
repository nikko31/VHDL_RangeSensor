----------------------------------------------------------------------------------
-- Author:        Ferrari Nico
--
-- Description:    VGA functionalities
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


entity vga_core is

    port(
        -- signals
        clock_in   : in  std_logic;
        clock_slow : in  std_logic;
        reset_in   : in  std_logic;
        central_btn  : in  std_logic;
        -- data signal
        data_in    : in  std_logic_vector(15 downto 0) := (others => '0');
        -- VGA
        vga_hsync  : out std_logic := '0';
        vga_vsync  : out std_logic := '0';
        vga_red    : out std_logic_vector(3 downto 0) := (others => '0');
        vga_blue   : out std_logic_vector(3 downto 0) := (others => '0');
        vga_green  : out std_logic_vector(3 downto 0) := (others => '0')    
    );

end vga_core;

architecture Behavioral of vga_core is

    -- VGA signals
    signal int_disp_en   : std_logic := '0';
    signal int_rowsel    : integer   := 0;
    signal int_colsel    : integer   := 0;    
    signal int_red       : std_logic_vector(3 downto 0) := (others => '0');
    signal int_green     : std_logic_vector(3 downto 0) := (others => '0');
    signal int_blue      : std_logic_vector(3 downto 0) := (others => '0');
    signal int_red2      : std_logic_vector(3 downto 0) := (others => '0');
    signal int_green2    : std_logic_vector(3 downto 0) := (others => '0');
    signal int_blue2     : std_logic_vector(3 downto 0) := (others => '0');
    -- RAM generics
    constant ram_length  : integer := 512;
    constant ram_depth   : integer := 9;
    constant ram_addrlen : integer := 9;
    
    -- FLAG generics
    constant h_green    : integer := 426; --len / 3
    constant h_white    : integer := 852; --len /3 *2

    -- RAM
    signal read_addr     : std_logic_vector(ram_addrlen-1 downto 0) := (others => '0');
    signal read_data     : std_logic_vector(ram_depth-1 downto 0)   := (others => '0');
    signal write_data    : std_logic_vector(ram_depth-1 downto 0)   := (others => '0');

    -- Graphics 
    constant graph_x   : integer   := 430; 
    constant graph_y   : integer   := 300; 
    constant graph_w   : integer   := ram_length;
    constant graph_h   : integer   := 512;
 

   
begin

    RAM_CONTROLLER: 
        entity work.ram_ctrl_module
        generic map(
            ram_length  => ram_length,
            ram_depth   => ram_depth,
            ram_addrlen => ram_addrlen
        )
        port map(
            clock_in   => clock_in,
            write_data => write_data,
            read_addr  => read_addr,
            read_data  => read_data
        );

    VGA_CONTROLLER: 
        entity work.vga_ctrl_module 

        port map(
            pixel_clk => clock_in,
            reset_n   => reset_in,
            h_sync    => vga_hsync,
            v_sync    => vga_vsync,
            disp_ena  => int_disp_en,
            column    => int_colsel,
            row       => int_rowsel
        );

    FLAG_PATTERN_I: 
        entity work.italian_flag_pattern 
        generic map( 
            h_green    => h_green,
            h_white    => h_white
        )
        port map(
            enable_in => int_disp_en,
            row       => int_rowsel,
            column    => int_colsel,
            red       => int_red,
            green     => int_green,
            blue      => int_blue
        );
    FLAG_PATTERN_N: 
        entity work.norwegian_flag_pattern 
        port map(
            enable_in => int_disp_en,
            row       => int_rowsel,
            column    => int_colsel,
            red       => int_red2,
            green     => int_green2,
            blue      => int_blue2
    );    



    --
    -- Data storage process
    ---- --- -- - - - - - - - - - - - - - - - - -    
    storage: 
    process(clock_slow)
    begin
        
        if clock_slow'event and clock_slow = '1' then
            if to_integer(unsigned(data_in)) > 450 then
                write_data <= std_logic_vector(to_unsigned(450, ram_depth));                            
            else
                write_data <= std_logic_vector(resize(unsigned(data_in), ram_depth));    
            end if;        
        end if;
        
    end process;
    
    --
    -- Graphics process
    ---- --- -- - - - - - - - - - - - - - - - - -    
    print_graph: 
    process(clock_in)
        variable data      : integer := 0;            
    begin
    
        if clock_in'event and clock_in = '1' then
            
                   
            -- Draw graphics
            -- is we are into the rectangle
            
            --to avoid initial delay we advance the addres request 
            if (int_colsel +2  >= graph_x) and (int_colsel +2  < (graph_x+graph_w)) then
                read_addr <= std_logic_vector(to_unsigned(ram_length - (int_colsel +2  - graph_x), ram_addrlen));
            end if;
            
            -- read from RAM
            data := to_integer(unsigned(read_data));
            if (int_colsel >= graph_x) and (int_colsel < (graph_x+graph_w)) then
                

                --read_addr <= std_logic_vector(to_unsigned((int_colsel - graph_x), ram_addrlen));                            
                --read_addr <= std_logic_vector(to_unsigned(ram_length - (int_colsel - graph_x), ram_addrlen));
                
                -- plot bar graph
                if (int_rowsel >= (graph_h+graph_y-data)) and (int_rowsel < (graph_h+graph_y)) then
                        vga_red   <= (others => '0');
                        vga_green <= (others => '0');
                        vga_blue  <= (others => '0'); 
                -- plot background
                else
                    if central_btn = '0' then
                        vga_red   <= int_red;
                        vga_green <= int_green;
                        vga_blue  <= int_blue;    
                    else
                        vga_red   <= int_red2;
                        vga_green <= int_green2;
                        vga_blue  <= int_blue2;      
                    end if;          
                end if;
            
            -- background:
            else
                if central_btn = '0' then
                    vga_red   <= int_red;
                    vga_green <= int_green;
                    vga_blue  <= int_blue;    
                else
                    vga_red   <= int_red2;
                    vga_green <= int_green2;
                    vga_blue  <= int_blue2;      
                end if;                 
            end if;
        
        end if;    
    
    end process;    
    
end Behavioral;
