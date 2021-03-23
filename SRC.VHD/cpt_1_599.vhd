----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 02.03.2021 14:25:45
-- Design Name: 
-- Module Name: cpt_1_599 - Behavioral
-- Project Name: PR209-Lecteur_MP3
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpt_1_599 is
    Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            ce      : in    std_logic;
            init    : in    std_logic;
            start   : in    std_logic;
            forward : in    std_logic;
            value   : out   std_logic_vector(9 downto 0)
            );
end cpt_1_599;

-- Pour reinitialiser le compteur : init = 1
-- Pour incrementer : start = 1 and forward = 1
-- Pour decrementer : start = 1 and forward = 0
-- Pour s arreter : start = 0
architecture Behavioral of cpt_1_599 is
    signal counter  : unsigned  (9 downto 0);   -- 2^10 = 1024
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            counter  <= to_unsigned(1, 10);
        elsif (clk'event and clk = '1') then
            if (ce = '1') then
                if (init = '1') then
                    counter  <= to_unsigned(1, 10);
                elsif (start = '0') then
                    counter <= counter;
                elsif (start = '1') then
                    if (forward = '1') then
                        if (counter = to_unsigned(599, 10)) then
                            counter <= to_unsigned(1, 10);
                        else
                            counter <= counter + 1;
                        end if;
                    else
                        if (counter = to_unsigned(1, 10)) then
                            counter <= to_unsigned(599, 10);
                        else
                            counter <= counter - 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;
    value <= std_logic_vector(counter);
end Behavioral;
