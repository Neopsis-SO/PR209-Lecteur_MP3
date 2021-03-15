----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 10.03.2021 13:44:36
-- Design Name: 
-- Module Name: cpt_0_44099 - Behavioral
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

entity cpt_0_44099 is
    Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            ce      : in    std_logic;
            addr    : out   std_logic_vector(15 downto 0)
            );
end cpt_0_44099;

architecture Behavioral of cpt_0_44099 is
    signal counter  : unsigned  (15 downto 0);   -- 2^16 = 65 536
    
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            counter  <= to_unsigned(0, 16);
        elsif (clk'event and clk = '1') then
            if (ce = '1') then
                if (counter = to_unsigned(44099, 16)) then
                    counter <= to_unsigned(0, 16);
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;
    addr <= std_logic_vector(counter);
end Behavioral;
