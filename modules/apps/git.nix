{ ... }:
{
  programs.git = {
    enable = true;
    config = {
      init = { defaultBranch = "main"; };
      core = { editor = "vim"; };
    };
  };
}