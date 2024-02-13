{ ... }: {
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"

      # Tapo smart plug
      "tplink"
      # Otherwise I get an exception
      "cast"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = { };
      homeassistant = {
        language = "en";
      };
      automation = [
        {
          description = "Zet tosti-aparaat uit na 8 minuten na aanzetten.";
          mode = "single";
          trigger = [
            {
              platform = "device";
              type = "turned_on";
              device_id = "d3ef241b23e991a74138344ab20a738f";
              entity_id = "switch.tosti";
              domain = "switch";
              for = {
                hours = 0;
                minutes = 8;
                seconds = 0;
              };
            }
          ];
          action = [
            {
              type = "turn_off";
              device_id = "d3ef241b23e991a74138344ab20a738f";
              entity_id = "switch.tosti";
              domain = "switch";
            }
            {
              service = "notify.mobile_app_fp3";
              data.message = "Tosti is klaar!";
            }
          ];
        }
      ];
    };
  };
}
