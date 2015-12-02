function [y] = dtfs_wave(F,L,Fs,w);

         
n = 0:(L*Fs-1);
K = floor(Fs/2/F);
T = 1/F;

x = 0*n;

if (strcmp(w,'square'))

    for k = -K:1:K,
    
        if(k==0)                
          continue;
        end;
    
        ck = (2./(pi*k))*sin((pi*k)./2);   
        xn = ck*exp((2*pi*j*k*F*n)./Fs);    % Fourier Series computation
        x = x + xn;
    end
else
    for k = -K:1:K,
    
        if(k==0)                
          continue;
        end;
      
        bk = (2./((pi^2)*(k^2)))*(1-(-1)^k);
        xn = bk*exp((2*pi*j*k*F*n)./Fs);    % Fourier Series computation
        x = x + xn;
    end
end

y = real(x);