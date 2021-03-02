-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity cpt_1_599_tb is
end;

architecture bench of cpt_1_599_tb is

  component cpt_1_599
      Port (  clk     : in    std_logic;
              reset   : in    std_logic;
              ce      : in    std_logic;
              init    : in    std_logic;
              start   : in    std_logic;
              forward : in    std_logic;
              value   : out   std_logic_vector(9 downto 0)
              );
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal ce: std_logic;
  signal init: std_logic;
  signal start: std_logic;
  signal forward: std_logic;
  signal value: std_logic_vector(9 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: cpt_1_599 port map ( clk     => clk,
                            reset   => reset,
                            ce      => ce,
                            init    => init,
                            start   => start,
                            forward => forward,
                            value   => value );

  stimulus: process
  begin
  
    -- Put initialisation code here
    reset   <= '1';
    init    <= '1';
    start   <= '0';
    forward <= '0';
    wait for 4*clock_period;
    
    -- Put test bench stimulus code here
    reset   <= '0';
    wait for 10*clock_period;
    
    init <= '0';
    wait for 10*clock_period;
    
    start   <= '1';
    wait for 10*clock_period;
    
    forward <= '1';
    wait for 100*clock_period;
    
    start   <= '0';
    wait for 10*clock_period;
    
    start   <= '1';
    forward <= '0';
    wait for 10*clock_period;
    
    forward <= '1';
    wait for 10*clock_period;
    
    init <= '1';
    wait for 2*clock_period;
    
    init <= '0';
    wait for 1500*clock_period;
    
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

  clock_enable: process
  begin
    while not stop_the_clock loop
      ce <= '0';
      ce <= '1' after clock_period;
      wait for 2*clock_period;
    end loop;
    wait;
  end process;
  
end;