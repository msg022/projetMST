        program project_coupled

       implicit none

       integer t, k
       integer, parameter :: nyr=251

       real donnees(2,150)
       real fin1850(1:150)
       real high(2,11)
       real finhigh(1:11)
       real low(2,11)
       real finlow(1:11)
       
       real Fatb(0:250)
       real Ftba(0:250)
       real Ftbls(0:250)
       real Flsa(0:250)
       real Fsoa(0:250)
       real Faso(0:250)
       real Fsoob(0:250)
       real Fobdo(0:250)
       real Fdoso(0:250)
       real Fsodo(0:250)
       real netfluxe(0:250)
       real kaso(0:250)
       real netfluxo(0:250)
       real AF(0:250)
       real temp(0:250)

       real Matmp(0:149)
       real Matmf(0:100)
       real Mtb(0:250)
       real Mso(0:250)
       real Mls(0:250)
       real Mdo (0:250)
       real Mob(0:250)
       real Q(0:250)
       real deltaT(0:250)
       real alpha,b,j,katb,ktba,ktbls,klsa,ksoa,ksoob,kobdo,kdoso
       real ksodo, gammal, gammao, lambda
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
       lambda=2.1/(5.35*log(2.))

       Matmp(0)=600.
       Mtb(0)=800.
       Mls(0)=1500.
       Mso(0)=1000.
       Mdo(0)=38000.
       Mob(0)=2.
       Fatb(0)=96.
       Faso(0)=80.
       kaso(0)=(80./600.)

       open (unit=1, file='Fin_obs.txt', status='old')
       read (1,*)donnees

       do t=1,150
       fin1850(t)=donnees(2,t)
        !print*, fin1850(t)
       enddo
       
       open (unit=2, file='A2.txt', status='old')
       read (2,*)high
       do k=1,11, 1
       finhigh(k)=high(2,k)
        print*, k ,finhigh(k)
       enddo
       
       open (unit=2, file='B1.txt', status='old')
       read (2,*)low
       do k=1,11, 1
       finlow(k)=low(2,k)
        !print*, k ,finlow(k)
       enddo
       

       open(unit=1, file='projet_coupled_past.txt', status='unknown')
       do t=1, 149, 1

       Fatb(t)=Fatb(0)*(1+0.35*log(Matmp(t-1)/Matmp(0)))
       Fatb(t)=Fatb(t)+gammal*deltaT(t-1)
       !kaso(t)=kaso(0)*(1-0.0009434*(Matm(t-1)-600.))
       Ftba(t)=ktba*Mtb(t-1)
       Ftbls(t)=ktbls*Mtb(t-1)
       Flsa(t)=klsa*Mls(t-1)
       Fsoa(t)=ksoa*Mso(t-1)
       Faso(t)=Faso(0)*(1+0.35*log(Matmp(t-1)/Matmp(0)))
       Faso(t)=Faso(t)+gammao*deltaT(t-1)
       Fsoob(t)=ksoob*Mso(t-1)
       Fobdo(t)=kobdo*Mob(t-1)
       Fsodo(t)=ksodo*Mso(t-1)
       Fdoso(t)=kdoso*Mdo(t-1)


       Matmp(t)=Matmp(t-1)+Ftba(t)-Fatb(t)+Fsoa(t)-Faso(t)+Flsa(t)
       Matmp(t)=Matmp(t)+fin1850(t)
       Mls(t)=Mls(t-1)+Ftbls(t)-Flsa(t)
       Mtb(t)=Mtb(t-1)+Fatb(t)-Ftba(t)-Ftbls(t)
       Mso(t)=Mso(t-1)+Faso(t)-Fsoa(t)-Fsoob(t)-Fsodo(t)+Fdoso(t)
       Mob(t)=Mob(t-1)+Fsoob(t)-Fobdo(t)
       Mdo(t)=Mdo(t-1)+Fsodo(t)+Fobdo(t)-Fdoso(t)

       netfluxe(t)=Fatb(t)-Ftba(t)-Flsa(t)
       netfluxo(t)=Faso(t)-Fsoa(t)

       AF(t)=(Matmp(t)-Matmp(t-1))/2

       Q(t)=5.35*log((Matmp(t-1)/2.12)/(Matmp(0)/2.12))
       deltaT(t)=lambda*Q(t)


       !write (1,*) t+1850, Matmp(t), netfluxe(t), netfluxo(t), deltaT(t)
        !print*, t+1850, Matmp(t), netfluxe(t), netfluxo(t), deltaT(t)
       enddo
        open(unit=5, file='projet_coupled_future.txt', status='unknown')
       do k=1,100,10
       
      Fatb(k)=Fatb(0)*(1+0.35*log(Matmf(k-1)/Matmf(0)))
       Fatb(k)=Fatb(k)+gammal*deltaT(k-1)
       !kaso(k)=kaso(0)*(1-0.0009434*(Matm(k-1)-600.))
       Ftba(k)=ktba*Mtb(k-1)
       Ftbls(k)=ktbls*Mtb(k-1)
       Flsa(k)=klsa*Mls(k-1)
       Fsoa(k)=ksoa*Mso(k-1)
       Faso(k)=Faso(0)*(1+0.35*log(Matmf(k-1)/Matmf(0)))
       Faso(k)=Faso(k)+gammao*deltaT(k-1)
       Fsoob(k)=ksoob*Mso(k-1)
       Fobdo(k)=kobdo*Mob(k-1)
       Fsodo(k)=ksodo*Mso(k-1)
       Fdoso(k)=kdoso*Mdo(k-1)


       Matmf(k)=Matmf(k-1)+Ftba(k)-Fatb(k)+Fsoa(k)-Faso(k)+Flsa(k)
       Matmf(k)=Matmf(k)+finhigh(k)
       Mls(k)=Mls(k-1)+Ftbls(k)-Flsa(k)
       Mtb(k)=Mtb(k-1)+Fatb(k)-Ftba(k)-Ftbls(k)
       Mso(k)=Mso(k-1)+Faso(k)-Fsoa(k)-Fsoob(k)-Fsodo(k)+Fdoso(k)
       Mob(k)=Mob(k-1)+Fsoob(k)-Fobdo(k)
       Mdo(k)=Mdo(k-1)+Fsodo(k)+Fobdo(k)-Fdoso(k)

       netfluxe(k)=Fatb(k)-Ftba(k)-Flsa(k)
       netfluxo(k)=Faso(k)-Fsoa(k)


       Q(k)=5.35*log((Matmf(k-1)/2.12)/(Matmf(0)/2.12))
       deltaT(k)=lambda*Q(k)
        !write (1,*) t+1850, Matmf(t), finhigh(k)
        !print*, t+1850, Matmf(t), finhigh(k)
       enddo
       
       pause

        close(1)
        close(5)
       end
       
