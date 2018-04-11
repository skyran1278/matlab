% Duhamel code:
clc
clear all
[t,U,N,E]=textread('TCU052.txt','%f%f%f%f','headerlines',11);
dt=0.005;
for num=1:2
    if num==1
        ina=N;
    else
        ina=E;
    end
    for i=1:7
        %% damping ratio decide
        switch i
            case 1
                dampingratio=2/100;
            case 2
                dampingratio=5/100;
            case 3
                dampingratio=10/100;
            case 4
                dampingratio=20/100;
            case 5
                dampingratio=30/100;
            case 6
                dampingratio=40/100;
            case 7
                dampingratio=50/100;
        end
        %% ?p???U???M?W?v????
        n=0;
        for T=0:0.01:10
            n=n+1;
            w=2*pi/T;
            wd=w*sqrt(1-(dampingratio)^2);
            
            Hw=-1/wd.*exp(-dampingratio*w.*t).*sin(wd.*t);
            u=conv(ina,Hw)*dt;
            
            dHw=-exp(-dampingratio*w.*t).*cos(wd.*t);
            C=conv(ina,dHw)*dt;
            v=-dampingratio*w*u+C;
            a=-w^2*u-2*dampingratio*w*v;
            PSa(n)=max(abs(u))*w^2;
            Sa(n)=max(abs(a));
        end
        T=0:0.01:10;
        switch i
            case 1
                format='-R';
            case 2
                format='-b';
            case 3
                format='-k';
            case 4
                format='-g';
            case 5
                format='-y';
            case 6
                format='-c';
            case 7
                format='-m';
        end
        switch num
            case 1
                figure(1)
                plot(T,Sa,format)
                legend('\xi = 2%','\xi = 5%','\xi = 10%','\xi = 20%','\xi = 30%','\xi =40%','\xi = 50%')
                xlabel ('Period (s)');
                ylabel ('Acceleration (gal)');
                title('TCU052 NS dir. absolute acce. spectrim Sa');
                hold on
                figure (2)
                plot(T,PSa,format)
                legend('\xi = 2%','\xi = 5%','\xi = 10%','\xi = 20%','\xi = 30%','\xi =40%','\xi = 50%')
                xlabel ('Period (s)');
                ylabel ('Acceleration (gal)');
                title('TCU052 NS dir. pseudo-acce. spectrim PSa');
                hold on
            case 2
                figure(3)
                plot(T,Sa,format)
                legend('\xi = 2%','\xi = 5%','\xi = 10%','\xi = 20%','\xi = 30%','\xi = 40%','\xi = 50%')
                xlabel ('Period (s)');
                ylabel ('Acceleration (gal)');
                title('TCU052 EW dir. absolute acce. spectrim Sa');
                hold on
                figure (4)
                plot(T,PSa,format)
                legend('\xi = 2%','\xi = 5%','\xi = 10%','\xi = 20%','\xi = 30%','\xi = 40%','\xi = 50%')
                xlabel ('Period (s)');
                ylabel ('Acceleration (gal)');
                title('TCU052 EW dir. pseudo-acce. spectrim PSa');
                hold on
        end
    end
end
% Newmark code:
clc
% clear all
[t,U,N,E]=textread('TCU072.txt','%f%f%f%f','headerlines',11);
dt=0.005;
%choose linear
for num=1:2
    if num==1
        ina=N;
    else
        ina=E;
    end
    p=-m*ina;
    for i=1:7
        %% damping ratio decide
        switch i
            case 1
                dampingratio=2/100;
            case 2
                dampingratio=5/100;
            case 3
                dampingratio=10/100;
            case 4
                dampingratio=20/100;
            case 5
                dampingratio=30/100;
            case 6
                dampingratio=40/100;
            case 7
                dampingratio=50/100;
        end
        %% ?p???U???M?W?v????
        n=0;
        for T=0:0.01:5
            n=n+1;
            k=m*((2*pi/T)^2);
            c=2*m*dampingratio*2*pi/T;
            a(:,1)=0;v(:,1)=0;u(:,1)=0;
            a(1,1)=1/m*(p(1,1)-c*v(1,1)-k*u(1,1));
            for j=1:length(ina)-1
                dbp=p(j+1,1)-p(j,1)+m*(6/dt*v(j,1)+3*a(j,1))+c*(3*v(j,1)+dt/2*a(j,1));
                kb=k+3*c/dt+6*m/dt/dt;
                du(j,1)=dbp/kb;
                u(j+1,1)=u(j,1)+du(j,1);
                
                dv(j,1)=3*du(j,1)/dt-3*v(j,1)-a(j,1)*dt/2;
                v(j+1,1)=v(j,1)+dv(j,1);
                
                da(j,1)=6*du(j,1)/dt/dt-6*v(j,1)/dt-3*a(j,1);
                a(j+1,1)=a(j,1)+da(j,1);
            end
            Sa(n)=max(abs(a+ina));
            PSa(n)=max(abs(u))*(2*pi/T)^2;
        end
        %%
        T=0:0.01:5;
        switch i
            case 1
                format='-R';
            case 2
                format='-b';
            case 3
                format='-k';
            case 4
                format='-g';
            case 5
                format='-y';
            case 6
                format='-c';
            case 7
                format='-m';
        end
        switch num
            case 1
                figure(1)
                plot(T,Sa,format)
                legend('\xi = 2%','\xi = 5%','\xi = 10%','\xi = 20%','\xi = 30%','\xi =40%','\xi = 50%')
                xlabel ('Period (s)');
                ylabel ('Acceleration (gal)');
                title('TCU072 NS dir. absolute acce. spectrim Sa');
                hold on
                figure (2)
                plot(T,PSa,format)
                legend('\xi = 2%','\xi = 5%','\xi = 10%','\xi = 20%','\xi = 30%','\xi =40%','\xi = 50%')
                xlabel ('Period (s)');
                ylabel ('Acceleration (gal)');
                title('TCU072 NS dir. pseudo-acce. spectrim PSa');
                hold on
            case 2
                figure(3)
                plot(T,Sa,format)
                legend('\xi = 2%','\xi = 5%','\xi = 10%','\xi = 20%','\xi = 30%','\xi =40%','\xi = 50%')
                xlabel ('Period (s)');
                ylabel ('Acceleration (gal)');
                title('TCU072 EW dir. absolute acce. spectrim Sa');
                hold on
                figure (4)
                plot(T,PSa,format)
                legend('\xi = 2%','\xi = 5%','\xi = 10%','\xi = 20%','\xi = 30%','\xi =40%','\xi = 50%')
                xlabel ('Period (s)');
                ylabel ('Acceleration (gal)');
                title('TCU072 EW dir. pseudo-acce. spectrim PSa');
                hold on
        end
    end
end
