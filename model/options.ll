Statics:

a, b : Actors

USD, DAI : Assets

option_DAI : Time * Amount * StrkePrice * Counterparty

wallet : Asset * Amount

now : Time



Dynamics:

sell:
  $now(T)
  [A] wallet(DAI, 11)
  [B] option_DAI(T + 7d, 10, 10, B)
  -o
  [A] wallet(DAI, 10)
      option_DAI(T + 7d, 10, 10, B)
  [B] wallet(DAI,  1)

execute:
  $now(T')
  [A] wallet(DAI, 10)
      option_DAI(T' + 7d, 10, 10, B)
  [B] wallet(USD, 20)
      wallet(DAI,  1)
  T' <= T + 7d
  -o
  [A] wallet(USD, 10)
  [B] wallet(DAI, 11)
      wallet(USD, 10)

expire:
  $now(T')
  [A] wallet(DAI, 10)
      option_DAI(T + 7d, 10, 10, B)
  T' > T + 7d
  -o
  [A] wallet(DAI, 10)

create:
  $now(T)
  [B] $wallet(USD, X)
  Y <= X
  T' > T
  -o
  [B] option_DAI(T', Z, Y, B)

send:
  [A] wallet(P, X + Z)
  [B] wallet(P, Y)
  -o
  [A] wallet(P, X)
  [B] wallet(P, Y + Z)
