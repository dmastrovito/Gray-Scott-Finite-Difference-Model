clear all;
clc;

%******************************************

%Choose one of: 
%justdiffusion =1
%dyemodel = 1
%grayscott =1

%******************************************

justdiffusion=0;
dyemodel = 0;
grayscott = 1;

deltat = .25;
deltax = 1;
deltay= deltax;

width = 256;
height = width;
timedura = 2000; % seconds

timesteps = round(timedura/deltat); % # iterations
heightsteps = round(height/deltax);
widthsteps = heightsteps;

%******************************************
if (justdiffusion == 1)
    Dc = .8;
    Dw = 1;
    a=0;
    C(1:heightsteps,1:widthsteps,1) = 1/16;
    W(1:heightsteps,1:widthsteps,1) = 1/16;
    f=0;
    k=0;
    j=0;
    C(109:148,109:148,1) = 1/2; 
    W(109:148,109:148,1) = 1/4;
elseif (dyemodel == 1)
     Dc = .8;
     Dw =1;
     a=6;
     k=0;
     f=0;
     C(1:heightsteps,1:widthsteps,1) = .8;
     W(1:heightsteps,1:widthsteps,1) = 0;%.15;
elseif  (grayscott == 1)      
    C(1:heightsteps,1:widthsteps,1) = .8;
    W(1:heightsteps,1:widthsteps,1) = 0;%.15;

    Dc = .4; %Diffusion const of dye
    Dw = 1;  %Diffusion const water
    a=10;
    k=.059;
    f=0.035;

end



%******************************************
PlotEvery = 10;
Noise = 0.001;


R = 0.01*rand(heightsteps,widthsteps);

C = C-R; W=W+R;
S = max(max(C+W));
if S > 1
    C = C/S;
    W = W/S;
end

figure(1)
image(round(255.*(C-min(C(:)))./(max(C(:))-min(C(:))))),colormap(jet),...
            colorbar('YTickLabel',{num2str(min(min(C(:,:,1)))),num2str(max(max(C(:,:,1))))}),...
            title(['Dye Concentration (Timestep=0)',' Mean C = ',num2str(mean(mean(C(:,:,1)))),' Mean W = ',num2str(mean(mean(W(:,:,1))))]);

set(gcf,'doublebuffer','on')
drawnow;
pause(1)


for t =1:timesteps
    dCx = diff(C(:,:,1),1,1);
    dCx = [C(width,:,1)-C(1,:,1);dCx];
    
    dCy = diff(C(:,:,1),1,2);
    dCy = [C(:,height,1)-C(:,1,1),dCy];
    dC = dCx + dCy;
    
    dWx = diff(W(:,:,1),1,1);
    dWx = [W(width,:,1)-W(1,:,1);dWx];
    
    dWy = diff(W(:,:,1),1,2);
    dWy = [W(:,height,1)-W(:,1,1),dWy];
    dW = dWx + dWy;
    
    d2Cx = diff(C(:,:,1),2,1);
    d2Cy = diff(C(:,:,1),2,2);
    d2Cx = [d2Cx(width-2,:);d2Cx;d2Cx(1,:)].*deltax^2;
    d2Cy = [d2Cy(:,height-2),d2Cy,d2Cy(:,1)].*deltay^2;
    d2C = d2Cx + d2Cy;
    
    d2Wx = diff(W(:,:,1),2,1);
    d2Wy = diff(W(:,:,1),2,2);
    d2Wx = [d2Wx(width-2,:);d2Wx;d2Wx(1,:)].*deltax^2;
    d2Wy = [d2Wy(:,height-2),d2Wy,d2Wy(:,1)].*deltay^2;
    d2W = d2Wx + d2Wy;
  
    
    C(:,:,2)= C(:,:,1) + ((Dc.*d2C) + (a.*(C(:,:,1).^2).*W(:,:,1))- k.*C(:,:,1)).*deltat;
    W(:,:,2) =  W(:,:,1) +((Dw.*d2W) - (a.*(C(:,:,1).^2).*W(:,:,1))+f.*(1-W(:,:,1))).*deltat;
    
    
    if (t > 50)
        PlotEvery = 50;
    end
    
    if (t/PlotEvery) == round(t/PlotEvery)
        figure(1)
        image(round(255.*(C(:,:,2)-min(min(C(:,:,2))))./(max(max(C(:,:,2)))-min(min(C(:,:,2)))))),colormap(jet),...
            colorbar('YTickLabel',{num2str(min(min(C(:,:,2)))),num2str(max(max(C(:,:,2))))}),...
            title(['Dye Concentration (Timestep=',num2str(t),')',' Mean C = ',num2str(mean(mean(C(:,:,2)))),' Mean W = ',num2str(mean(mean(W(:,:,2))))]);
        set(gcf,'doublebuffer','on')
        
       
        drawnow;
        pause(1)
    end
    
   
    
    %if (mod(t,2) == 0)
    %    C(:,:,2) = C(:,:,2) + Noise*(rand(width/deltax));
    %    W(:,:,2) = W(:,:,2) + Noise*(rand(width/deltax));
     
    S = max(max ( C(:,:,2) + W(:,:,2) ));
    if S > 1
        C(:,:,1) = C(:,:,2)./S;
        W(:,:,1) = W(:,:,2)./S;
    else 
         C(:,:,1) = C(:,:,2);
         W(:,:,1) = W(:,:,2);
    end
    %end
    
end
    
    
    
    
    