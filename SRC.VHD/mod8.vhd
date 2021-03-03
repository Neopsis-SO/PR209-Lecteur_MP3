----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 02.03.2021 14:25:45
-- Design Name: 
-- Module Name: mod8 - Behavioral
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

entity mod8 is
    Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            ce      : in    std_logic;
            an      : out   std_logic_vector(7 downto 0);   --anodes
            sel     : out   std_logic_vector(2 downto 0)    --command to the 7 segments mux (8 7 segments so 2^3 = 8)
            );
end mod8;

architecture Behavioral of mod8 is
    signal cur_sel : unsigned (2 downto 0) := (OTHERS=> '0');  --2^3 = 8 7 segments
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            cur_sel <= (OTHERS=> '0');
        elsif (clk'event and clk = '1') then
            if (ce = '1') then
                if (cur_sel = 7) then
                    cur_sel <= (OTHERS=> '0');
                else
                    cur_sel <= cur_sel + 1;
                end if;
            end if;
        end if;
    end process;

    -- anode selection (low to activate on Nexys A7)
    with cur_sel select
    an  <=  "11111110" when "000",
            "11111101" when "001",
            "11111011" when "010",
            "11110111" when "011",
            "11101111" when "100",
            "11011111" when "101",
            "10111111" when "110",
            "01111111" when "111",
            "11111111" when others;
            
    -- signal for the mux
    sel <= std_logic_vector(cur_sel);
    
end Behavioral;
