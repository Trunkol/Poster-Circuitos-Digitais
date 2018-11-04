--libraries to be used are specified here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--entity declaration with port definitions
entity contador is
port ( clk:     in std_logic;
          reset:      in std_logic;
          counter, sinais : out std_logic_vector(5 downto 0)
);
end contador;

--architecture of entity
architecture Behavioral of contador is
--signal declaration.
signal J3,J4,J5,J6,Q1,Q2,Q3,Q4,Q5,Q6,Qbar1,Qbar2,Qbar3,Qbar4, Qbar5, Qbar6 : std_logic :='0';
signal acaiverde, acaiamarelo, acaivermelho, guaranaverde, guaranamarelo, guaranavermelho : std_logic;
signal contador : std_logic_vector(5 downto 0);

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
	
	-- A = Q6
	-- B = Q5
	-- C = Q4
	-- D = Q3
	-- E = Q2
	-- F = Q1
	
	--situação A:
	  -- y = A'B' + A'C'D'
	  --acaiverde <= (not Q6 and not Q5) or (not(Q6) and not Q4 and not Q3);
	  -- y = A'BC'DE' + A'BC'DF'
	  --acaiamarelo <= (not Q6 and Q5 and not Q4 and Q3 and not Q2) or (not Q6 and Q5 and not Q4 and Q3 and not Q1);
	  -- y = A'BC + AB'C' + AB'D' + AB'E' + AB'F' + A'BDEF
	  --acaivermelho <= (not Q6 and Q5 and Q4) or (Q6 and not Q5 and not Q4) or (Q6 and (not Q5) and not Q3) or (Q6 and (not Q5) and (not Q1)) or (not (Q6) and (Q5 and Q3) and (Q2 and Q1));
	  -- y = A'BC + AB'C' + AB'D'E' + AB'D'F' + A'BDEF
	  --guaranaverde <= (not Q6 and Q5 and Q4) or (Q6 and not Q5 and not Q4) or (Q6 and not Q5 and not Q3 and not Q2) or (Q6 and not Q5 and not Q3 and not Q1)or (not Q6 and Q5 and Q3 and Q2 and Q1);
	  -- y = AB'CDE' + AB'CD'EF
	  --guaranamarelo <= (Q6 and not Q5 and Q4 and Q3 and not Q2) or (Q6 and not Q5 and Q4 and Q3 and Q2 and Q1);
	  --guaranavermelho <= ave or aam;

	--situação B:
		--  y = A'B' + A'C' + A'D' + A'E' (0 a 29)
			acaiverde <= (not Q6 and not Q5) or (not Q6 and not Q4) or (not Q6 and not Q3) or (not Q6 and not Q2);
		-- y = A'BCDE + AB'C'D'E'F' (30 a 32)
			acaiamarelo <= (not Q6 and Q5 and Q4 and Q3 and Q2) or (Q6 and not Q5 and not Q4 and not Q3 and not Q2 and not Q1);
		--	y = AB'C'F + AB'C'E + AB'DE' + AB'CD'
			acaivermelho <= (Q6 and not Q5 and not Q4 and Q1) or (Q6 and not Q5 and not Q4 and Q2) or (Q6 and not Q5 and Q3 and not Q2) or (Q6 and not Q5 and Q4 and not Q3);
		-- y = y = AB'C'F + AB'C'D + AB'D'EF' + AB'CD'E'
			guaranaverde <= (Q6 and not Q5 and not Q4 and Q1) or (Q6 and not Q5 and not Q4 and Q3) or (Q6 and not Q5 and not Q3 and Q2 and not Q1) or (Q6 and not Q5 and Q4 and not Q3 and not Q2);
		-- y = AB'CDE' + AB'CD'EF
			guaranamarelo <= (Q6 and not Q5 and Q4 and Q3 and not Q2) or (Q6 and not Q5 and Q4 and not Q3 and Q2 and Q1);
		   guaranavermelho <= acaiverde or acaiamarelo;
--  
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
