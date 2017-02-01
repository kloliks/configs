import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops ( ewmh, ewmhDesktopsEventHook )
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook ( readUrgents )

import XMonad.Util.NamedScratchpad
import XMonad.Util.NamedWindows ( getName )
import XMonad.Util.Run
import XMonad.Util.Scratchpad

import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen

import XMonad.Layout.PerWorkspace ( onWorkspace, onWorkspaces )
import XMonad.Layout.Reflect

import System.Exit
import System.IO

import Data.List  ( intersperse )
import Data.Maybe ( catMaybes )
import Data.Ratio ((%))

import qualified Data.Map as M
import qualified XMonad.StackSet as S

------------------------------------------------------------------------
-- Colors
------------------------------------------------------------------------
myBlack        = "#073642"
myRed          = "#dc322f"
myGreen        = "#859900"
myYellow       = "#b58900"
myBlue         = "#268bd2"
myMagenta      = "#d33682"
myCyan         = "#2aa198"
myWhite        = "#eee8d5"
myLightBlack   = "#002b36"
myLightRed     = "#cb4b16"
myLightGreen   = "#586e75"
myLightYellow  = "#657b83"
myLightBlue    = "#839496"
myLightMagenta = "#6c71c4"
myLightCyan    = "#93a1a1"
myLightWhite   = "#fdf6e3"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
------------------------------------------------------------------------
main = do
--  xmproc <- spawnPipe "/usr/bin/xmobar ~/.config/xmobar/xmobar.hs"
--  xmproc <- spawnPipe "/tmp/xmonad.log"
--  xmproc <- spawnPipe "/home/yos/projects/test-cpp/test.a"
  xmonad $ ewmh $ fullscreenSupport defaultConfig
      { terminal        = myTerminal
      , layoutHook      = myLayout
      , manageHook      = myManageHook <+> manageDocks
      , workspaces      = myWorkspaces
      , keys            = myKeys
--      , logHook         = myLogHook xmproc
      , handleEventHook = myEventHook
      , startupHook     = myStartupHook
      
      , normalBorderColor  = "#666666"
      , focusedBorderColor = "#f0e68c"
      }


myTerminal    = "urxvt"
myStartupHook = setWMName "LG3D"

myEventHook = do
    ewmhDesktopsEventHook
    docksEventHook


printUrgency :: String -> IO ()
printUrgency s = do
  h <- openFile "/tmp/xmonad.dynamic.log" WriteMode
  hPutStrLn h s
  hClose h

myLogHook xmproc = dynamicLogWithPP $ xmobarPP
    { ppOutput  = hPutStrLn xmproc
    , ppCurrent = xmobarColor myBlue "" . wrap "[" "]"
    , ppHidden  = const ""
    , ppTitle   = xmobarColor myYellow "" . shorten 100
    , ppUrgent  = xmobarColor myRed myLightRed
    , ppSep     = " $ "
    , ppOrder   = \(ws:_:t:_) -> [" " ++ ws,t]
--    , ppSort    = (. namedScratchpadFilterOutWorkspace) <$> ppSort defaultPP
    }

myWorkspaces =
    [ "Terminal"
    , "Misc 1"
    , "Misc 2"
    , "Gimp"
    , "Readers"
    , "VMachine"
    , "Web"
    , "Mail"
    , "IM"
    , "Skype"
    , "Wine"
    , "NSP"
    ]

myManageHook = composeAll
    [ className =? "Okular"           --> doShift "Readers"
    , className =? "VirtualBox"       --> doShift "VMachine"
    , className =? "Vmplayer"         --> doShift "VMachine"
    , className =? "Firefox"          --> doShift "Web"
    , className =? "Deluge"           --> doShift "Web"
    , className =? "Thunderbird"      --> doShift "Mail"
    , className =? "Pidgin"           --> doShift "IM"
    , className =? "Gimp"             --> doShift "Gimp"
    , className =? "Skype-bin"        --> doShift "Skype"
    , className =? "Subl3"            --> doFloat
    , className =? "Gvim"             --> doFloat
    , className =? "feh"              --> doFloat
    , className =? "t1server-core2"   --> doFloat
    , className =? "t1server-core2d"  --> doFloat
    , className =? "T1server-core2"   --> doFloat
    , className =? "T1server-core2d"  --> doFloat
    , className =? "t1client-core2"   --> doFloat
    , className =? "t1client-core2d"  --> doFloat
    , className =? "T1client-core2"   --> doFloat
    , className =? "T1client-core2d"  --> doFloat
    , isDialog                        --> doCenterFloat
    ] <+> myManageScratchPad

