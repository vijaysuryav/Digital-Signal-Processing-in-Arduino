function j=dif_meghna(x)
    t=nextpow2(length(x));                       % Calculate the ndearest exponent of 2 
    j=x ;             % zero padding
    N=length(j);                                 % Length of padded structure
    S=log2(N);                                   % stages
    for stage=S:-1:1
        a=1;
        b=1+2^(stage-1);                         %Initialise a and b for each stage
        n=0;
        while( n<=2^(stage-1)-1  && a<=N && b<=N)
            l=(n)*(2^(S-stage));
            e=exp((-1i)*2*pi*l/(16));            %Twiddle factor
            y=j(a)+j(b);
            z=(j(a)-j(b)).*e;                    % Butterfly structure
            j(a)=y;
            j(b)=z;
            a=a+1;                                % Increment a,b and n
            b=b+1;
            n=n+1;
            if (stage==1)                % Discontinuity in the butterfly structure 
                if(rem(1,a)==1)            % in a particular stage
                a=a+2^(stage-1);
                b=b+2^(stage-1);
                n=0;
            end
        end  

            if(stage~=1)                  
              if(rem(a,2^(stage-1))==1)
              a=a+2^(stage-1);
              b=b+2^(stage-1);
              n=0;
              end
            end 
           end
    end  
    j=bitrevorder(j);                  % Bit reverse the output sequence
    disp(j);
end