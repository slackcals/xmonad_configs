-- Imports.
import XMonad
import XMonad.Actions.UpdatePointer
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig


-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to 
-- the bar.    
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Map workspaces
myWorkspaces = [ "1:main", "2:extra_terminals", "3:browser", "4",
                 "5:mail","6:mail","7","8","9:float"
               ]

-- Hooks
myManageHook = composeAll
            [ 
                  className =? "Firefox" --> doShift "3:browser"
                , className =? "Thunderbird" --> doShift "5:mail"
                , className =? "Gimp" --> doFloat <+> doShift "9:float"
            ]

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)


myConfig = desktopConfig
            { 
                  terminal    = "xfce4-terminal"
                , modMask     = mod1Mask
                , borderWidth        = 2
                , normalBorderColor  = "#dddddd"
                , focusedBorderColor = "#0000ff"
                , focusFollowsMouse = False
                , workspaces = myWorkspaces
                , manageHook = myManageHook <+> manageHook defaultConfig 
                , logHook = updatePointer (Relative 0.99 0.99)
            }