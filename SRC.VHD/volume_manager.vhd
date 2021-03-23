----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 17.03.2021 15:49:02
-- Design Name: 
-- Module Name: volume_manager - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity volume_manager is
    Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            ce      : in    std_logic;
            switch  : in    std_logic_vector(3 downto 0);
            idata   : in    std_logic_vector(10 downto 0);
            odata   : out   std_logic_vector(10 downto 0)
            );
end volume_manager;

architecture Behavioral of volume_manager is

begin

    with switch select
    odata <= 
        idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)& idata(10 downto 9)    when "0000",
        idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)& idata(10 downto 8)  when "0001",
        idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)& idata(10 downto 7)    when "0010",
        idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)& idata(10 downto 6)  when "0011",
        idata(10)&idata(10)&idata(10)&idata(10)&idata(10)& idata(10 downto 5)    when "0100",
        idata(10)&idata(10)&idata(10)&idata(10)& idata(10 downto 4)  when "0101",
        idata(10)&idata(10)&idata(10)& idata(10 downto 3)    when "0110",
        idata(10)&idata(10)& idata(10 downto 2)  when "0111",
        idata(10)& idata(10 downto 1)    when "1000",
        idata   when "1001",
        idata(10 downto 4)&idata(10)&idata(10)&idata(10)&idata(10)  when OTHERS;
    
end Behavioral;