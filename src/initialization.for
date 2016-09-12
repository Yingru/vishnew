! 02-17-2011: The code "Ed = Ed + 1D-10" added at the end of energy initialization.

#include "defs.h"

!=======================================================================

      Subroutine InitializeAll(NX0,NY0,NZ0,NX,NY,NZ,
     &  NXPhy0,NYPhy0,NXPhy,NYPhy,T0,DX,DY,DZ,DT,
     &  TT00,TT01,TT02,ScT00,ScT01,ScT02,Vx,Vy,
     &  Pi00,Pi01,Pi02,Pi33,Pi11,Pi12,Pi22,
     &  PScT00,PScT01,PScT02,PScT33,
     &  PScT11,PScT12,PScT22,etaTtp0,etaTtp,PPI,PISc,XiTtP0,XiTtP,
     &  U0,U1,U2, PU0,PU1,PU2,SxyT,Stotal,StotalBv,StotalSv,
     &  Ed,PL,Sd,Time,Temp0,Temp,T00,T01,T02,IAA,CofAA,PNEW,
     &  TEM0,ATEM0,Rj,EPS0,V10,V20,AEPS0,AV10,AV20,TFREEZ)

      Implicit Double Precision (A-H, O-Z)

      Dimension TT00(NX0:NX, NY0:NY, NZ0:NZ)
      Dimension ScT00(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension TT01(NX0:NX, NY0:NY, NZ0:NZ)
      Dimension ScT01(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension TT02(NX0:NX, NY0:NY, NZ0:NZ)
      Dimension ScT02(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension Rj(NX0:NX, NY0:NY, NZ0:NZ)   ! density

      Dimension T00(NX0:NX, NY0:NY, NZ0:NZ)! ideal T00  energy momentum tensor
      Dimension T01(NX0:NX, NY0:NY, NZ0:NZ)! ideal T01
      Dimension T02(NX0:NX, NY0:NY, NZ0:NZ)! ideal T02

      Dimension Vx(NX0:NX, NY0:NY, NZ0:NZ)
      Dimension Vy(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension Pi00(NX0:NX, NY0:NY, NZ0:NZ)    !Stress Tensor
      Dimension PScT00(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension Pi01(NX0:NX, NY0:NY, NZ0:NZ)    !Stress Tensor
      Dimension PScT01(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension Pi02(NX0:NX, NY0:NY, NZ0:NZ)    !Stress Tensor
      Dimension PScT02(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension Pi33(NX0:NX, NY0:NY, NZ0:NZ)    !Stress Tensor
      Dimension PScT33(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension Pi11(NX0:NX, NY0:NY, NZ0:NZ)    !Stress Tensor
      Dimension PScT11(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension Pi12(NX0:NX, NY0:NY, NZ0:NZ)    !Stress Tensor
      Dimension PScT12(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension Pi22(NX0:NX, NY0:NY, NZ0:NZ)    !Stress Tensor
      Dimension PScT22(NX0:NX, NY0:NY, NZ0:NZ)

      Dimension PPI(NX0:NX, NY0:NY, NZ0:NZ)    !Bulk pressure
      Dimension PISc(NX0:NX, NY0:NY, NZ0:NZ)


      Dimension PU0(NX0:NX, NY0:NY, NZ0:NZ) !Four velocity from last time step
      Dimension PU1(NX0:NX, NY0:NY, NZ0:NZ) !Four velocity
      Dimension PU2(NX0:NX, NY0:NY, NZ0:NZ) !Four velocity

      Dimension U0(NX0:NX, NY0:NY, NZ0:NZ) !Four velocity
      Dimension U1(NX0:NX, NY0:NY, NZ0:NZ) !Four velocity
      Dimension U2(NX0:NX, NY0:NY, NZ0:NZ) !Four velocity

      Dimension Ed(NX0:NX, NY0:NY, NZ0:NZ) !energy density
      Dimension PL(NX0:NX, NY0:NY, NZ0:NZ) !pressure
      Dimension Sd(NX0:NX, NY0:NY, NZ0:NZ) !entropy density

      Dimension Temp0(NX0:NX, NY0:NY, NZ0:NZ) !Local Temperature
      Dimension Temp(NX0:NX, NY0:NY, NZ0:NZ) !Local Temperature
      Dimension IAA(NX0:NX, NY0:NY, NZ0:NZ)
      Dimension CofAA(0:2,NX0:NX, NY0:NY, NZ0:NZ)

      Dimension etaTtp(NX0:NX, NY0:NY, NZ0:NZ)  !extra (eta T)/tau_pi terms in I-S eqn 02/2008
      Dimension etaTtp0(NX0:NX, NY0:NY, NZ0:NZ)  !extra (eta T)/tau_pi terms in I-S eqn 02/2008

      Dimension XiTtP(NX0:NX, NY0:NY, NZ0:NZ)  !extra (Xi T)/tau_Pi terms in full I-S bulk eqn 08/2008
      Dimension XiTtP0(NX0:NX, NY0:NY, NZ0:NZ)  !extra (Xi T)/tau_Pi in last time step

CSHEN==========================================================================
C======output relaxation time for both shear and bulk viscosity================
      Dimension VRelaxT(NX0:NX, NY0:NY, NZ0:NZ) !viscous coeficient relaxation time
      Dimension VRelaxT0(NX0:NX, NY0:NY, NZ0:NZ) !viscous coeficient relaxation time
CSHEN==========================================================================

      ! energy density and temperature in previous step
      DIMENSION EPS0(NX0:NX,NY0:NY)
      DIMENSION TEM0(NX0:NX,NY0:NY)

      DIMENSION V10(NX0:NX,NY0:NY),V20(NX0:NX,NY0:NY)   !velocity in X Y in Previous step

      ! energy density, temperature, velocity in previous step
      DIMENSION AEPS0(NX0:NX, NY0:NY)
      DIMENSION ATEM0(NX0:NX, NY0:NY)
      DIMENSION AV10(NX0:NX, NY0:NY),AV20(NX0:NX, NY0:NY)

      ! stress tensor in previous step
      DIMENSION F0Pi00(NX0:NX,NY0:NY)
      DIMENSION F0Pi01(NX0:NX,NY0:NY)
      DIMENSION F0Pi02(NX0:NX,NY0:NY)
      DIMENSION F0Pi11(NX0:NX,NY0:NY)
      DIMENSION F0Pi12(NX0:NX,NY0:NY)
      DIMENSION F0Pi22(NX0:NX,NY0:NY)
      DIMENSION F0Pi33(NX0:NX,NY0:NY)

      double precision, parameter :: HbarC = M_HBARC

C--------------------------------------------------------------------------------------------------------
      parameter(NNEW=4)
      DIMENSION PNEW(NNEW)    !related to root finding
      Common /Tde/ Tde, Rdec1, Rdec2,TempIni !Decoupling Temperature !decoupling redious
      common/Edec/Edec
      common/Edec1/Edec1

      Common /Nsm/ Nsm

      Common/R0Aeps/ R0,Aeps

      Integer InitialURead   ! specify if read in more profiles
      Common/LDInitial/ InitialURead

      Common /Timestep/ DT_1, DT_2
      Double Precision Time

      COMMON /IEin/ IEin     !  type of initialization  entropy/enrgy

      Common /ViscousC / ViscousC,VisBeta, IVisflag ! Related to Shear Viscosity

      Double Precision SEOSL7, PEOSL7, TEOSL7
      External SEOSL7

      Integer Initialpitensor
      Common/Initialpi/ Initialpitensor

!------------- Freezeout energy density and temperature -----------------
       ee     = EDEC                    !GeV/fm^3
       TFREEZ = TEOSL7(ee)              !GeV

       Time = T0

CSHEN===================================================================
CSHEN=====Using a smaller time step for short initialization time \tau_0
       if (Time.lt.0.59) then
            DT = DT_2
            write(*,*) 'Using a smaller time step for tau<0.6, DT=',DT
       else
            DT = DT_1
       endif
CSHEN====END============================================================

C !---------------- Four flow velocity initialization---------------------
      If (InitialURead .eq. 0) then
        do 2560 K = NZ0,NZ
        do 2560 I = NXPhy0-3,NXPhy+3
        do 2560 J = NYPhy0-3,NYPhy+3

          U1(I,J,K)  = 0.0d0
          U2(I,J,K)  = 0.0d0
          U0(I,J,K)  = sqrt(1.0+U1(I,J,K)**2+U2(I,J,K)**2)

          PU1(I,J,K) = 0.0d0
          PU2(I,J,K) = 0.0d0
          PU0(I,J,K) = sqrt(1.0+PU1(I,J,K)**2+PU2(I,J,K)**2)
2560   continue

      else
c---------------- Four flow velocity initialization---------------------
c----------------changed by J.Liu---------------------------------------------------------
        tolerance = 1D-10
        ed_max = 0.0   !
        u_regulated = 0.D0
        OPEN(UNIT = 21, FILE = 'Initial/ux_profile_kln.dat',
     &      STATUS = 'OLD', FORM = 'FORMATTED') ! read from Landau matched profile
        OPEN(UNIT = 22, FILE = 'Initial/uy_profile_kln.dat',
     &      STATUS = 'OLD', FORM = 'FORMATTED') ! read from Landau matched profile

c find maximum energy density to do the flow velocity regulation
C         do 2607 K = NZ0,NZ
C         do 2607 I = NXPhy0, NXPhy
C         do 2607 J = NYPhy0, NYPhy
C           if(Ed(I,J,K) .gt. ed_max) then
C             ed_max = Ed(I,J,K)
C c             write(*,*) ed_max, '  ', Ed(I,J,K)
C           end if
C 2607    continue
C         write(*,*) 'Maximum energy density: ',ed_max,
C      &   'tolerance for energy density: ', tolerance,
C      &   'regulate u: ', u_regulated

        do 2561 K = NZ0,NZ
        do 2561 I = NXPhy0,NXPhy
          read(21,*)  (U1(I,J,K),J=NYPhy0,NYPhy)
          read(22,*)  (U2(I,J,K),J=NYPhy0,NYPhy)

          do J=NYPhy0, NYPhy
c Regulate dilute region where energy density is small but u_mu is very large
c Ed(I,J,K) < Ed_max, dilute region
!             if ((Ed(I,J,K)/ed_max) .lt. tolerance) then
!               U1(I,J,K) = u_regulated
!               U2(I,J,K) = u_regulated
!             end if
! Regulation ends

            U0(I,J,K)  = sqrt(1.0+U1(I,J,K)**2+U2(I,J,K)**2)
            PU1(I,J,K) = U1(I,J,K)
            PU2(I,J,K) = U2(I,J,K)
            PU0(I,J,K) = U0(I,J,K)
          end do
c          write(211,'(261(D24.14))')  (U1(I,J,NZ0), J=NYPhy0, NYPhy) !add this line for debug
c          write(212,'(261(D24.14))')  (U2(I,J,NZ0), J=NYPhy0, NYPhy) !add this line for debug
c
c          write(210,'(261(D24.14))')  (U0(I,J,NZ0), J=NYPhy0, NYPhy) !add this line for debug
2561   continue
          close(21)
          close(22)
      Endif  ! InitialURead

!------------------- Energy initialization -----------------------------

C====Input the initial condition from file====
          open(2,file='initial.dat',status='old')

          If (IEin==0) Then  ! read as energy density
            do 2562 I = NXPhy0,NXPhy
              read(2,*)  (Ed(I,J,NZ0), J=NYPhy0,NYPhy)
2562        continue
            Ed = Ed/HbarC  ! convert to fm^-4
          Else If (IEin==1) Then  ! read as entropy density
            Do I = NXPhy0,NXPhy
              read(2,*)  (Sd(I,J,NZ0), J=NYPhy0,NYPhy)
            End Do
            Do I = NXPhy0,NXPhy
            Do J = NYPhy0,NYPhy
!              Call invertFunctionD(SEOSL7, 0D0, 315D0, 1D-3, 0D0,
!     &                        Sd(I,J,NZ0), resultingEd)
              Call invertFunction_binary(
     &                 SEOSL7, 0D0, 3D3, 1d-16, 1D-6,
     &                 Sd(I, J, NZ0), resultingEd)
              Ed(I,J,NZ0) = resultingEd/HbarC  ! convert to fm^-4
            End Do
            End Do
          End If ! IEin==0

          close(2)


      Ed = Ed + 1D-10


!---------- Then convert energy to pressure, entropy, temperature ------
      call EntropyTemp3 (Ed,PL, Temp,Sd,
     &         NX0,NY0,NZ0, NX,NY,NZ, NXPhy0,NYPhy0, NXPhy,NYPhy)


      do 2571 K = NZ0,NZ
      do 2571 I = NX0,NX
      do 2571 J = NY0,NY
        Temp0(I,J,K)   = Temp(I,J,K)
        etaTtp0(I,J,K) = (Ed(I,J,K)+PL(I,J,K))*Temp(I,J,K)/(6.0*VisBeta) !extra (eta T)/tau_pi terms in I-S eqn 02/2008
 2571 continue


!--------------- Viscous terms initialization --------------------------

      If (ViscousC>1D-6) Then

        if(Initialpitensor .eq. 1) then
          call TransportPi6(Pi00,Pi01,Pi02,Pi33, Pi11,Pi12,Pi22,
     &    PPI,Ed,Sd,PL,Temp,Temp0,U0,U1,U2,PU0,PU1,PU2, DX,DY,DZ,DT,
     &    NX0,NY0,NZ0, NX,NY,NZ, Time, NXPhy0,NYPhy0, NXPhy,NYPhy,
     &    VRelaxT,VRelaxT0)
        else
          Pi00 = 0.0d0
          Pi01 = 0.0d0
          Pi02 = 0.0d0
          Pi11 = 0.0d0
          Pi12 = 0.0d0
          Pi22 = 0.0d0
          Pi33 = 0.0d0
        endif

!-------------- Jia changes--------------------------------------------
C Read in pi_mu nu and overwrite what TransportPi6() gives. Then scale this tensor
        If(InitialURead .ne. 0) then
          write(*,*) "Start to read in Pi_mu nu profile"
            OPEN(200,file='Initial/Pi00_kln.dat',
     &         status='old', FORM = 'FORMATTED')
            OPEN(201,file='Initial/Pi01_kln.dat',
     &         status='old', FORM = 'FORMATTED')
            OPEN(202,file='Initial/Pi02_kln.dat',
     &         status='old', FORM = 'FORMATTED')
            OPEN(233,file='Initial/Pi33_kln.dat',
     &         status='old', FORM = 'FORMATTED')
            OPEN(211,file='Initial/Pi11_kln.dat',
     &         status='old', FORM = 'FORMATTED')
            OPEN(212,file='Initial/Pi12_kln.dat',
     &         status='old', FORM = 'FORMATTED')
            OPEN(222,file='Initial/Pi22_kln.dat',
     &         status='old', FORM = 'FORMATTED')
            OPEN(232,file='Initial/BulkPi_kln.dat',
     &         status='old', FORM = 'FORMATTED')
            do 206 I = NXPhy0,NXPhy
              read(200,*)  (Pi00(I,J,NZ0), J=NYPhy0, NYPhy)
              read(201,*)  (Pi01(I,J,NZ0), J=NYPhy0, NYPhy)
              read(202,*)  (Pi02(I,J,NZ0), J=NYPhy0, NYPhy)
              read(233,*)  (Pi33(I,J,NZ0), J=NYPhy0, NYPhy)
              read(211,*)  (Pi11(I,J,NZ0), J=NYPhy0, NYPhy)
              read(212,*)  (Pi12(I,J,NZ0), J=NYPhy0, NYPhy)
              read(222,*)  (Pi22(I,J,NZ0), J=NYPhy0, NYPhy)
              read(232,*)  (PPI(I,J,NZ0), J=NYPhy0, NYPhy)
206        continue
          close(200)
          close(201)
          close(202)
          close(233)
          close(211)
          close(212)
          close(222)
          close(232)
        Endif   ! InitalURead


!-------------- changes end--------------------------------------------
      End If  !ViscousC>1D-6

!CHANGES
!   ---Zhi-Changes---
!-------Regulate Pi(mu,nu) before adding it to T tensor
C       If (ViscousC>1D-6) Then
C         call regulatePi(Time,NX0,NY0,NZ0,NX,NY,NZ,
C      &  NXPhy0,NXPhy,NYPhy0,NYPhy,
C      &  Ed,PL,PPI,
C      &  Pi00,Pi01,Pi02,Pi11,Pi12,Pi22,Pi33,Vx,Vy)
C       End If
!-------End of regulation---------
!       ---Zhi-End---

!------------- T(mu,nu) initialization ---------------------------------

      do 2570 K = NZ0,NZ
      do 2570 I = NXPhy0,NXPhy
      do 2570 J = NYPhy0,NYPhy

         ee = Ed(i,j,k)*HbarC ! [ee] = GeV/fm^3
         Cn = 0.0
         pp = PEOSL7(ee)
         ee = Ed(i,j,k)
         pp = pp/HbarC ! [pp] -> fm^(-4)
         BulkPr = PPI(I,J,K)
         epU0   = (ee+pp+BulkPr)*U0(i,j,k)

         TT00(i,j,k) = (epU0*U0(i,j,k)+Pi00(i,j,k)-pp-BulkPr)*Time
         TT01(i,j,k) = (epU0*U1(i,j,k)+Pi01(i,j,k))*Time
         TT02(i,j,k) = (epU0*U2(i,j,k)+Pi02(i,j,k))*Time
         Rj(i,j,k)   = 0.0


2570  continue



       call dpSc8(TT00,TT01,TT02,ScT00,ScT01,ScT02,Vx,Vy,
     &  Pi00,Pi01,Pi02,Pi33,Pi11,Pi12,Pi22, PScT00,PScT01,PScT02,PScT33,
     &  PScT11,PScT12,PScT22,etaTtp0,etaTtp,  PPI,PISc, XiTtP0,XiTtP,
     &  U0,U1,U2, PU0,PU1,PU2,SxyT, Stotal,StotalBv,StotalSv,
     &  Ed,PL,Sd,Temp0,Temp, T00,T01,T02, IAA,CofAA,Time,DX,DY,
     &  DZ,DT,NXPhy0,NYPhy0,NXPhy,NYPhy,NX0,NX,NY0,NY,NZ0,NZ,PNEW,NNEW)

    !EPS0 = 1.0d0
      DO 2600 J = NYPhy0-2,NYPhy+2
      DO 2600 I = NXPhy0-2,NXPhy+2
        EPS0(I,J) = Ed(I,J,NZ0)*HbarC
        V10(I,J)  = U1(I,J,NZ0)/U0(I,J,NZ0)
        V20(I,J)  = U2(I,J,NZ0)/U0(I,J,NZ0)
        TEM0(I,J) = Temp(I,J,NZ0)*HbarC

        If (ViscousC>1D-6) Then

          F0Pi00(I,J) = Pi00(I,J,NZ0)
          F0Pi01(I,J) = Pi01(I,J,NZ0)
          F0Pi02(I,J) = Pi02(I,J,NZ0)
          F0Pi11(I,J) = Pi11(I,J,NZ0)
          F0Pi12(I,J) = Pi12(I,J,NZ0)
          F0Pi22(I,J) = Pi22(I,J,NZ0)
          F0Pi33(I,J) = Pi33(I,J,NZ0)
        End If

2600  CONTINUE

            DO 2610 J = NYPhy0-2,NYPhy+2
            DO 2610 I = NXPhy0-2,NXPhy+2
                AEPS0(I,J) = Ed(I,J,NZ0)
                AV10(I,J)  = U1(I,J,NZ0)/U0(I,J,NZ0)
                AV20(I,J)  = U2(I,J,NZ0)/U0(I,J,NZ0)
                ATEM0(I,J) = Temp(I,J,NZ0)
2610        CONTINUE


      End Subroutine
