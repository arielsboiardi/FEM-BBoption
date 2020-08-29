classdef solver_options
    properties
        Nt      % Number of time steps
        theta   % Theta for the theta-method
    end
    
    methods
        function options=solver_options(Nt, theta)
            % Cosntructor for the solver_options class
            
            options.Nt=Nt;
            options.theta=theta;
            
        end
    end
end
