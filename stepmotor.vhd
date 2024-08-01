library ieee;
use ieee.std_logic_1164.all;
entity stepmotor is 
     port(clock,enable,por,continue,error,dir   : in std_logic;
	       a,b,c,d          : out std_logic);
			 end stepmotor;
			 
  ARCHITECTURE arc of stepmotor is
         type state_type is (s0,s1,s2,s3,s4,error_state);
   signal current_state,next_state: state_type;
	signal output_enable: std_logic;
begin
	--state_machine
	process (clock,por,error,continue)
begin
	  if (por ='1')then
	    current_state <=S0;
		 elsif rising_edge (clock) then
		 if (current_state= error_state)then 
		  output_enable<='0';
		  if (continue='1') then
		      current_state<= s0;
		  else
		       current_state<= current_state;
		  end if;
		  if (dir='0')then
			 current_state<= current_state+1;
			 else 
			 current_state<= current_state-1;
			 end if;
			 
		  if (error='1'and continue='1') then 
		    current_state<=S0;
			 end if;
			 if (error='0'and continue='1')then
			 current_state<= next_state;
			 end if;
			 
			 
	else
		    output_enable <='1';
		 current_state<= next_state;
	end if;
	end if;
	end process;
	
	
	--output logic
	process (current_state, output_enable,dir)
	begin
		  if (output_enable ='1')then 
		   case current_state is
	
	
  
	 when s0=>
		  a      <= '0';
		  b      <= '0';
		  c      <= '0';
		  d      <= '0';
		  if (enable='1')then
		 next_state <= S1;
		elsif
		(dir='1') then 
		next_state<=S4;
		else 
	next_state<=S0;
end if;	

		  
		      when S1=>
				a       <='1';
				b       <='0';
				c       <='0';
				d       <='0';
				if (enable='1') then
				next_state<= S2;
				elsif
				(dir='1') then
				next_state<=S0;
				else
				
				next_state<=S0;
end if;

           when S2=>
			  a      <= '0';
			  b      <= '1';
			  c      <= '0';
			  d      <= '0';
			  if (enable='1') then
			  next_state<= S3;
			  elsif
			  (dir='1') then 
			  next_state<=S1;
			  else
			  next_state<=S0;
end if;

           when S3=>
           a     <= '0';
           b     <= '0';
           c     <= '1';
           d	  <= '0';
			  if (enable='1') then 
			next_state <= S4;
	      elsif
			(dir='1') then
			next_state<=S2;
			else
	     next_state<= S0;
end  if;

           when S4=>
	        a     <='0';
	        b     <='0';
	        c     <='0';
	        d	  <='1';
		if (enable='1') then
      next_state <= S1;
      elsif
		(dir='1') then
		next_state<=S3;
		else
      next_state<= S0;
		end if;
		
		when others =>
                    A <= '0';
                    B <= '0';
                    C <= '0';
                    D <= '0';
                    next_state <= error_state;
            end case;
        else
            A <= '0';
            B <= '0';
            C <= '0';
            D <= '0';



          
end if;
   end process;
 end arc;
		
			  
			  
				
				
				
 