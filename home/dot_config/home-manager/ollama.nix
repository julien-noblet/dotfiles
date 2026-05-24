{ pkgs, lib, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  systemd.user.services.ollama-model-loader = {
    Unit = {
      Description = "Download Ollama models";
      After = [ "ollama.service" "network-online.target" ];
      Wants = [ "ollama.service" "network-online.target" ];
      PartOf = [ "ollama.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart =
        let
          script = pkgs.writeShellScript "ollama-model-loader" ''
            set -eu

            api_base="http://127.0.0.1:11434"
            export OLLAMA_HOST="127.0.0.1:11434"

            for _ in $(seq 1 60); do
              if ${lib.getExe pkgs.curl} -fsS "$api_base/api/tags" >/dev/null; then
                break
              fi
              sleep 2
            done

            ${lib.getExe pkgs.ollama-cuda} pull gemma4:e4b
            ${lib.getExe pkgs.ollama-cuda} pull qwen3.5:4b
          '';
        in
        "${script}";
    };
  };

  systemd.user.timers.ollama-model-loader = {
    Unit = {
      Description = "Schedule Ollama model downloads";
    };
    Timer = {
      OnBootSec = "30s";
      OnUnitActiveSec = "12h";
      Persistent = true;
      Unit = "ollama-model-loader.service";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
