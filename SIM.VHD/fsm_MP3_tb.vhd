-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fsm_MP3_tb is
end;

architecture bench of fsm_MP3_tb is

  component fsm_MP3
      Port (  clk         : in    std_logic;
              reset       : in    std_logic;
              b_up        : in    std_logic;
              b_down      : in    std_logic;
              b_center    : in    std_logic;
              b_left      : in    std_logic;
              b_right     : in    std_logic;
              play_pause  : out   std_logic;
              restart     : out   std_logic;
              forward     : out   std_logic;
              volume_up   : out   std_logic;
              volume_down : out   std_logic
              );
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal b_up: std_logic;
  signal b_down: std_logic;
  signal b_center: std_logic;
  signal b_left: std_logic;
  signal b_right: std_logic;
  signal play_pause: std_logic;
  signal restart: std_logic;
  signal forward: std_logic;
  signal volume_up: std_logic;
  signal volume_down: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: fsm_MP3 port map ( clk         => clk,
                          reset       => reset,
                          b_up        => b_up,
                          b_down      => b_down,
                          b_center    => b_center,
                          b_left      => b_left,
                          b_right     => b_right,
                          play_pause  => play_pause,
                          restart     => restart,
                          forward     => forward,
                          volume_up   => volume_up,
                          volume_down => volume_down );

  stimulus: process
  begin
  
    -- Put initialisation code here
    reset       <= '1';
    b_up        <= '1';
    b_down      <= '1'; 
    b_center    <= '1';
    b_left      <= '1';
    b_right     <= '1';
    wait for 4*clock_period;
    
    reset       <= '1';
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for 4*clock_period;
    
    reset       <= '0';
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for 4*clock_period;
    
    b_up        <= '1';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '1'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '1';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '1';
    wait for clock_period;
    
    -- Put test bench stimulus code here
    
    --Test play_fwd
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '1';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '1';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '1'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '1';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '1';
    wait for clock_period;
    
    --Test Pause part 1
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '1';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '1';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '1'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '1';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '1';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    -- Test Play_bwd
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '1';
    b_right     <= '0';
    wait for clock_period;
        
    b_up        <= '1';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '1'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    -- Test Pause part 2
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '1';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    --Test Stop
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '1';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '1';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '1'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '1';
    b_right     <= '0';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '0';
    b_left      <= '0';
    b_right     <= '1';
    wait for clock_period;
    
    b_up        <= '0';
    b_down      <= '0'; 
    b_center    <= '1';
    b_left      <= '0';
    b_right     <= '0';
    wait for clock_period;
    
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '1', '0' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;