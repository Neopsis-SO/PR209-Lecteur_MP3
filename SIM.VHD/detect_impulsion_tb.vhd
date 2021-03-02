-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity detect_impulsion_tb is
end;

architecture bench of detect_impulsion_tb is

  component detect_impulsion
      Port (  clk         : in    std_logic;
              data_in     : in    std_logic;
              data_out    : out   std_logic
              );
  end component;

  signal clk: std_logic;
  signal data_in: std_logic;
  signal data_out: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: detect_impulsion port map ( clk      => clk,
                                   data_in  => data_in,
                                   data_out => data_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
    data_in <= '0';
    wait for  2*clock_period;
    -- Put test bench stimulus code here
    data_in <= '1';
    wait for  4*clock_period;
    
    data_in <= '0';
    wait for  2*clock_period;
    
    data_in <= '1';
    wait for  4*clock_period;
    
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