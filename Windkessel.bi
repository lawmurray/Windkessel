/**
 * Three-element Windkessel model.
 */
model Windkessel {
  const h = 0.01  // time step (s)

  param R         // peripheral resistance, mm Hg (ml s**-1)**-1
  param C         // arterial compliance, ml (mm Hg)**-1
  param Z         // characteristic impedence, mm Hg s ml**-1
  param sigma2    // process noise variance, (mm Hg)**2
  input F         // aortic flow (ml s**-1)
  noise xi        // noise, mm Hg
  state Pp        // peripheral pressure, mm Hg
  obs Pa          // observed aortic pressure, mm Hg

  sub parameter {
    R ~ gamma(2.0, 0.9)
    C ~ gamma(2.0, 1.5)
    Z ~ gamma(2.0, 0.03)
    sigma2 ~ inverse_gamma(2.0, 25.0)
  }

  sub initial {
    Pp ~ gaussian(90.0, 15.0)
  }

  sub transition(delta = h) {
    xi ~ gaussian(0.0, sqrt(sigma2))
    Pp <- R*F + (Pp - R*F)*exp(-h/(R*C)) + xi*h
  }

  sub observation {
    Pa ~ gaussian(Pp + Z*F, 2.0)
  }

  sub proposal_parameter {
    R ~ gaussian(R, 0.03)
    C ~ gaussian(C, 0.1)
    Z ~ gaussian(Z, 0.002)
    sigma2 ~ inverse_gamma(2.0, 3.0*sigma2)
  }
}
