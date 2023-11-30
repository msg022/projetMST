        program calculate_emissions
          implicit none

            integer, parameter :: max_years = 251
              real(8), dimension(max_years) :: years, emissions
                real(8) :: dt, etot
                  integer :: i

  ! Lecture des données depuis le fichier texte
      open(unit=10, file='FinobsA2.txt', status='old')
      open(unit=1, file='sommeFin_A2.txt', status='unknown')
      do i = 1, max_years
      read(10, *) years(i), emissions(i)
      end do
      close(10)

  ! Calcul des émissions totales (Etot)
           dt = years(2) - years(1)
           etot = 0.0
           do i = 1, max_years - 1
           etot = etot + emissions(i) * dt
             end do

  ! Affichage des émissions totales
              write(1,*) "Total Emissions selon A2", etot
               print*, "Total Emissions:", etot
               pause

  ! Calcul de la distribution finale des émissions entre les réservoirs
  ! (report de la variation de carbone dans chaque réservoir par rapport aux conditions initiales)
  ! Ajoutez votre logique ici pour calculer la distribution finale entre les réservoirs

  ! Affichage des résultats pour chaque année
      do i = 1, max_years
      print*, "Year:", years(i), "Emissions:", emissions(i)
        end do

        end program calculate_emissions

