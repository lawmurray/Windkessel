/**
 * Three-element Windkessel model.
 */
model Windkessel {
  const h = 0.01  // time step (s)

  param R         // peripheral resistance, mm Hg (ml s**-1)**-1
  param C         // arterial compliance, ml (mm Hg)**-1
  param Z         // characteristic impedence, mm Hg s ml**-1
  param sigma2    // process noise variance, (mm Hg)**2
  input F         // aortic flow, ml s**-1
  noise xi        // noise, ml s**-1
  state Pp        // peripheral pressure, mm Hg
  obs Pa          // observed aortic pressure, mm Hg

  sub parameter {
    R ~ gamma(2.0, 0.9)
    C ~ gamma(2.0, 1.5)
    Z ~ gamma(2.0, 0.03)
    sigma2 ~ inverse_gamma(2.0, 1000.0)
  }

  sub initial {
    Pp ~ gaussian(90.0, 15.0)
  }

  sub transition(delta = h) {
    xi ~ gaussian(0.0, h*sqrt(sigma2))
    Pp <- exp(-h/(R*C))*Pp + R*(1.0 - exp(-h/(R*C)))*(F + xi)
  }

  sub observation {
    Pa ~ gaussian(Pp + Z*F, 2.0)
  }

  sub proposal_parameter {
    R ~ truncated_gaussian(R, 0.03, lower = 0.0)
    C ~ truncated_gaussian(C, 0.1, lower = 0.0)
    Z ~ truncated_gaussian(Z, 0.002, lower = 0.0)
    sigma2 ~ inverse_gamma(2.0, 3.0*sigma2)
  }
}
