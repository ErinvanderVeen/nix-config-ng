{ ... }: {
  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    rocmOverrideGfx = "10.3.0";
    openFirewall = true;
  };

  services.nextjs-ollama-llm-ui = {
    enable = true;
    ollamaUrl = "http://127.0.0.1:11434";
  };
}
