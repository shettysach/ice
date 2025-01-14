{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }

      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    shellAliases = {
      fzfh = "fd -H . | fzf";
      fzfp = "fzf --preview 'bat --color=always {}'";
      neofetch = "fastfetch";
    };

    localVariables = {
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "";
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = "";

      ZVM_VI_HIGHLIGHT_BACKGROUND = "magenta";
      ZVM_VI_EDITOR = "nvim";
      ZVM_INIT_MODE = "sourcing";

      ICE = "${config.xdg.configHome}/ice";
    };

    syntaxHighlighting.styles = {
      "arg0" = "fg=cyan";
      "path" = "fg=blue";
      "unknown-token" = "fg=white";
      "suffix-alias" = "fg=green";
      "precommand" = "fg=green";
      "autodirectory" = "fg=green";
      "comment" = "fg=black";
      "single-quoted-argument" = "fg=green";
      "double-quoted-argument" = "fg=green";
      "dollar-quoted-argument" = "fg=magenta";
    };

    initExtra = ''
      function zvm_after_init() {
          bindkey '^R' fzf-history-widget
          bindkey '^P' history-substring-search-up
          bindkey '^N' history-substring-search-down
      }

      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color always --icon always $realpath'
      zstyle ':fzf-tab:*' switch-group '<' '>'
    '';

    history.size = 1000;
  };

}
