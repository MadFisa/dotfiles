;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Asif Mohamed Mandayapuram"
      user-mail-address "asifmp97@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Setting font to firacode
(setq doom-font (font-spec :family "Fira Code" :size 14)
      doom-big-font (font-spec :family "Fira Code" :size 24)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 16))

;; Thus seems to be the key for functions related to local mode, i.e file modes like python mode etc
(setq doom-localleader-key ",")

;; Doom disables auto-save and backup?
(setq auto-save-default t
      make-backup-files t)

;;Enable showing a word count in the modeline. This is only shown for the modes listed in doom-modeline-continuous-word-count-modes (Markdown, GFM and Org by default).
(setq doom-modeline-enable-word-count t)

;; Enable logging of done tasks, and log stuff into the LOGBOOK drawer by default
(after! org
  (setq org-log-done t)
  (setq org-log-into-drawer t)
  (add-to-list 'org-capture-templates
      '(
        "w" "Work Log Entry"
         entry (file+datetree "~/org/work-log.org")
         "* %?"
         :empty-lines 0)
        )

 (add-to-list 'org-capture-templates
        '("m" "Meeting"
         entry (file+datetree "~/org/meetings.org")
         "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
         :tree-type week
         :clock-in t
         :clock-resume t
         :empty-lines 0)
        )

(setq org-todo-keywords
'((sequence
        "TODO(t)"  ; A task that needs doing & is ready to do
        "PROJ(p)"  ; A project, which usually contains other tasks
        "LOOP(l)"  ; A recurring task
        "READ(r)"  ; A recurring task
        "STRT(s)"  ; A task that is in progress
        "WAIT(w)"  ; Something external is holding up this task
        "HOLD(h)"  ; This task is paused/on hold because of me
        "QUESTION(q)"  ; This task is paused/on hold because of me
        "BUG(b)"  ; Bugs to squash
        "IDEA(i)"  ; An unconfirmed and unapproved task or notion
        "|"
        "DONE(d)"  ; Task successfully completed
        "ANSWERED(a)"  ; This task is paused/on hold because of me
        "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
        (sequence
        "[ ](T)"   ; A task that needs doing
        "[-](S)"   ; Task is in progress
        "[?](W)"   ; Task is being held up or paused
        "|"
        "[X](D)")  ; Task was completed
        (sequence
        "|"
        "OKAY(o)"
        "YES(y)"
        "NO(n)"))
org-todo-keyword-faces
'(("[-]"  . +org-todo-active)
        ("STRT" . +org-todo-active)
        ("[?]"  . +org-todo-onhold)
        ("WAIT" . +org-todo-onhold)
        ("HOLD" . +org-todo-onhold)
        ("LOOP" . +org-todo-project)
        ("PROJ" . +org-todo-active)
        ("NO"   . +org-todo-cancel)
        ("BUG"   . +org-todo-cancel)
        ("READ"   . +org-todo-cancel)
        ("QUESTION"   . +org-todo-cancel)
        ("KILL" . +org-todo-cancel)))
(setq org-agenda-files '( "~/org" "~/org/journal" "~/org/roam"))

;; Custom agenda view
(setq org-agenda-start-day nil) ;today: For some reason it offsets today by 3 days. :shrug:
(setq org-agenda-custom-commands
      '(("d" "daily agenda view"
         (
          (todo "PROJ" ((org-agenda-overriding-header "Ongoing Projects")))
          (agenda "" ((org-agenda-overriding-header "Today's agenda") (org-agenda-span 'day)))
          (todo "TODO" ((org-agenda-overriding-header "Stuff TODO")))
          (todo "IDEA" ((org-agenda-overriding-header "I once had an IDEA")))
          (todo "QUESTION" ((org-agenda-overriding-header "Questions??!!")))
          (todo "READ" ((org-agenda-overriding-header "ULTIMATE POWER")))
          ))
        ("p" "planning week view"
         (
          (todo "BUG" ((org-agenda-overriding-header "SQUASH!")))
          (agenda "" ((org-agenda-overriding-header "Today's agenda") (org-agenda-span 'week)))
          (todo "TODO" ((org-agenda-overriding-header "Stuff TODO")))
          (todo "IDEA" ((org-agenda-overriding-header "I once had an IDEA")))
          (todo "QUESTION" ((org-agenda-overriding-header "Questions??!!")))
          (todo "READ" ((org-agenda-overriding-header "ULTIMATE POWER")))
          ))
        )
)
(setq org-habit-show-habits-only-for-today nil)
)

(setq-default
 delete-by-moving-to-trash t )

(after! org-journal
  (setq org-journal-enable-agenda-integration t)
  (setq org-journal-date-format "%Y%m%d.org")
  )

;; Org-habit
(use-package! org-habit
  :after org
  :config
  (setq org-habit-following-days 14
        org-habit-preceding-days 7
        org-habit-show-habits t)  )

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; biblio
(after! citar
  (setq! citar-bibliography '("~/org/references/references.bib"))
  ;; (setq! citar-library-paths '("~/references/library/files"))
  (setq! citar-notes-paths '("~/org/roam/references/"))
  )

(after! citar-org-roam
(setq citar-org-roam-note-title-template "${citar-author}- ${citar-date:4}")
)
