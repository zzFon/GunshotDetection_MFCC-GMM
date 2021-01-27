
% timeline
t = 0:1:301;
t0 = 500;% t0 = 500 > max(t) = 301, physical realizable
% the target signal
% s = cos(0.2*t)+sin(0.3*t);
s = [zeros(1,100),cos(0.2*t),zeros(1,150)];

% matched filter
h = zeros(1,500);
for i = t+1
    h(t0-i) = s(i);
end

% white noise
n_mean = 0; n_var = 4;
n = n_mean+sqrt(n_var)*randn(1,length(s));
% received signal
x = s+n;

% detection threshold
G0 = n_var*log(0.6/0.4)+0.5*dot(s,s);
% filtered result
C = conv(x,h);
[G,tau0] = max(C);

figure(1);
subplot(4,1,1);plot(s);title('sent signal');
subplot(4,1,2);plot(h);title('matched filter');
subplot(4,1,3);plot(x);title('received signal');
subplot(4,1,4);
hold on;
plot(C);
plot(1:1:length(C),G0*ones(length(C)),'r');scatter(tau0,C(tau0),'r');
title('filtered result C(\tau)');
hold off;

fprintf('tau0 = %f, C(tau0) = %f, G0 = %f, delay = tau0 - t0 = %f\n',tau0,C(tau0),G0,tau0-t0);