library ieee;
use ieee.std_logic_1164.all;

entity contador is
port(
	clockcont, s, enable, reset : in std_logic;
	qc : out std_logic_vector(2 downto 0)
);
end contador;

architecture contador of contador is
	component flipflopJK is
		port(
			J, K, clk, clear, preset: in std_logic;
			Q, Qbar : out std_logic
		);
	end component;

	component DivisorFrequencia is
		port( 
			clock_in : in std_logic;
			clock_out : out std_logic
		);
	end component;

	signal jd, kd, kc, qs, js, ks : std_logic_vector(5 downto 0);
	signal ss, es, rs  : std_logic;
	signal ave, aam, avo, gve, gam, gvo : std_logic;
	
	signal clock_reduzido : std_logic;
begin
	
  -- Instancia do divisorFrequencia
  DVF00 : DivisorFrequencia port map (clockcont, clock_reduzido);

  -- FlipflopJK para contagem
  FF00 : flipflopJK port map (js(0), ks(0), clock_reduzido, '1', '1', qs(0));
  FF01 : flipflopJK port map (js(1), ks(1), clock_reduzido, '1', '1', qs(1));
  FF02 : flipflopJK port map (js(2), ks(2), clock_reduzido, '1', '1', qs(2));
  FF03 : flipflopJK port map (js(3), ks(3), clock_reduzido, '1', '1', qs(3));
  FF04 : flipflopJK port map (js(4), ks(4), clock_reduzido, '1', '1', qs(4));
  FF05 : flipflopJK port map (js(5), ks(5), clock_reduzido, '1', '1', qs(5));
	
  --Contando de 0 a 45:
  js(5) <= not qs(4) or not qs(3) or not qs(2) or not qs (1) or not qs(0);
  ks(5) <= not qs(3) or not qs(2) or not qs(0);
  js(4) <= not qs(3) or not qs(2) or not qs(1) or not qs(0);
  ks(4) <= not qs(3) or not qs(2) or not qs(1) or not qs(0);
  js(3) <= not qs(2) or not qs(1) or not qs(0);
  ks(3) <= not qs(2) or not qs(0) or not(qs(5) and qs(1));
  js(2) <= not qs(1) or not qs(0);
  ks(2) <= not qs(0) or not(qs(5) and qs(1)) or not(qs(3) and qs(1));
  js(1) <= not qs(0) or (qs(5) and qs(3) and qs(2));
  ks(1) <= not qs(0);
  Js(0) <= '0';
  ks(0) <= '0';
  
  --situação A:
  ave <= not(qs(5) and qs(4)) or (not(qs(5)) and qs(3) and qs(2));
  aam <= (qs(4) and not qs(3) and qs(2) and not qs(1)) or (qs(4) and not qs(3) and qs(2) and not qs(0));
  avo <= qs(5) or (qs(4) and qs(3)) or ((qs(4) and qs(2)) and (qs(1) and qs(0)));
  gve <= (qs(4) and qs(3)) or (qs(5) and not qs(3)) or (qs(5) and not qs(2) and not qs(1)) or (qs(5) and not qs(2) and not qs(0)) or (qs(4) and qs(2) and qs(1) and qs(0));
  gam <= (qs(5) and qs(3) and qs(2)) or (qs(5) and qs(3) and qs(1) and qs(0));
  gvo <= (not qs(5) and not qs(4)) or not(qs(5) and qs(3) and qs(2)) or not(qs(5) and qs(3) and qs(1)) or not(qs(5) and qs(3) and qs(0));
  
  --situação B:
  ave <= not(qs(5) and qs(4)) or not(qs(5) and qs(3)) or not(qs(5) and qs(2)) or not(qs(5) and qs(1));
  aam <= (qs(4) and qs(3) and qs(2) and qs(1)) or (qs(5) and not qs(3) and not qs(2) and not qs(1) and not qs(0));
  avo <= (qs(5) and qs(0)) or (qs(5) and qs(1)) or (qs(5) and qs(2)) or (qs(5) and qs(3));
  gve <= (qs(5) and not qs(3) and qs(0)) or (qs(5) and qs(1) and not qs(0)) or (qs(5) and not qs(3) and qs(2)) or (qs(5) and qs(3) and not qs(2) and not qs(1));
  gam <= (qs(5) and qs(3) and qs(2)) or (qs(5) and qs(3) and qs(1) and qs(0));
  gvo <= not qs(5) or not(qs(3) and qs(2) and qs(1) and qs(0));
  
  --situação C:
  ave <= '0';
  aam <= not qs(0);
  avo <= '0';
  gve <= '0';
  gam <= not qs(0);
  gvo <= '0';
 
	ss <= s;
	es <= enable;
	rs <= reset;	
end contador;
