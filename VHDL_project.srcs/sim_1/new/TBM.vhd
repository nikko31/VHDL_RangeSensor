
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity TBM is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           read_data : in STD_LOGIC_VECTOR(7 downto 0);
           read_enable : out STD_LOGIC;
           read_address : out STD_LOGIC_VECTOR(8 downto 0);
           write_enable : out STD_LOGIC;
           write_address : out STD_LOGIC_VECTOR(8 downto 0);
           write_data : out STD_LOGIC_VECTOR(7 downto 0)
           );
end TBM;

architecture Behavioral of TBM is

type state_enum is (write, waiting, read);
type tbm_state is
record
    fsm_state : state_enum;
    write_data : std_logic_vector(7 downto 0);    
    read_data : std_logic_vector(7 downto 0); 
    address : std_logic_vector(9 downto 0);
end record;

signal state: tbm_state;

signal waiting_cnt : std_logic_vector(6 downto 0);

begin

    test_process : process (clock, reset)
    begin
        if (reset = '1') then
            read_enable <= '0';
            read_address <= (others => '0');
            write_enable <= '0';
            write_address <= (others => '0');
            write_data <= (others => '0');
            state.fsm_state <= write;
            state.write_data <= (others => '0');
            waiting_cnt <= (others => '0');
            state.address <= (others => '0');
        elsif rising_edge(clock) then
            case state.fsm_state is
                when write =>                
                
                if state.address = 512 then        
                    state.fsm_state <= waiting;
                    state.address <= (others => '0');  
                    write_enable <= '0';
                    write_address <= (others => '0');
                    write_data <= (others => '0');
                    waiting_cnt <= (others => '0');
                else        
                                 
                    write_address <= state.address(8 downto 0);         
                    write_data <= state.write_data;                  
                    state.address <= state.address + 1;                        
                    state.write_data <= state.write_data + 1;
                    
                    if state.address = 0 then
                        --read_address <= (others => '0');
                        --read_enable <= '0';
                        write_enable <= '1';
                    end if;
                    
                    
                end if;
                           
                                        
                when waiting =>
                    waiting_cnt <= waiting_cnt + 1;
                    
                    if waiting_cnt = 99 then
                        
                        state.read_data <= "11111111";
                        read_enable <= '1';        
                        state.address <= state.address + 1;      
                        state.fsm_state <= read;       
                    
                    end if;                    
                    
                when read =>
                    read_address <= state.address(8 downto 0);                    
                    state.address <= state.address + 1;    
--                    read_data <= state.read_data;
--                    state.read_data <= state.read_data + 1;
                          
                    if state.address = 512 then
                        assert false report "Simulation Finished" severity failure;
                    end if;
                    
--                    if waiting_time = 0 then 
--                        -- controllo dati letti                    
--                        assert read_data = state.read_data
--                        --report "Data read not correct"
                       
--                        report "read_data("&integer'image(0)&") value is"&std_logic'image(read_data(7))&std_logic'image(read_data(6))&std_logic'image(read_data(5))&std_logic'image(read_data(4))&std_logic'image(read_data(3))&std_logic'image(read_data(2))&std_logic'image(read_data(1))&std_logic'image(read_data(0)) & "state.read_data("&integer'image(0)&") value is"&std_logic'image(state.read_data(7))&std_logic'image(state.read_data(6))&std_logic'image(state.read_data(5))&std_logic'image(state.read_data(4))&std_logic'image(state.read_data(3))&std_logic'image(state.read_data(2))&std_logic'image(state.read_data(1))&std_logic'image(state.read_data(0))
                        
--                        severity Warning;
--                    end if;
                                            
            end case;
        end if;
    end process;


end Behavioral;
