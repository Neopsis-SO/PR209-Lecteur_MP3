----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 02.03.2021 14:25:45
-- Design Name: 
-- Module Name: cpt_1_9 - Behavioral
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

entity cpt_1_9 is
    Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            inc     : in    std_logic;
            dec     : in    std_logic;
            value   : out   std_logic_vector(3 downto 0)
            );
end cpt_1_9;

architecture Behavioral of cpt_1_9 is
    signal counter  : unsigned  (3 downto 0);
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            counter  <= to_unsigned(5, 4);
        elsif (clk'event and clk = '1') then
            if (dec = '1') then
                if (counter = to_unsigned(1, 4)) then
                    counter <= counter;
                else
                    counter <= counter - 1;
                end if;
            elsif (inc = '1') then
                if (counter = to_unsigned(9, 4)) then
                    counter <= counter;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;
    value <= std_logic_vector(counter);
end Behavioral;
