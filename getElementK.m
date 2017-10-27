function [elementStiffness] = getElementK(numberOfElements, Ym, w, h, xc)

% Element stiffness matrix
L = max(max(xc))/numberOfElements;
I = w*h^3/12;
elementStiffness = Ym*I*[12/L^3  6/L^2  -12/L^3 6/L^2;
                        6/L^2   4/L    -6/L^2  2/L;
                        -12/L^3 -6/L^2 12/L^3  -6/L^2;
                        6/L^2   2/L    -6/L^2  4/L     ]

end