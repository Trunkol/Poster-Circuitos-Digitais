library ieee;
use ieee.std_logic_1164.all;

entity atv2 is
	port(
		clockcont, s, enable, reset : in std_logic;
		qc : out std_logic_vector(2 downto 0);
		d : out std_logic_vector(6 downto 0)
	);
end atv2;

component DivisorFrequencia is
	port( 
		clock_in : in std_logic;
		clock_out : out std_logic
	);
end component;
