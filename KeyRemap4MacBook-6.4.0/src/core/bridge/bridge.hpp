#ifndef BRIDGE_HPP
#define BRIDGE_HPP

namespace org_pqrs_KeyRemap4MacBook {
  namespace KeyRemap4MacBook_bridge {
    enum Error {
      SUCCESS = 0,
      ERROR = 1,
    };

    enum RequestType {
      REQUEST_NONE,
      REQUEST_GET_WORKSPACE_DATA,
    };

    namespace GetWorkspaceData {
      enum ApplicationType {
        UNKNOWN,
        EMACS, // Carbon Emacs, Aquamacs, ...
        VI, // Vim, ...
        TERMINAL, // Terminal.app, iTerm.app, ...
        VIRTUALMACHINE, // VMware, Parallels, ...
        REMOTEDESKTOPCONNECTION, // Microsoft Remote Desktop Connection, Cord, ...
        X11,
        FINDER,
        SAFARI,
        FIREFOX,
        ICHAT, // iChat
        ADIUMX,
        SKYPE,
        MAIL, // Mail.app
        EDITOR, // TextEdit
        ADOBE, // Adobe Softwares
        THUNDERBIRD,
        EXCEL, // Microsoft Excel
        ENTOURAGE, // Microsoft Entourage
        ECLIPSE,
      };
      enum InputMode {
        INPUTMODE_NONE,
        INPUTMODE_ROMAN, // Roman, Password, ...
        INPUTMODE_JAPANESE, // Japanese, Japanese.*
        INPUTMODE_CHINESE_TRADITIONAL,
        INPUTMODE_CHINESE_SIMPLIFIED,
        INPUTMODE_KOREAN,
      };
      enum InputModeDetail {
        INPUTMODE_DETAIL_NONE,
        INPUTMODE_DETAIL_ROMAN,

        INPUTMODE_DETAIL_JAPANESE_HIRAGANA,
        INPUTMODE_DETAIL_JAPANESE_KATAKANA,
        INPUTMODE_DETAIL_JAPANESE, // other Japanese mode

        INPUTMODE_DETAIL_CHINESE_TRADITIONAL,
        INPUTMODE_DETAIL_CHINESE_SIMPLIFIED,

        INPUTMODE_DETAIL_KOREAN,
      };

      // none
      struct Request {};

      struct Reply {
        ApplicationType type;
        InputMode inputmode;
        InputModeDetail inputmodedetail;
      };
    }
  }
}

#endif