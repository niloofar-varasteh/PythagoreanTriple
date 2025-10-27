% Function to visualize (a subset of) all Primitive Pythagorean Triples
% up to a certain maximum hypotenuse, using the parameterization:
%   a = m^2 - n^2
%   b = 2*m*n
%   c = m^2 + n^2
%
% This code also draws simple shapes (using fill) to represent each triple
% in a 2D figure.

figure('Color', 'w');  % Create a new figure with a white background
hold on;               % Retain plots so that subsequent fill commands don't overwrite
axis equal;            % Use equal scaling on the x-axis and y-axis
xlabel('x');           % Label for x-axis
ylabel('y');           % Label for y-axis
title('Primitive Pythagorean Triples Visualization');  % Figure title

% ----------------------------
% Optional: Control the axis limits and tick increments:
xlim([0 1000]);                 % Set x-axis limits (adjust as needed)
ylim([0 1000]);                 % Set y-axis limits (adjust as needed)
set(gca,'XTick',0:100:1000);    % Ticks every 100 on the x-axis
set(gca,'YTick',0:50:1000);     % Ticks every 50 on the y-axis
% ----------------------------

scaleFactor = 0.20;    % A scale factor used to offset one of the polygon vertices

% Iterate over m:
% We use m up to sqrt(900) = 30 here, which is an arbitrary limit 
% (One could adapt this for an actual 'maxHypotenuse' in a more general function.)
for m = 2:sqrt(900)
    
    % For each m, iterate over n from 1 to m-1.
    % The condition n < m ensures a = m^2 - n^2 is non-negative.
    for n = 1:m-1
        
        % 1) Check gcd(m, n) == 1 (coprimeness)
        % 2) Check (m - n) is odd => mod(m - n, 2) == 1
        % If both are true, we generate a *primitive* Pythagorean triple.
        if gcd(m, n) == 1 && mod(m - n, 2) == 1
            
            % Generate the triple using standard formulas
            a = m^2 - n^2;     % one leg
            b = 2 * m * n;     % the other leg
            c = m^2 + n^2;     % the hypotenuse
            
            % 'k' is used to scale or multiply the triple if desired.
            k = 1;
            % Only plot as long as k*c <= 800 (upper bound on the hypotenuse)
            % and k < 2 (so effectively just k = 1 here).
            while k * c <= 800 && k < 2
                
                % Compute (x, y) coordinates of the polygon to fill.
                xCoords = [k*a, ...
                           k*a, ...
                           k*b*scaleFactor + k*a];
                       
                yCoords = [k*b, ...
                           k*a*scaleFactor + k*b, ...
                           k*b];
                
                % Fill the polygon in red with black edges and full opacity.
                fill(xCoords, yCoords, 'r', 'EdgeColor', 'k', 'FaceAlpha', 1);
                
                % Increment k in case you want multiples of (a, b, c).
                k = k + 1;
            end
        end
    end
end

% Note:
% - We now check BOTH gcd(m, n) == 1 AND (m - n) is odd.
% - scaleFactor is an arbitrary value that shifts one vertex of the shape
%   so the shapes do not collapse into a line.
% - Adjust xlim, ylim, and the increments in set(gca, 'XTick',..., 'YTick',...) 
%   to suit the range of values you wish to visualize.
% - With these conditions, the triple (a, b, c) is guaranteed to be *primitive*.
