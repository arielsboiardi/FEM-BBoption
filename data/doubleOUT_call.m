function c=doubleOUT_call(S,K,L,U,t,r,b,sigma2)
% doubleOUT_call evaluates the call option with double out barrier
% according to the formula in section 4.17.3 in "The complete guide to 
% option pricing formulas by E. G. Haug
%
% Inputs:
%   S: underlying asset value
%   K: strike price 
%   L: lower barrier 
%   U: upper barrier 
%   t: time to maturity (0 not allowed!!!!!)
%   r: riskless interest rate
%   b: carrying cost
%   sigma2: variance of the assrt price
% Output: 
%   c: value of the option at S at time t
%

N=5; % The sum whould be infinite, this is the approximation bound

% Compute some parameters that do not change in the sum. it is therefore
% convenient to compute them once for all
sigma = sqrt(sigma2);
m = (2*b)/sigma2 + 1;
A = (b+0.5*sigma2)*t;
B = sigma*sqrt(t);

sum1=0;
sum2=0;
for ndx=-N:N
    % Define paramenters that change with ndx
    d1 = (log((S*U^(2*ndx))/(K*L^(2*ndx))) + A)./B;
    d2 = (log((S*U^(2*ndx-1))/(L^(2*ndx))) + A)./B;
    d3 = (log((L^(2*ndx+2))./(K*S*U^(2*ndx))) + A)./B;
    d4 = (log((L^(2*ndx+2))./(S*U^(2*ndx+1))) + A)./B;
    
    % Update the sums value
    sum1 = sum1 + (U/L)^(ndx*m) * (normcdf(d1)-normcdf(d2)) - ...
        ((L^(ndx+1))./(S*U^ndx)).^m .* (normcdf(d3)-normcdf(d4));
    sum2 = sum2 + (U/L)^(ndx*(m-2)) .* (normcdf(d1-B)-normcdf(d2-B)) - ...
        ((L^(ndx+1))./(U^ndx*S)).^(m-2) .* (normcdf(d3-B)-normcdf(d4-B));
end

c = S.*exp((b-r)*t) .* sum1 - K*exp(-r*t) .* sum2;

end