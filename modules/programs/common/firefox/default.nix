{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-esr-unwrapped {
      nixExtensions = [
        (pkgs.fetchFirefoxAddon {
          name = "Tree-style-tab";
          url = "https://addons.mozilla.org/firefox/downloads/file/4141929/tree_style_tab-3.9.16.xpi";
          sha256 = "sha256-cDwKHY1iMpqpPM86Y3kRZh3XUtDA1xRzZSHfeu7MUuk=";
        })
        (pkgs.fetchFirefoxAddon {
          name = "Bitwarden";
          url = "https://addons.mozilla.org/firefox/downloads/file/4140393/bitwarden_password_manager-2023.7.1.xpi";
          sha256 = "sha256-ozlx2A9VInn5ZXl4aTiujojEuVwp+DOcQvXeR/FSAK0=";
        })
      ];
      extraPolicies = {
        DisplayBookmarksToolbar = true;
        Preferences = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
    profiles.default = {
      settings = {
        "app.update.auto" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.prefs.modified" = false;
        "services.sync.engine.passwords" = false;
        "services.sync.declinedEngines" = "passwords,adblockplus,prefs";
        "media.eme.enabled" = true;
        "gfx.webrender.all.qualified" = true;
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.canvas.azure.accelerated" = true;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "privacy.resistFingerprinting.block_mozAddonManager" = true;
        "extensions.webextensions.restrictedDomains" = "";
        "tridactyl.unfixedamo" = true;
        "tridactyl.unfixedamo_removed" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "spellchecker.dictionary" = "en-CA";
        "ui.context_menus.after_mouseup" = true;
        "browser.warnOnQuit" = false;
        "browser.quitShortcut.disabled" = true;
        "browser.startup.homepage" = "file://${./homepage.html}";
        "browser.contentblocking.category" = "strict";
        "browser.discovery.enabled" = false;
        "browser.tabs.multiselect" = true;
        "browser.tabs.unloadOnLowMemory" = true;
        "browser.newtab.privateAllowed" = true;
        "browser.newtabpage.enabled" = true;
        "browser.urlbar.placeholderName" = "";
        "extensions.privatebrowsing.notification" = false;
        "browser.startup.page" = 3;
        "devtools.chrome.enabled" = true;
        "devtools.inspector.showUserAgentStyles" = true;
        "services.sync.prefs.sync.privacy.donottrackheader.value" = false;
        "services.sync.prefs.sync.browser.safebrowsing.malware.enabled" = false;
        "services.sync.prefs.sync.browser.safebrowsing.phishing.enabled" = false;
        "app.shield.optoutstudies.enabled" = true;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.archive.enabled" = false;
        "browser.onboarding.enabled" = false;
        "experiments.enabled" = false;
        "network.allow-experiments" = false;
        "social.directories" = "";
        "social.remote-install.enabled" = false;
        "social.toast-notifications.enabled" = false;
        "social.whitelist" = "";
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.blockedURIs.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "dom.ipc.plugins.reportCrashURL" = false;
        "breakpad.reportURL" = "";
        "beacon.enabled" = false;
        "browser.search.geoip.url" = "";
        "browser.search.region" = "UK";
        "browser.search.suggest.enabled" = true;
        "browser.search.update" = false;
        "browser.selfsupport.url" = "";
        "extensions.getAddons.cache.enabled" = false;
        "extensions.pocket.enabled" = true;
        "geo.enabled" = false;
        "geo.wifi.uri" = false;
        "media.getusermedia.screensharing.enabled" = false;
        "media.video_stats.enabled" = false;
        "device.sensors.enabled" = false;
        "dom.battery.enabled" = false;
        "dom.enable_performance" = false;
        "network.dns.disablePrefetch" = false;
        "network.http.speculative-parallel-limit" = 8;
        "network.predictor.cleaned-up" = true;
        "network.predictor.enabled" = true;
        "network.prefetch-next" = true;
        "security.dialog_enable_delay" = 300;
        "dom.event.contextmenu.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.introCount" = 20;
        "signon.rememberSignons" = false;
        "xpinstall.whitelist.required" = false;
        "xpinstall.signatures.required" = false;
        "general.warnOnAboutConfig" = false;
      };
      userChrome = ''
              /*================== SIDEBAR ==================*/
        #sidebar-box,
              .sidebar-panel[lwt-sidebar-brighttext] {
                background-color: var(--base_color1) !important;
              }


              /* The default sidebar width. */
              /* #sidebar-box { */
              /*   overflow: hidden!important; */
              /*   position: relative!important; */
              /*   transition: all 300ms!important; */
              /*   min-width: 60px !important; */
              /*   max-width: 60px !important; */
              /* } */

              /* The sidebar width when hovered. */
              /* #sidebar-box #sidebar,#sidebar-box:hover { */
              /*   transition: all 300ms!important; */
              /*   min-width: 60px !important; */
              /*   max-width: 200px !important; */
              /* } */


              /* only remove TST headers */
        #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
                display: none; /* remove sidebar header */
                border-color: var(--base_color2) !important;
              }

              /*******************/
              .sidebar-splitter {
                /* display: none;  remove sidebar split line */
                min-width: 1px !important;
                max-width: 1px !important;
                border-color: var(--base_color2) !important;
              }

              /* remove top tabbar */ 
        #titlebar { visibility: collapse !important; }


              /*================== URL BAR ==================*/
        #urlbar .urlbar-input-box {
                text-align: center !important;
              }


              * {
              font-family: JetBrainsMono Nerd Font Mono !important;
              font-size: 12pt !important;
              }

              /* #nav-bar { visibility: collapse !important; } */
                /* hide horizontal tabs at the top of the window */
                #TabsToolbar > * {
                  visibility: collapse;
                }

                /* hide navigation bar when it is not focused; use Ctrl+L to get focus */
                /* #main-window:not([customizing]) #navigator-toolbox:not(:focus-within):not(:hover) { */
                /*  margin-top: -45px; */
                /* } */
                #navigator-toolbox {
                  transition: 0.2s margin-top ease-out;
                }
      '';
      userContent = ''
                /*hide all scroll bars*/
                /* *{ scrollbar-width: none !important } */


                * {
                font-family: JetBrainsMono Nerd Font Mono;
                }

                @-moz-document url-prefix("about:") {
                    :root {
                        --in-content-page-background: #1E1E2E !important;
                    }
                }
        
        
                @-moz-document url-prefix(about:home), url-prefix(about:newtab){

            /* show nightly logo instead of default firefox logo in newtabpage */
            .search-wrapper .logo-and-wordmark .logo {
                background: url("${./logo.png}") no-repeat center !important;
                background-size: auto !important;
                background-size: 82px !important;
                display: inline-block !important;
                height: 82px !important;
                width: 82px !important;
            }

            body {
                background-color: #000000 !important;
                background: url("${./bg.png}") no-repeat fixed !important;
                background-size: cover !important;
                --newtab-background-color: #000000 !important;
                --newtab-background-color-secondary: #101010 !important;
            }

            body[lwt-newtab-brighttext] {
                --newtab-background-color: #000000 !important;
                --newtab-background-color-secondary: #101010 !important;

            }

            .top-site-outer .top-site-icon {
                background-color: transparent !important;

            }

            .top-site-outer .tile {
                background-color: rgba(49, 49, 49, 0.4) !important;
            }

            .top-sites-list:not(.dnd-active) .top-site-outer:is(.active, :focus, :hover) {
                background: rgba(49, 49, 49, 0.3) !important;
            }

            .top-site-outer .context-menu-button:is(:active, :focus) {
                background-color: transparent !important;
            }

            .search-wrapper .search-handoff-button{
                border-radius: 40px !important;
                background-color: rgba(49, 49, 49, 0.4) !important;
            }
        }
      '';
    };
  };

}
