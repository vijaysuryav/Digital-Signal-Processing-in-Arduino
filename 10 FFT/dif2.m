function j=dit_meghna(x)
t=nextpow2(length(x));             % round to next highest power of 2 because radix-2
j=x ;   
N=length(j);                       % calculate length of padded sequence
S=log2(N);                         % no. of stages
j=bitrevorder(j);                  % bit-reverse the input sequence
for stage=1:S   
    a=1;                           % Initialise a and b, start points of the butterfly for each stage
    b=1+2^(stage-1);
    n=0;
       while( n<=2^(stage-1)-1 && b<=N)
        e=exp((-1i)*2*pi*n/(2^stage));    % Incorporate the twiddle factor
        y=j(a)+e*j(b);                    % Butterfly structure
        z=j(a)-e*j(b);
        j(a)=y;
        j(b)=z;
        a=a+1;
        b=b+1;     %  Increment a and b and n for the next butterfly structure
        n=n+1;
        if(rem(b,2^stage)==1)
          a=a+2^(stage-1);      % Discontinuity of butterfly struc, change a,b and n
          b=b+2^(stage-1);
          n=0;
        end
       end 
     
 end   
disp(j)
end 