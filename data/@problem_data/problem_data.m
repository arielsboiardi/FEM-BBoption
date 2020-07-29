classdef problem_data
    % problem_data contain data about the problem, that is valued of the
    % parameters, boundary and initial conditions and gemtry of the domain.
    %
    % PROPERTIES:
    % Name: 
    % rate          Riskelss interest rate
    % costofcarry   Cost of carry 
    % strike        Strike price on the sum            
    % cov_matrix    Covariance matrix of the undelying assets: the diagonal
    %               contains variaance of the corresponding asset, on the
    %               othe entries there is the product of variances of
    %               corresponding assets scaled by their correlation
    %               factor.
    % geometry      poly_geo object which describes the domain
    % bdcond         Cella array with function handles to the boundary
    %               conditions. Each entry contains the boundary value on
    %               the edge indexed by the correspondig identifier.
    % time          Time interval of the problem
    % initV         Initial value, that is the payoff of the option. 
    %
    % NOTES:
    %   - Boundary conditions are parsed in direct order, it is therefore 
    %   convenient to set up the problem with the simplest to compute and
    %   approximate boundary conditions at the beginning of the list, and
    %   the worst at the end. In this way easier BCs will be used. 
    
    properties
        rate        % Riskless fixed interest rate
        costofcarry % Cost of carry
        strike      % Strike prices 
        cov_matrix  % Covariance matrix of the underlyings 
        geometry    % poly_geom object describing the domain
        bdcond      % Boudnary conditions
        time        % 1x2 vector with initial and final time
        initV       % Initial value
    end
    
    methods
        function pd=problem_data(rate,b,K,cov_matrix, geometry, bdcond, time, initV)
            % problem_data constructs an instance of the problem_data class
            % from inputs as described above.
            
            pd.rate = rate;
            pd.costofcarry = b;
            pd.strike = K;
            pd.cov_matrix = cov_matrix;
            pd.geometry = geometry;
            pd.bdcond=bdcond;
            pd.time=time;
            pd.initV=initV;
        end
    end
end
