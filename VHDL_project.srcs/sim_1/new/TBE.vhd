
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TBE is
--  Port ( );
end TBE;

architecture Behavioral of TBE is
    -- RAM configuration
    constant ram_length  : integer := 512;
    constant ram_depth   : integer := 8;
    constant ram_addrlen : integer := 9;
    
    signal clk : std_logic := '0';
    constant half_period : time := 50 ns;
    
    signal res : std_logic := '1';
    signal read_enable_sig : std_logic;
    signal write_enable_sig : STD_LOGIC;
    signal read_address_sig : STD_LOGIC_VECTOR(8 downto 0);
    signal write_address_sig : STD_LOGIC_VECTOR(8 downto 0);
    signal write_data_sig : STD_LOGIC_VECTOR(7 downto 0);
    signal read_data_sig : STD_LOGIC_VECTOR(7 downto 0);
begin
    clk <= not clk after half_period;
    res <= '1', '0' after 200ns;

    RAM_MOD: 
        entity work.ram_module
        generic map(
            ram_length  => ram_length,
            ram_depth   => ram_depth,
            ram_addrlen => ram_addrlen
        )
        port map(
            clock_in => clk,
            read_en  => read_enable_sig,
            write_en  => write_enable_sig,
            read_addr => read_address_sig,
            write_addr => write_address_sig,
            write_data => write_data_sig,
            read_data => read_data_sig,
            reset => res
        );
     test_bench : 
        entity work.TBM
           port map (
               clock => clk,
               reset => res,
               read_enable => read_enable_sig,
               write_enable => write_enable_sig,
               read_address => read_address_sig,
               write_address => write_address_sig,
               write_data => write_data_sig,
               read_data => read_data_sig
           );

end Behavioral;
