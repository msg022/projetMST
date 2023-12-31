               program project_coupled

       implicit none

       !create variable
       real alpha,b,j,katb,ktba,ktbls,klsa,ksoa,ksoob,kobdo,kdoso
       real ksodo, gammal, gammao, lambda, Boce, Bland, tstep, t0

        !create iterations
        integer t, k
        integer, parameter :: nyear=250
        integer yrreal(0:nyear)
        !set fluxes
        real Fatb(0:nyear)
       real Ftba(0:nyear)
       real Ftbls(0:nyear)
       real Flsa(0:nyear)
       real Fsoa(0:nyear)
       real Faso(0:nyear)
       real Fsoob(0:nyear)
       real Fobdo(0:nyear)
       real Fdoso(0:nyear)
       real Fsodo(0:nyear)
       real netfluxe(0:nyear)
       real netfluxo(0:nyear)

       !set M
       real Matm(0:nyear)
       real Mtb(0:nyear)
       real Mso(0:nyear)
       real Mls(0:nyear)
       real Mdo (0:nyear)
       real Mob(0:nyear)

       !set other
       real Q(0:nyear)
       real deltaT(0:nyear)
       real kaso(0:nyear)
       real AF(0:nyear)
       real temp(0:nyear)
       real donnees(2,250)
       real fin1850(1:250)
       real high(2,11)
       real finhigh(1:11)
       real low(2,11)
       real finlow(1:11)
       real time(1:11)

       !set constants
       Matm(0)=600.
       Mtb(0)=800.
       Mls(0)=1500.
       Mso(0)=1000.
       Mdo(0)=38000.
       Mob(0)=2.
       Fatb(0)=96.
       Faso(0)=80.
       kaso(0)=(80./600.)
       alpha=log(2.)/40
       b=0.5
       j=61.
       katb=(96./600.)
       ktba=(48./800.)
       ktbls=(48./800.)
       klsa=(48./1500.)
       ksoa=(80./1000.)
       ksoob=(4./1000.)
       kobdo=(4./2.)
       kdoso=(37./38000.)
       ksodo=(33./1000.)
       gammal=(-4.)
       gammao= -(30./20.)
       lambda=2.5/(5.35*log(2.))
       Boce=0.25
       Bland=0.35
       tstep=1
       t0=1850


       !read data from .txt
       open (unit=1, file='B1.txt', status='old')
       read (1,*)high
       do k=1, 11, 1
       !read(1,*), yrreal(k), finhigh(k)
       finhigh(k)=high(2,k)
       time(k)=high(1,k)
        !print*, time(k) , finhigh(k)
       enddo
       close(1)

       open (unit=2, file='FinobsB1.txt', status='old')
       read (2,*)donnees

       do t=1,250
       fin1850(t)=donnees(2,t)
        !print*, fin1850(t)
       enddo


       open(unit=1, file='projet_coupledB1.txt', status='unknown')
       open(unit=3, file='finB1.txt', status='unknown')
       do t=1, 250, 1
       Fatb(t)=Fatb(0)*(1+0.35*log(Matm(t-1)/Matm(0)))
       Fatb(t)=Fatb(t)+gammal*deltaT(t-1)
       !kaso(t)=kaso(0)*(1-0.0009434*(Matm(t-1)-600.))
       Ftba(t)=ktba*Mtb(t-1)
       Ftbls(t)=ktbls*Mtb(t-1)
       Flsa(t)=klsa*Mls(t-1)
       Fsoa(t)=ksoa*Mso(t-1)
       Faso(t)=Faso(0)*(1+0.35*log(Matm(t-1)/Matm(0)))
       Faso(t)=Faso(t)+gammao*deltaT(t-1)
       Fsoob(t)=ksoob*Mso(t-1)
       Fobdo(t)=kobdo*Mob(t-1)
       Fsodo(t)=ksodo*Mso(t-1)
       Fdoso(t)=kdoso*Mdo(t-1)


       Matm(t)=Matm(t-1)+Ftba(t)-Fatb(t)+Fsoa(t)-Faso(t)+Flsa(t)
       Matm(t)=Matm(t)+fin1850(t)
       Mls(t)=Mls(t-1)+Ftbls(t)-Flsa(t)
       Mtb(t)=Mtb(t-1)+Fatb(t)-Ftba(t)-Ftbls(t)
       Mso(t)=Mso(t-1)+Faso(t)-Fsoa(t)-Fsoob(t)-Fsodo(t)+Fdoso(t)
       Mob(t)=Mob(t-1)+Fsoob(t)-Fobdo(t)
       Mdo(t)=Mdo(t-1)+Fsodo(t)+Fobdo(t)-Fdoso(t)

       netfluxe(t)=Fatb(t)-Ftba(t)-Flsa(t)
       netfluxo(t)=Faso(t)-Fsoa(t)

       !AF(t)=(Matm(t)-Matm(t-1))/Fin(t)

       Q(t)=5.35*log((Matm(t-1)/2.12)/(Matm(0)/2.12))
       deltaT(t)=lambda*Q(t)


       write (1,*) t+1850, Matm(t), netfluxe(t), netfluxo(t), deltaT(t)
        print*, t+1850, Matm(t), netfluxe(t), netfluxo(t), deltaT(t)
        write(3,*)t+1850, fin1850(t)
        print*, t+1850,fin1850(t)
       enddo
       pause

        end
