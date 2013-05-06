/**
 * Three-element Windkessel model.
 */
model Windkessel {
  const delta = 0.01 // time step (s)

  param R   // peripheral resistance
  param C   // total arterial compliance
  param Z   // characteristic impedence

  input Fa  // aortic flow (mL/s)

  state Pp  // arterial pressure

  obs Pa    // observed aortic pressure

  sub parameter {
    R ~ gaussian(0.9, 0.3)
    C ~ gaussian(1.5, 0.5)
    Z ~ gaussian(0.03, 0.01)
  }

  sub proposal_parameter {
    R ~ gaussian(R, 0.03)
    C ~ gaussian(C, 0.1)
    Z ~ gaussian(Z, 0.002)
  }

  sub initial {
    Pp ~ gaussian(90, 15.0);
  }

  sub transition(delta = delta) {
    Pp <- Pp + (-Pp/(R*C) + Fa/C)*delta
  }

  sub observation {
    Pa ~ gaussian(Pp + Z*Fa, 2.0);
  }
}
