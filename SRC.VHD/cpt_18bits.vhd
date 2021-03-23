----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 15.03.2021 17:03:12
-- Design Name: 
-- Module Name: cpt_18bits - Behavioral
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

entity cpt_18bits is
    Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            ce      : in    std_logic;
            init    : in    std_logic;
            start   : in    std_logic;
            forward : in    std_logic;
            addr_w  : in    std_logic_vector(17 downto 0);
            addr_r  : out   std_logic_vector(17 downto 0)
            );
end cpt_18bits;

architecture Behavioral of cpt_18bits is
    signal counter  : unsigned  (17 downto 0);   --2^18-1 = 262 143
    signal addr_max : unsigned  (17 downto 0) := (OTHERS => '0');
    
begin
    compteur_val_max : process(addr_w)
    begin
        addr_max <= unsigned(addr_w);
    end process;
    
    compteur_adresse : process(clk, reset)
    begin
        if (reset = '1') then
            counter  <= to_unsigned(0, 18);
        elsif (clk'event and clk = '1') then
            if (ce = '1') then
                if (init = '1') then
                    counter  <= to_unsigned(0, 18);
                elsif (start = '0') then
                    counter <= counter;
                elsif (start = '1') then
                    if (forward = '1') then
                        if (counter = addr_max) then
                            counter <= to_unsigned(0, 18);
                        else
                            counter <= counter + 1;
                        end if;
                    else
                        if (counter = to_unsigned(0, 18)) then
                            counter <= addr_max;
                        else
                            counter <= counter - 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    addr_r <= std_logic_vector(counter);

end Behavioral;
