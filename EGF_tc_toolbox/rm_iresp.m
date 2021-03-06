function out = rm_iresp(data,npts,resp)
% Removes the instrument response from the data using deconvolution
% (dividing in the frequency domain)
%
% Input: 
%       data = the data to be corrected
%       npts = number of points
%       resp = response file generated by gen_response.m
%
% Output: 
%       Out = the data after removal of instrument response
%

% Fourier transform the data:
fdata=fft(data,npts);
lf=length(fdata);

% Preallocate for speed:
c=zeros(1,lf);

% Loop over every sample
for j=1:lf
    a=fdata(j);
    b=resp(j);

    denom = real(b) * real(b) + imag(b) * imag(b)+1.2e-32;
    c(j) =  (real(a)*real(b)+imag(a)*imag(b)) / denom + 1i *...
        (imag(a)*real(b)-real(a)*imag(b)) / denom;
end
% Inverse fourier transform
out = ifft(c,'symmetric');  
end