-- then define your scratchpad management separately:
myManageScratchPad :: ManageHook
myManageScratchPad = scratchpadManageHook (S.RationalRect l t w h)
  where
    h = 0.70       -- terminal height, 10%
    w = 0.60       -- terminal width, 100%
    t = 0.90 - h   -- distance from top edge, 90%
    l = 0.97 - w   -- distance from left edge, 0%

myScratchPads = [ NS "sublime" spawnSublime findSublime manageEditors
                , NS "gvim"    spawnGvim    findGvim    manageEditors
                ]
  where
    spawnSublime  = "subl3"
    spawnGvim     = "gvim"
    findSublime   = className =? "Subl3"
    findGvim      = className =? "Gvim"
    manageEditors = customFloating $ S.RationalRect l t w h
      where
        h = 0.70
        w = 0.60
        t = 0.90 - h
        l = 0.97 - w


winMask       = mod4Mask
altMask       = mod1Mask
workspaceKeys = [xK_F1 .. xK_F12]

myKeys conf = M.fromList $
    [ ((winMask                 , xK_x      ), spawn $ XMonad.terminal conf                               )
    , ((altMask                 , xK_q      ), broadcastMessage ReleaseResources >> restart "xmonad" True )
    , ((altMask .|. shiftMask   , xK_q      ), io (exitWith ExitSuccess)                                  )
    , ((altMask                 , xK_Tab    ), windows S.focusDown                                        )
    , ((altMask .|. shiftMask   , xK_Tab    ), windows S.focusUp                                          )
    , ((controlMask .|. winMask , xK_h      ), sendMessage Shrink                                         )
    , ((controlMask .|. winMask , xK_l      ), sendMessage Expand                                         )
    , ((winMask                 , xK_Return ), windows S.swapMaster                                       )
    , ((winMask                 , xK_space  ), sendMessage NextLayout                                     )
    , ((altMask                 , xK_t      ), withFocused $ windows . S.sink                             )
--    , ((winMask               , xK_h      ), windows S.focusLeft                                        )
    , ((altMask                 , xK_x      ), scratchpadSpawnActionTerminal myTerminal                   )
    , ((altMask                 , xK_s      ), namedScratchpadAction myScratchPads "sublime"              )
    , ((altMask                 , xK_e      ), namedScratchpadAction myScratchPads "gvim"                 )
    , ((winMask                 , xK_l      ), spawn "xscreensaver-command -lock"                         )
    , ((winMask                 , xK_v      ), spawn "VirtualBox"                                         )
    , ((winMask                 , xK_r      ), spawn "gmrun"                                              )
    , ((winMask                 , xK_o      ), spawn "okular"                                             )
    , ((winMask                 , xK_f      ), spawn "firefox"                                            )
    , ((winMask                 , xK_t      ), spawn "thunderbird"                                        )
    , ((altMask                 , xK_Escape ), kill                                                       )
    ] ++
    [ ((m .|. altMask           , key       ), windows $ f i)
        | (i, key) <- zip myWorkspaces workspaceKeys
        , (f, m) <- [(S.greedyView, 0), (S.shift, shiftMask)]
    ]


myLayout =
          onWorkspaces["Wine"] (noBorders Full)
        $ avoidStruts
--        $ onWorkspaces["IM"] imLayout
        $ onWorkspaces["Gimp"] gimpLayout
        $ onWorkspaces["Web"] (webLayout ||| Full)
        $ onWorkspaces["Skype"] (webLayout ||| Full)
        $ (tiled ||| Full)
  where
    tiled = Tall nmaster delta ratio

    nmaster = 1
    ratio   = 1/2
    delta   = 3/100


    gimpLayout = withIM (1/6) (Role "gimp-toolbox") $
                 reflectHoriz $
                 withIM (1/5) (Role "gimp-dock") Grid

--    imLayout = withIM (1/5) (And (ClassName "Pidgin") (Role "buddy_list")) Grid

    webLayout = Tall w_nmaster w_delta w_ratio

    w_nmaster = 1
    w_ratio   = 2/3
    w_delta   = 3/100
