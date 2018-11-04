--libraries to be used are specified here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--entity declaration with port definitions
entity contador is
port (	
			 clk, switch0, switch1 :     in std_logic;
          reset:      in std_logic;
          counter, sinais : out std_logic_vector(5 downto 0)
);
end contador;

--architecture of entity
architecture Behavioral of contador is
--signal declaration.
signal J3,J4,J5,J6,Q1,Q2,Q3,Q4,Q5,Q6,Qbar1,Qbar2,Qbar3,Qbar4, Qbar5, Qbar6 : std_logic :='0';
signal acaiverde, acaiamarelo, acaivermelho, guaranaverde, guaranamarelo, guaranavermelho : std_logic;
signal sita, sitb, sitc : std_logic;

signal sita_acai_verde : std_logic;
signal sita_acai_amarelo : std_logic;
signal sita_acai_vermelho : std_logic;
signal sita_guarana_verde : std_logic;
signal sita_guarana_amarelo : std_logic;
signal sita_guaranda_vermelho : std_logic;

begin 
	J3 <= Q1 and Q2;
	J4<= J3 and Q3;
	J5<= J4 and Q4;
	J6<= J5 and Q5;

--entity instantiations

	FF1 : entity work.flipflopJK port map (clk,'1','1',Q1,Qbar1,reset);
	FF2 : entity work.flipflopJK port map (clk,Q1,Q1,Q2,Qbar2,reset);
	FF3 : entity work.flipflopJK port map (clk,J3,J3,Q3,Qbar3,reset);
	FF4 : entity work.flipflopJK port map (clk,J4,J4,Q4,Qbar4,reset);
	FF5 : entity work.flipflopJK port map (clk,J5,J5,Q5,Qbar5,reset);
	FF6 : entity work.flipflopJK port map (clk,J6,J6,Q6,Qbar6,reset);
	
	sita <= not switch0 and not switch1;
	sitb <= not switch0 and switch1;
	sitc <= switch0 and not switch1;
	-- A = Q6
	-- B = Q5
	-- C = Q4
	-- D = Q3
	-- E = Q2
	-- F = Q1
	
	--situação A:
	acaiverde <= 
		-- y = A'B' + A'C'D' (0 a 19)
		(((not Q6 and not Q5) or (not(Q6) and not Q4 and not Q3)) and sita) or 
		--  y = A'B' + A'C' + A'D' + A'E' (0 a 29)
		(((not Q6 and not Q5) or (not Q6 and not Q4) or (not Q6 and not Q3) or (not Q6 and not Q2)) and sitb);
	 
	acaiamarelo <= 
		-- y = A'BC'DE' + A'BC'DF' (20 a 22)
		(((not Q6 and Q5 and not Q4 and Q3 and not Q2) or (not Q6 and Q5 and not Q4 and Q3 and not Q1)) and sita) or
		-- y = A'BCDE + AB'C'D'E'F' (30 a 32)
		(((not Q6 and Q5 and Q4 and Q3 and Q2) or (Q6 and not Q5 and not Q4 and not Q3 and not Q2 and not Q1)) and sitb);
 
	acaivermelho <= 
		-- y = A'BC + AB'C' + AB'D' + AB'E' + AB'F' + A'BDEF
		 ((
			(not Q6 and Q5 and Q4) or 
			(Q6 and not Q5 and not Q4) or 
			(Q6 and (not Q5) and not Q3) or 
			(Q6 and (not Q5) and (not Q1)) or 
			(not (Q6) and (Q5 and Q3) and (Q2 and Q1))) 
			and sita) 
			or
		--	y = AB'C'F + AB'C'E + AB'DE' + AB'CD'
		 ((
			(Q6 and not Q5 and not Q4 and Q1) or 
			(Q6 and not Q5 and not Q4 and Q2) or 
			(Q6 and not Q5 and Q3 and not Q2) or 
			(Q6 and not Q5 and Q4 and not Q3)) 
			and sitb);
		
	 
	  guaranaverde <= 
	 -- y = A'BC + AB'C' + AB'D'E' + AB'D'F' + A'BDEF 
	 ((
		(not Q6 and Q5 and Q4) or (Q6 and not Q5 and not Q4) or 
		(Q6 and not Q5 and not Q3 and not Q2) or 
		(Q6 and not Q5 and not Q3 and not Q1) or 
		(not Q6 and Q5 and Q3 and Q2 and Q1)) 
		and sita) or
	 -- y = y = AB'C'F + AB'C'D + AB'D'EF' + AB'CD'E'
	 (((Q6 and not Q5 and not Q4 and Q1) or 
		(Q6 and not Q5 and not Q4 and Q3) or 
		(Q6 and not Q5 and not Q3 and Q2 and not Q1) or 
		(Q6 and not Q5 and Q4 and not Q3 and not Q2)) and sitb);

	
	  guaranamarelo <= 
	  -- y = AB'CDE' + AB'CD'EF
	  (((Q6 and not Q5 and Q4 and Q3 and not Q2) or (Q6 and not Q5 and Q4 and Q3 and Q2 and Q1)) and sita)  or
		-- y = AB'CDE' + AB'CD'EF
	  (((Q6 and not Q5 and Q4 and Q3 and not Q2) or (Q6 and not Q5 and Q4 and not Q3 and Q2 and Q1)) and sitb);
	  
	  guaranavermelho <= acaiverde or acaiamarelo;

----  
--  --situação C:
--  ave <= '0';
--  aam <= not Q1;
--  avo <= '0';
--  gve <= '0';
--  gam <= not Q1;
--  gvo <= '0';
	sinais <= acaiverde & acaiamarelo & acaivermelho & guaranaverde & guaranamarelo & guaranavermelho; 
	counter <= Q6 & Q5 & Q4 & Q3 & Q2 & Q1;


end Behavioral;
