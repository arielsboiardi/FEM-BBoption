classdef problem_data
    properties
        rate        % Riskless fixed interest rate
        cov_matrix  % Covariance matrix of the underlyings 
        
        geometry    % poly_geom object describing the domain
        
        boundary_condition  % Boundary conditions
    end
    
    methods
        function pd=problem_data(r,Sigma, geom, BCs)
            % problem_data constructs an instance of the problem_data class
            % 
            
            pd.rate = r;
            pd.cov_matrix = Sigma;
            pd.geometry = geom;
            pd.boundary_condition=BCs;
        end
    end
end
