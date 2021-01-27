function [f,t,eng,zcr]=enframe(x,win,inc)
%ENFRAME split signal up into (overlapping) frames: one per row. [F,T]=(X,WIN,INC)
%
%	F = ENFRAME(X,LEN) splits the vector X(:) up into
%	frames. Each frame is of length LEN and occupies
%	one row of the output matrix. The last few frames of X
%	will be ignored if its length is not divisible by LEN.
%	It is an error if X is shorter than LEN.
%
%	F = ENFRAME(X,LEN,INC) has frames beginning at increments of INC
%	The centre of frame I is X((I-1)*INC+(LEN+1)/2) for I=1,2,...
%	The number of frames is fix((length(X)-LEN+INC)/INC)
%
%	F = ENFRAME(X,WINDOW) or ENFRAME(X,WINDOW,INC) multiplies
%	each frame by WINDOW(:)
%
%   The second output argument, T, gives the time in samples at the centre
%   of each frame. T=i corresponds to the time of sample X(i). 
%

nx=length(x);
nwin=length(win);
if (nwin == 1)
   len = win;
else
   len = nwin;
end
if (nargin < 3)
   inc = len;
end
len = nwin;
nf = fix((nx-len+inc)/inc);
f=zeros(nf,len);
indf= inc*(0:(nf-1)).';
inds = (1:len);
f(:) = x(indf(:,ones(1,len))+inds(ones(nf,1),:));
if (nwin > 1)
    w = win(:)';
    f = f .* w(ones(nf,1),:);
end

t = floor((1+len)/2)+indf;
%fprintf('size of f\n');
szf = size(f);
% ff = f(:).*f(:);
for i = 1:szf(1)
    %ff = f(i,:).*f(i,:)
%     ff = abs(f(i,:));
%     eng(i) = sum(ff);
    eng(i) = 0;
    zcr(i) = 0;
    for j = 1:szf(2)
        eng(i) = eng(i)+abs(f(i,j));
        if j+1 <= szf(2)
            zcr(i) = zcr(i)+abs(sign(f(i,j+1))-sign(f(i,j)));
        end
    end
    zcr(i) = 0.5*zcr(i);
end

