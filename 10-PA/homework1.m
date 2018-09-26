clc;close all
alpha=0:0.1:4;
beta=0.5
gamma=0.25
MB=abs(alpha*beta-3/4*((1+beta*alpha.^2)./(3+2*alpha)))
MC=abs((-1.5)*((1+beta*alpha.^2)./(3+2*alpha)))
MD=abs(1-1.5*((1+beta*alpha.^2)./(3+2*alpha)))
MBH=abs(alpha*beta-gamma)
MCH=abs(-2*gamma)*ones(1,41)
MDH=abs(1-2*gamma)*ones(1,41)
plot(alpha,MB,'k-',alpha,MC,'k--',alpha,MD,'k:')
hold on
plot(alpha,MBH,'k-.',alpha,MCH,'k-*',alpha,MDH,'k-O')
xlabel('$$\alpha$$','Interpreter','latex')
ylabel('$$|\frac{M}{\frac{PL}{4}}|$$','Interpreter','latex')
legend('MB','MC','MD','MB-hinge','MC-hinge','MD-hinge','Location','northwest');
axis([0,5,0,2])
print(gcf,'-r800','-dpng','filename.png')
