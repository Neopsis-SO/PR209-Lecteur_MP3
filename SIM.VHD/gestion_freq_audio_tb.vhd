-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity gestion_freq_audio_tb is
end;

architecture bench of gestion_freq_audio_tb is

  component gestion_freq_audio
      Port (  clk             : in    std_logic;
              reset           : in    std_logic;
              multiplicateur  : in    std_logic_vector(2 downto 0);
              cePWM           : out   std_logic
              );
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal multiplicateur: std_logic_vector(2 downto 0);
  signal cePWM: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: gestion_freq_audio port map ( clk            => clk,
                                     reset          => reset,
                                     multiplicateur => multiplicateur,
                                     cePWM          => cePWM );

  stimulus: process
  begin
    reset <= '1';
    multiplicateur <= "000";
    
    wait for 1 us;

    -- Put test bench stimulus code here
    reset <= '0';
    multiplicateur <= "000";
    wait for 100 us;
    
    multiplicateur <= "001";
    wait for 100 us;
    
    multiplicateur <= "010";
    wait for 100 us;
    
    multiplicateur <= "011";
    wait for 100 us;
    
    multiplicateur <= "100";
    wait for 100 us;
    
    multiplicateur <= "101";
    wait for 100 us;
    
    multiplicateur <= "110";
    wait for 100 us;
    
    multiplicateur <= "111";
    wait for 100 us;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;