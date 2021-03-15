-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity lecteur_echantillon_tb is
end;

architecture bench of lecteur_echantillon_tb is

  component lecteur_echantillon
      Port (  CLK100MHZ   : in    std_logic;
              reset       : in    std_logic;
              AUD_PWM     : out   std_logic;
              AUD_SD      : out   std_logic
              );
  end component;

  signal CLK100MHZ: std_logic;
  signal reset: std_logic;
  signal AUD_PWM: std_logic;
  signal AUD_SD: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;
  
begin

  uut: lecteur_echantillon port map ( CLK100MHZ => CLK100MHZ,
                                      reset     => reset,
                                      AUD_PWM   => AUD_PWM,
                                      AUD_SD    => AUD_SD );

  stimulus: process
  begin
  
    -- Put initialisation code here
    reset <= '0';
    
    wait for 10*clock_period;
    reset <= '1';
    -- Put test bench stimulus code here
    
    
  
    wait;
  end process;
  
  clocking: process
  begin
    while not stop_the_clock loop
      CLK100MHZ <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;