local composer = require( "composer" ) 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local function SwitchTo10GridScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("10GridScene", options)
end

local function SwitchTo8GridScene11Image()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("8GridScene11Image", options)
end

local function SwitchTo8GridScene10Image()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("8GridScene10Image", options)
end

local function SwitchTo10Grid11ImageScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("10GridScene11image", options)
end

local function SwitchToAreaControlScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("10GridScene11AreaControl", options)
end

local function SwitchToSettingsScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("SettingsScene", options)
end

local function SwitchToMultiplayerAreaControlScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("MutiplayerAreaControl2", options)
end

local function SwitchToPaintTownScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("PaintTownScene", options)
end

local function SwitchToScavengerHuntsScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("ScavengerHuntsScene", options)
end

local function SwitchToInfodumpScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("InfodumpScene", options)
end

local function SwitchToIdleScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("IdleScene", options)
end

local function SwitchToCCScene()
    local options = {effect = "flip", time = 125}
    composer.gotoScene("CreatureCollectorScene", options)
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    if (debug) then print("showing SceneSelect") end

    local headerText = display.newText(sceneGroup, "Hypothesis Local - Mode Select", display.contentCenterX, 30, native.systemFont, 50)
    local helperText = display.newText(sceneGroup, "Tap the header in any mode to return to this screen", display.contentCenterX, 900, native.systemFont, 30)

    -- local change8grid10Image = display.newImageRect(sceneGroup, "themables/8cell10image.png", 300, 100) -- lowres zoomed out
    -- change8grid10Image.anchorX = 0
    -- change8grid10Image.anchorY = 0
    -- change8grid10Image.x = 60
    -- change8grid10Image.y = 100
    -- change8grid10Image:addEventListener("tap", SwitchTo8GridScene10Image)

    -- local change8grid11Image = display.newImageRect(sceneGroup, "themables/8cell11image.png", 300, 100) --hires zoomed out
    -- change8grid11Image.anchorX = 0
    -- change8grid11Image.anchorY = 0
    -- change8grid11Image.x = 390
    -- change8grid11Image.y = 100
    -- change8grid11Image:addEventListener("tap", SwitchTo8GridScene11Image)

    local changeIdle = display.newImageRect(sceneGroup, "themables/idleGame.png", 300, 100)
    changeIdle.anchorX = 0
    changeIdle.anchorY = 0
    changeIdle.x = 60
    changeIdle.y = 300
    changeIdle:addEventListener("tap", SwitchToIdleScene)

    local changeCC = display.newImageRect(sceneGroup, "themables/creatureCollector.png", 300, 100) 
    changeCC.anchorX = 0
    changeCC.anchorY = 0
    changeCC.x = 390
    changeCC.y = 300
    changeCC:addEventListener("tap", SwitchToCCScene)

    local changeScavengerHunts = display.newImageRect(sceneGroup, "themables/ScavengerHunts.png", 300, 100)
    changeScavengerHunts.anchorX = 0
    changeScavengerHunts.anchorY = 0
    changeScavengerHunts.x = 60
    changeScavengerHunts.y = 500
    changeScavengerHunts:addEventListener("tap", SwitchToScavengerHuntsScene)

    local changeInfodump = display.newImageRect(sceneGroup, "themables/Infodump.png", 300, 100) 
    changeInfodump.anchorX = 0
    changeInfodump.anchorY = 0
    changeInfodump.x = 60 
    changeInfodump.y = 700
    changeInfodump:addEventListener("tap", SwitchToInfodumpScene)

    -- local changeMPAreaControl = display.newImageRect(sceneGroup, "themables/MultiplayerAreaControl.png", 300, 100) --multiplayer area tag
    -- changeMPAreaControl.anchorX = 0
    -- changeMPAreaControl.anchorY = 0
    -- changeMPAreaControl.x = 390
    -- changeMPAreaControl.y = 500
    -- changeMPAreaControl:addEventListener("tap", SwitchToMultiplayerAreaControlScene)

    local changePaintTown = display.newImageRect(sceneGroup, "themables/PaintTown.png", 300, 100) --paint the town
    changePaintTown.anchorX = 0
    changePaintTown.anchorY = 0
    changePaintTown.x = 390
    changePaintTown.y = 500
    changePaintTown:addEventListener("tap", SwitchToPaintTownScene)

    local changeSettings = display.newImageRect(sceneGroup, "themables/Settings.png", 300, 100) -- settings
    changeSettings.anchorX = 0
    changeSettings.anchorY = 0
    changeSettings.x = 390
    changeSettings.y = 700
    changeSettings:addEventListener("tap", SwitchToSettingsScene)
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    if (debug) then print("showing SceneSelect") end
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase

    if (debug) then print("hiding SceneSelect") end
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    if (debug) then print("destroying SceneSelect") end
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene