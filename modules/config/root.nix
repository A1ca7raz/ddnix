{ ... }:
{
  users.mutableUsers = false;
  users.users.root = {
    hashedPassword = "$6$EzkF9f7txOPfTWuP$Qqu8qRs2kQBz079PxXELkqjpdH/eIJuV6FMsAzT7sZRFJc/sgdNfGUPDkjmj2fTx5pLZb24seyLFr7.q4hYWd0";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILeHR3VQCaMfrmY2TErvQOattia/c6eKT3/Bt/iAuVeT"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
