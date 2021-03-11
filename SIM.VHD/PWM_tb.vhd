-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PWM_tb is
end;

architecture bench of PWM_tb is

  component PWM
      Port (  clk     : in    std_logic;
              reset   : in    std_logic;
              ce      : in    std_logic;
              idata_n : in    std_logic_vector(10 downto 0);
              odata   : out   std_logic
              );
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal ce: std_logic;
  signal idata_n: std_logic_vector(10 downto 0);
  signal odata: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: PWM port map ( clk     => clk,
                      reset   => reset,
                      ce      => ce,
                      idata_n => idata_n,
                      odata   => odata );

  stimulus: process
  begin
  
    -- Put initialisation code here
    reset   <= '1';
    idata_n <= "10000000000"; -- -1024
    
    wait for 1*clock_period;
    
    -- Put test bench stimulus code here
    reset   <= '0';
    wait for 2067*2766*clock_period;
    
    idata_n <= "00000000000"; -- 0
    wait for 2067*2767*clock_period; --2067 : valeur max
    
    idata_n <= "01111111111"; -- 1023
    wait for 2067*2767*clock_period;
    
    idata_n <= "00111111111"; -- 511
    wait for 2067*2767*clock_period;
    
    idata_n <= "00000000000"; -- 0
    
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
      ce <= '1';
      ce <= '0' after clock_period;
      wait for 2767*clock_period;
    end loop;
    wait;
  end process;
  
end;