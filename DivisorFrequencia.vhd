library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DivisorFrequencia is
	port( clock_in : in std_logic;
			saida : out std_logic_vector(3 downto 0);
			count : out integer range 0 to 45
			);
end DivisorFrequencia;

architecture DivisorFrequencia of DivisorFrequencia is
	signal contagem : integer := 0;
	signal estado : std_logic;
begin
	process(clock_in, contagem)
	begin
		if(clock_in='1' and clock_in'EVENT) then
			if contagem=45 then
				saida <= (others => '0');
				saida(0) <= '1';
				contagem <= 0;
			else
				if(contagem >= 0 and contagem < 20) then
					saida <= (others => '0');
					saida(0) <= '1';
				end if; 
				
				if(contagem >= 20 and contagem < 40) then
					saida <= (others => '0');
					saida(1) <= '1';
				end if;
				
				if(contagem >= 40 and contagem < 42) then
					saida <= (others => '0');
					saida(2) <= '1';
				end if;
				
				if(contagem >= 42 and contagem < 46) then
					saida <= (others => '0');
					saida(3) <= '1';
				end if;
				
				contagem <= contagem + 1;
			end if;
		end if;
	end process;
	
	-- A = 5
	-- B = 4
	-- C = 3
	-- ...
	-- Contagem de 0 a 19: A'B' + A'C'D'
	-- Contagem de 20 a 39: A'BD + A'BC + AB'C'
	-- Contagem de 40 a 42: AB'CD'E' + AB'CD'F'
	-- Contagem de 43 a 45: AB'CDE' + AB'CD'EF

	count <= contagem;
end DivisorFrequencia;
