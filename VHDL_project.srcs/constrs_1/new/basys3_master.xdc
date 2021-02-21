
## Clock signal
set_property PACKAGE_PIN W5 [get_ports clock_in]							
	set_property IOSTANDARD LVCMOS33 [get_ports clock_in]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock_in]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {reset_in}]
	set_property IOSTANDARD LVCMOS33 [get_ports {reset_in}]

set_property PACKAGE_PIN V16 [get_ports {enable_in}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable_in}]
	
set_property PACKAGE_PIN W15 [get_ports {inc_pwidth}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {inc_pwidth}]


## LEDs
set_property PACKAGE_PIN U16 [get_ports {led_out[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[0]}]
	
set_property PACKAGE_PIN E19 [get_ports {led_out[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[1]}]
	
set_property PACKAGE_PIN U19 [get_ports {led_out[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[2]}]
	
set_property PACKAGE_PIN V19 [get_ports {led_out[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[3]}]
	
set_property PACKAGE_PIN W18 [get_ports {led_out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[4]}]
	
set_property PACKAGE_PIN U15 [get_ports {led_out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[5]}]
	
set_property PACKAGE_PIN U14 [get_ports {led_out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[6]}]
	
set_property PACKAGE_PIN V14 [get_ports {led_out[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[7]}]

set_property PACKAGE_PIN V13 [get_ports {led_out[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[8]}]
set_property PACKAGE_PIN V3 [get_ports {led_out[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[9]}]
set_property PACKAGE_PIN W3 [get_ports {led_out[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[10]}]
set_property PACKAGE_PIN U3 [get_ports {led_out[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[11]}]
set_property PACKAGE_PIN P3 [get_ports {led_out[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[12]}]
set_property PACKAGE_PIN N3 [get_ports {led_out[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[13]}]
set_property PACKAGE_PIN P1 [get_ports {led_out[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[14]}]
set_property PACKAGE_PIN L1 [get_ports {led_out[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[15]}]
	
	
## 7 segment display
set_property PACKAGE_PIN W7 [get_ports {lcd_segment[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_segment[6]}]
set_property PACKAGE_PIN W6 [get_ports {lcd_segment[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_segment[5]}]
set_property PACKAGE_PIN U8 [get_ports {lcd_segment[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_segment[4]}]
set_property PACKAGE_PIN V8 [get_ports {lcd_segment[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_segment[3]}]
set_property PACKAGE_PIN U5 [get_ports {lcd_segment[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_segment[2]}]
set_property PACKAGE_PIN V5 [get_ports {lcd_segment[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_segment[1]}]
set_property PACKAGE_PIN U7 [get_ports {lcd_segment[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_segment[0]}]

#set_property PACKAGE_PIN V7 [get_ports dp]							
	#set_property IOSTANDARD LVCMOS33 [get_ports dp]

set_property PACKAGE_PIN U2 [get_ports {lcd_position[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_position[0]}]
set_property PACKAGE_PIN U4 [get_ports {lcd_position[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_position[1]}]
set_property PACKAGE_PIN V4 [get_ports {lcd_position[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_position[2]}]
set_property PACKAGE_PIN W4 [get_ports {lcd_position[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lcd_position[3]}]


##Buttons
## center
set_property PACKAGE_PIN U18 [get_ports {button_in}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {button_in}]

##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {trig_pulse_out}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {trig_pulse_out}]
#Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {echo_pulse_in}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {echo_pulse_in}]


##VGA Connector
set_property PACKAGE_PIN G19 [get_ports {vga_red[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_red[0]}]
set_property PACKAGE_PIN H19 [get_ports {vga_red[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_red[1]}]
set_property PACKAGE_PIN J19 [get_ports {vga_red[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_red[2]}]
set_property PACKAGE_PIN N19 [get_ports {vga_red[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_red[3]}]
set_property PACKAGE_PIN N18 [get_ports {vga_blue[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_blue[0]}]
set_property PACKAGE_PIN L18 [get_ports {vga_blue[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_blue[1]}]
set_property PACKAGE_PIN K18 [get_ports {vga_blue[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_blue[2]}]
set_property PACKAGE_PIN J18 [get_ports {vga_blue[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_blue[3]}]
set_property PACKAGE_PIN J17 [get_ports {vga_green[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_green[0]}]
set_property PACKAGE_PIN H17 [get_ports {vga_green[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_green[1]}]
set_property PACKAGE_PIN G17 [get_ports {vga_green[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_green[2]}]
set_property PACKAGE_PIN D17 [get_ports {vga_green[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vga_green[3]}]
set_property PACKAGE_PIN P19 [get_ports vga_hsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports vga_hsync]
set_property PACKAGE_PIN R19 [get_ports vga_vsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports vga_vsync]


