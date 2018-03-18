function E = myEnergyFunc(Img)
    %Takes gradients:
    [grad_x,grad_y]=gradient(Img);
    
    %Adds them up:
    aux=abs(grad_x)+abs(grad_y);
    
    %Computes energy operation/expression for all 3 dimensions:
    E=aux(:,:,1).^3+aux(:,:,2).^3+aux(:,:,3).^3;
    E=nthroot(E,3);
end