--libraries to be used are specified here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--entity declaration with port definitions
entity contador is
port ( clk:     in std_logic;
          reset:      in std_logic;
          counter : out std_logic_vector(5 downto 0)
);
end contador;

--architecture of entity
architecture Behavioral of contador is
--signal declaration.
signal J3,J4,J5,J6,Q1,Q2,Q3,Q4,Q5,Q6,Qbar1,Qbar2,Qbar3,Qbar4, Qbar5, Qbar6 : std_logic :='0';
signal ave, aam, avo, gve, gam, gvo : std_logic;

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
	
	--situação A:
  ave <= not(Q6 and Q5) or (not(Q6) and Q4 and Q3);
  aam <= (Q5 and not Q4 and Q3 and not Q2) or (Q5 and not Q4 and Q3 and not Q1);
  avo <= Q6 or (Q5 and Q4) or ((Q5 and Q3) and (Q2 and Q1));
  gve <= (Q5 and Q4) or (Q6 and not Q4) or (Q6 and not Q3 and not Q2) or (Q6 and not Q3 and not Q1) or (Q5 and Q3 and Q2 and Q1);
  gam <= (Q6 and Q4 and Q3) or (Q6 and Q4 and Q2 and Q1);
  gvo <= (not Q6 and not Q5) or not(Q6 and Q4 and Q3) or not(Q6 and Q4 and Q2) or not(Q6 and Q4 and Q1);

--  --situação B:
--  ave <= not(Q6 and Q5) or not(Q6 and Q4) or not(Q6 and Q3) or not(Q6 and Q2);
--  aam <= (Q5 and Q4 and Q3 and Q2) or (Q6 and not Q4 and not Q3 and not Q2 and not Q1);
--  avo <= (Q6 and Q1) or (Q6 and Q2) or (Q6 and Q3) or (Q6 and Q4);
--  gve <= (Q6 and not Q4 and Q1) or (Q6 and Q2 and not Q1) or (Q6 and not Q4 and Q3) or (Q6 and Q4 and not Q3 and not Q2);
--  gam <= (Q6 and Q4 and Q3) or (Q6 and Q4 and Q2 and Q1);
--  gvo <= not Q6 or not(Q4 and Q3 and Q2 and Q1);
--  
--  --situação C:
--  ave <= '0';
--  aam <= not Q1;
--  avo <= '0';
--  gve <= '0';
--  gam <= not Q1;
--  gvo <= '0';
	
	
	counter <= Q6 & Q5 & Q4 & Q3 & Q2 & Q1; 

end Behavioral;
