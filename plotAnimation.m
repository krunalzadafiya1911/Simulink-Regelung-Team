x = out.x.Data;
t = 0:1:(length(x)-1);
X = 0.5*sin(x(1,:));
Y = -0.5*cos(x(1,:));

figure(10)
for ind = 1:length(t)
plot([0,X(ind)],[0,Y(ind)], X(ind), Y(ind),'r.', 'MarkerSize',30)
axis([-0.6 0.6 -0.6 0.6])
text(-0.2, 0.5,"Timer : " + num2str(t(ind)*0.01))
grid on
drawnow
pause(0.1)
end