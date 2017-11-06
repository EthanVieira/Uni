% Ethan Vieira 
% AERO 351 Project 1
%
% Welcome to my incredibly unintuitive and inefficient program
% If you take the time to try and understand what I did, you will find that
% I completed this project using the worst way possible.
%
% I hope you find creative code gore as funny as I do.
% 
% I use a technique here called: Avoid Newton-Raphson (or any convenient solution
% approximation) at all costs
%
% You basically get the sigma value from the delta v sigma plot by clicking on the
% closest point to the given delta value (y axis) and then pressing enter. You have to do that once for each
% sigma value you are solving for, so for the part with 10, you do it 10
% times. haha.
%
% There are errors in my method compared to the Newton-Raphson, but
% the overall comparisons are still valid
%
%

clear; clc; close all

problem = 3 ; % choose which part you want to run, problem 6 is the comparison
              % of all the results that one should get if they use my
              % method properly
    
%input vars
M = 4;
dspec = [18*pi/180 -18*pi/180 0];
d1 = 30*pi/180;
d2 = 15*pi/180;
d3 = 10*pi/180;
d4 = 6*pi/180;
d5 = 3*pi/180;
gam = 1.4;
R = 287.16;
cv = R/(gam-1);

stagPr = @(sigma) (((gam+1)/2*M^2*(sin(sigma))^2)/(1+(gam-1)/2*M^2*(sin(sigma))^2))^(gam/(gam-1))/(2*gam/(gam+1)*M^2*(sin(sigma))^2-(gam-1)/(gam+1))^(1/(gam-1));

Rhor = @(sigma) 1/(2/(M^2*(sin(sigma))^2*(gam+1))+(gam-1)/(gam+1));

delta = @(sigma) atan(1/(tan(sigma)*((gam+1)/2*M.^2/(M.^2*(sin(sigma)).^2-1)-1)));

delS = @(sigma) cv*log((2*gam*M^2*(sin(sigma))^2/(gam+1)-(gam-1)/(gam+1))*(((gam-1)*M^2*(sin(sigma))^2+2)/((gam+1)*M^2*(sin(sigma))^2))^gam);

M2 = @(sigma, delta) sqrt((1/(((gam+1)/2)^2/((gam-1)/2+1/(M^2*(sin(sigma))^2))-(gam-1)/2))/(sin(sigma-delta))^2);

p2p1 = @(sigma) 2*gam/(gam+1)*M^2*(sin(sigma))^2-(gam-1)/(gam+1);

prompt = 'What is the sigma from the graph for the current delta value?: ';
% use plot to find sigma for a delta value - change M in input vars
% accordingly




