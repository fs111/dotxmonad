import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.WindowBringer
import System.IO
import System.Environment(getEnv)
import qualified XMonad.Actions.CycleWS as CWS

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , startupHook = setWMName "LG3D"
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , focusedBorderColor = myFocusedBorderColor
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")

         -- cycling workspaces
        , ((mod4Mask,               xK_Right),  CWS.nextWS)
        , ((mod4Mask,               xK_Left ),  CWS.prevWS)
        , ((mod4Mask .|. shiftMask, xK_Right),  CWS.shiftToNext >>
           CWS.nextWS)
        , ((mod4Mask .|. shiftMask, xK_Left),   CWS.shiftToPrev >>
           CWS.prevWS)
        , ((mod4Mask,               xK_z),      CWS.toggleWS)
        -- window bringer extension
         , ((mod4Mask .|. shiftMask, xK_g     ), gotoMenu)
         , ((mod4Mask .|. shiftMask, xK_b     ), bringMenu)
        ]


myFocusedBorderColor = "#0000C0"
