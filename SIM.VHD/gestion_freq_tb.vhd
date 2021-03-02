-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity gestion_freq_tb is
end;

architecture bench of gestion_freq_tb is

  component gestion_freq
      Port (  clk             : in    std_logic;
              reset           : in    std_logic;
              ceAffichage     : out   std_logic;
              cePerception    : out   std_logic
              );
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal ceAffichage: std_logic;
  signal cePerception: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: gestion_freq port map ( clk          => clk,
                               reset        => reset,
                               ceAffichage  => ceAffichage,
                               cePerception => cePerception );

  stimulus: process
  begin
  
    -- Put initialisation code here
    reset <= '1';
    wait for 1 us;

    -- Put test bench stimulus code here
    reset <= '0';
    wait for 200 ms;
    
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