switch(problem)

    case 1
        
        d1
        
        fig = figure;
        fplot(delta,[0,pi/2])
        dcm_obj = datacursormode(fig);
        set(dcm_obj, 'DisplayStyle', 'datatip','SnapToDataVertex','off','Enable','on')

        disp('Click the point where delta is closest to d1, then press Return.')
        pause
        t = getCursorInfo(dcm_obj);
        siga = vertcat(t.Position);
        stagPra = stagPr(siga(1))
        Rhora = Rhor(siga(1))
        delSa = delS(siga(1))
        M2a = M2(siga(1), d1)

    case 2
       d2 
       n = 2;
       M = 3.5;
       for i = 1:n
           stagPr = @(sigma) (((gam+1)/2*M^2*(sin(sigma))^2)/(1+(gam-1)/2*M^2*(sin(sigma))^2))^(gam/(gam-1))/(2*gam/(gam+1)*M^2*(sin(sigma))^2-(gam-1)/(gam+1))^(1/(gam-1));
           Rhor = @(sigma) 1/(2/(M^2*(sin(sigma))^2*(gam+1))+(gam-1)/(gam+1));
           delta = @(sigma) atan(1/(tan(sigma)*((gam+1)/2*M.^2/(M.^2*(sin(sigma)).^2-1)-1)));
           delS = @(sigma) cv*log((2*gam*M^2*(sin(sigma))^2/(gam+1)-(gam-1)/(gam+1))*(((gam-1)*M^2*(sin(sigma))^2+2)/((gam+1)*M^2*(sin(sigma))^2))^gam);
           M2 = @(sigma, delta) sqrt((1/(((gam+1)/2)^2/((gam-1)/2+1/(M^2*(sin(sigma))^2))-(gam-1)/2))/(sin(sigma-delta))^2);

           fig = figure;
           fplot(delta,[0,pi/2])
           dcm_obj = datacursormode(fig);
           set(dcm_obj, 'DisplayStyle', 'datatip','SnapToDataVertex','off','Enable','on')

           disp('Click the point where delta on y axis is closest to d2, then press Return.')
           pause
           t = getCursorInfo(dcm_obj);
           sigb = vertcat(t.Position);
           M2b(i) = M2(sigb(1), d2);
           stagPrb(i) = stagPr(sigb(1));
           Rhorb(i) = Rhor(sigb(1));
           delSb(i) = delS(sigb(1));
           M = M2b(i);
           
                     
       end
       Mfinal = M2b(n)
       stagpressureratio = prod(stagPrb)
       densityratio = prod(Rhorb)
       totalentropychange = sum(delSb)
      
       
    case 3
       d3 
       disp(dspec)
       n = 3; 
       M = 4;
       for i = 1:n
           stagPr = @(sigma) (((gam+1)/2*M^2*(sin(sigma))^2)/(1+(gam-1)/2*M^2*(sin(sigma))^2))^(gam/(gam-1))/(2*gam/(gam+1)*M^2*(sin(sigma))^2-(gam-1)/(gam+1))^(1/(gam-1));
           Rhor = @(sigma) 1/(2/(M^2*(sin(sigma))^2*(gam+1))+(gam-1)/(gam+1));
           delta = @(sigma) atan(1/(tan(sigma)*((gam+1)/2*M.^2/(M.^2*(sin(sigma)).^2-1)-1)));
           delS = @(sigma) cv*log((2*gam*M^2*(sin(sigma))^2/(gam+1)-(gam-1)/(gam+1))*(((gam-1)*M^2*(sin(sigma))^2+2)/((gam+1)*M^2*(sin(sigma))^2))^gam);
           M2 = @(sigma, delta) sqrt((1/(((gam+1)/2)^2/((gam-1)/2+1/(M^2*(sin(sigma))^2))-(gam-1)/2))/(sin(sigma-delta))^2);

           p2p1 = @(sigma) 2*gam/(gam+1)*M^2*(sin(sigma))^2-(gam-1)/(gam+1);
           
           fig = figure;
           fplot(delta,[0,pi/2])
           dcm_obj = datacursormode(fig);
           set(dcm_obj, 'DisplayStyle', 'datatip','SnapToDataVertex','off','Enable','on')

           disp('Click the point where delta on y axis is closest to d3, then press Return.')
           pause
           t = getCursorInfo(dcm_obj);
           sigc = vertcat(t.Position);
           sigc(1)
           M2c(i) = M2(sigc(1), dspec(i));
           stagPrc(i) = stagPr(sigc(1));
           Rhorc(i) = Rhor(sigc(1));
           delSc(i) = delS(sigc(1));
           p2p1c(i) = p2p1(sigc(1));
           M = M2c(i);
       end
       
       Mfinal = M2c(n)
       stagpressureratio = prod(stagPrc)
       densityratio = prod(Rhorc)
       totalentropychange = sum(delSc)
       pratio = prod(p2p1c)
    case 4
        d4
        n = 5;
        M = 3.5;
        
        for i = 1:n
           stagPr = @(sigma) (((gam+1)/2*M^2*(sin(sigma))^2)/(1+(gam-1)/2*M^2*(sin(sigma))^2))^(gam/(gam-1))/(2*gam/(gam+1)*M^2*(sin(sigma))^2-(gam-1)/(gam+1))^(1/(gam-1));
           Rhor = @(sigma) 1/(2/(M^2*(sin(sigma))^2*(gam+1))+(gam-1)/(gam+1));
           delta = @(sigma) atan(1/(tan(sigma)*((gam+1)/2*M.^2/(M.^2*(sin(sigma)).^2-1)-1)));
           delS = @(sigma) cv*log((2*gam*M^2*(sin(sigma))^2/(gam+1)-(gam-1)/(gam+1))*(((gam-1)*M^2*(sin(sigma))^2+2)/((gam+1)*M^2*(sin(sigma))^2))^gam);
           M2 = @(sigma, delta) sqrt((1/(((gam+1)/2)^2/((gam-1)/2+1/(M^2*(sin(sigma))^2))-(gam-1)/2))/(sin(sigma-delta))^2);

           fig = figure;
           fplot(delta,[0,pi/2])
           dcm_obj = datacursormode(fig);
           set(dcm_obj, 'DisplayStyle', 'datatip','SnapToDataVertex','off','Enable','on')

           disp('Click the point where delta on y axis is closest to d4, then press Return.')
           pause
           t = getCursorInfo(dcm_obj);
           sigd = vertcat(t.Position);
           M2d(i) = M2(sigd(1), d4);
           stagPrd(i) = stagPr(sigd(1));
           Rhord(i) = Rhor(sigd(1));
           delSd(i) = delS(sigd(1));
           M = M2d(i);
        end
        
       Mfinal = M2d(n)
       stagpressureratio = prod(stagPrd)
       densityratio = prod(Rhord)
       totalentropychange = sum(delSd)
        
    case 5
        d5
        n = 10;
        M = 3.5;
        
        for i = 1:n
           stagPr = @(sigma) (((gam+1)/2*M^2*(sin(sigma))^2)/(1+(gam-1)/2*M^2*(sin(sigma))^2))^(gam/(gam-1))/(2*gam/(gam+1)*M^2*(sin(sigma))^2-(gam-1)/(gam+1))^(1/(gam-1));
           Rhor = @(sigma) 1/(2/(M^2*(sin(sigma))^2*(gam+1))+(gam-1)/(gam+1));
           delta = @(sigma) atan(1/(tan(sigma)*((gam+1)/2*M.^2/(M.^2*(sin(sigma)).^2-1)-1)));
           delS = @(sigma) cv*log((2*gam*M^2*(sin(sigma))^2/(gam+1)-(gam-1)/(gam+1))*(((gam-1)*M^2*(sin(sigma))^2+2)/((gam+1)*M^2*(sin(sigma))^2))^gam);
           M2 = @(sigma, delta) sqrt((1/(((gam+1)/2)^2/((gam-1)/2+1/(M^2*(sin(sigma))^2))-(gam-1)/2))/(sin(sigma-delta))^2);

           fig = figure;
           fplot(delta,[0,pi/2])
           dcm_obj = datacursormode(fig);
           set(dcm_obj, 'DisplayStyle', 'datatip','SnapToDataVertex','off','Enable','on')

           disp('Click the point where delta on y axis is closest to d5, then press Return.')
           pause
           t = getCursorInfo(dcm_obj);
           sige = vertcat(t.Position);
           M2e(i) = M2(sige(1), d5);
           stagPre(i) = stagPr(sige(1));
           Rhore(i) = Rhor(sige(1));
           delSe(i) = delS(sige(1));
           M = M2e(i);
           
        end
        
       Mfinal = M2e(n)
       stagpressureratio = prod(stagPre)
       densityratio = prod(Rhore)
       totalentropychange = sum(delSe)
        
    case 6
        disp('Here are all of the values for each 5 scenarios in arrays. The first index corresponds to the first scenario and so on.')
        densityratio = [3.5890 4.4357 4.4430 4.5904 4.2883]
        stagpressureratio = [.4557 .7816 .8950 .9595 .9904]
        Mfinal = [1.6968 1.9888 2.0659 2.2687 3.4636]
        total_Schange = [225.6814 70.7478 31.8544 11.8685 2.7629] % J/(kg K)
        num_shocks = [1 2 3 5 10];
        % You can easily make plots here showing the relationships if you
        % want, but the relationships are obvious so I won't
end
