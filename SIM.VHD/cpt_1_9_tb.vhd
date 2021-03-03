-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity cpt_1_9_tb is
end;

architecture bench of cpt_1_9_tb is

  component cpt_1_9
      Port (  clk     : in    std_logic;
              reset   : in    std_logic;
              inc     : in    std_logic;
              dec     : in    std_logic;
              value   : out   std_logic_vector(3 downto 0)
              );
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal inc: std_logic;
  signal dec: std_logic;
  signal value: std_logic_vector(3 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: cpt_1_9 port map ( clk   => clk,
                          reset => reset,
                          inc   => inc,
                          dec   => dec,
                          value => value );

  stimulus: process
  begin
  
    -- Put initialisation code here
    reset   <= '1';
    inc     <= '0';
    dec     <= '0';
    wait for 4*clock_period;

    -- Put test bench stimulus code here
    reset   <= '0';
    wait for 2*clock_period;
    
    inc     <= '0';
    dec     <= '1';
    wait for 4*clock_period;
    
    inc     <= '1';
    dec     <= '1';
    wait for 4*clock_period;
    
    inc     <= '1';
    dec     <= '0';
    wait for 4*clock_period;
    
    inc     <= '1';
    dec     <= '1';
    wait for 2*clock_period;
    
    inc     <= '0';
    dec     <= '0';
    wait for 4*clock_period;
    
    inc     <= '1';
    dec     <= '0';
    wait for 10*clock_period;

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