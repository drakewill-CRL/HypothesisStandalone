local composer = require("composer")
require("helpers")

function CreateSquareGrid(gridSize, cellSize, gridGroup, cellCollection)
    --size is square, X by Y size. Must be odd so that i can have a center square. Even values get treated as one larger to be made odd.
    if (debug) then print("Starting CreateSquareGrid") end
    local padding = 1 --space between cells.
    local range = math.floor(gridSize / 2) -- 7 becomes 3, which is right. 6 also becomes 3.

    for x = -range, range, 1 do
        for y = -range, range, 1 do
            --create cell, tag it with x and y values.
            local newSquare = display.newRect(gridGroup, display.contentCenterX + (cellSize * x) + x , display.contentCenterY + (cellSize * y) + y , cellSize, cellSize) --x y w h
            newSquare.gridX = x
            newSquare.gridY = -y --invert this so cells get identified top-to-bottom, rather than bottom-to-top
            newSquare.name = "" --added for terrain/location support
            newSquare.type = ""--added for terrain/location support
            newSquare:addEventListener("tap", debuggerHelperSquare) --for debugging display grid, show the cell's plus code by click/tap
            cellCollection[#cellCollection + 1] = newSquare
        end
    end

    if (debug) then print("Done CreateSquareGrid") end
end

function CreateRectangleGrid(gridSize, cellSizeX, cellSizeY, gridGroup, cellCollection, tapHandlerType)
    --size is rectangular, X by Y size. Must be odd so that i can have a center square. Even values get treated as one larger to be made odd.
    if (debug) then print("Starting CreateSquareGrid") end
    local padding = 1 --space between cells.
    local range = math.floor(gridSize / 2) -- 7 becomes 3, which is right. 6 also becomes 3.

    for x = -range, range, 1 do
        for y = -range, range, 1 do
            --create cell, tag it with x and y values.
            local newSquare = display.newRect(gridGroup,  display.contentCenterX + (cellSizeX * x), display.contentCenterY + (cellSizeY * y), cellSizeX, cellSizeY) --x y w h
            newSquare.gridX = x
            newSquare.gridY = -y --invert this so cells get identified top-to-bottom, rather than bottom-to-top
            newSquare.name = "" --added for terrain/location support
            newSquare.type = ""--added for terrain/location support
            newSquare.pluscode = "" --to potentially be filled in by the game mode
            newSquare.MapDataId = 0 --for area control mode
            newSquare.fill = {1, .01} --default to transparent, but using 0, 0 means they don't register at all?
            --newSquare.fill = {math.random(), .5} --Uncomment this to make the grid visible for debug/layout purposes. Also need to comment out the fill = {0.0}  in painttownscene.
            if (tapHandlerType == "debug") then
                newSquare:addEventListener("tap", debuggerHelperSquare) --for debugging display grid, show the cell's plus code by click/tap
            elseif (tapHandlerType == "ac") then
                newSquare:addEventListener("tap", showAreaClaim) --singleplayer gameplay dialog.
            elseif (tapHandlerType == "mac") then
                newSquare:addEventListener("tap", multiplayerAreaClaim) --multiplayer gameplay dialog.
            elseif (tapHandlerType == "painttown") then
                --no listener needed here.
                newSquare:addEventListener("tap", paintTownTapListener)
            end
            cellCollection[#cellCollection + 1] = newSquare
        end
    end

    if (debug) then print("Done CreateSquareGrid") end
end

function paintTownTapListener(event)
    --Update display debug data, but that's all.
    tapData.text = "Cell Tapped: " .. event.target.pluscode
    tappedCell = event.target.pluscode
end

function debuggerHelperSquare(event)
    tapData.text = "Cell Tapped: " .. event.target.pluscode
    tappedCell = event.target.pluscode
    forceRedraw = true
    if (debug) then
        print("displaying data on a cell:" .. event.target.name)
        print(event.target == null)
        print(event.target.type)
    end
    native.showAlert("Cell", event.target.pluscode .. " | " .. event.target.name .. " | " .. typeNames[event.target.type])
end

function showAreaClaim(event)
    tapData.text = "Cell Tapped: " .. event.target.pluscode
    local noplus = removePlus(event.target.pluscode)
    tappedCell = event.target.pluscode --needs to be before this print or it screws up on the first tap
    redrawOverlay = true
    if (debug) then 
        print("showareaclaim clicked")
    end
    if (event.target.type == nil or event.target.type == "") then
        if (debug) then print("returning false, not showing area claim") end
        return false
    end
    --dont claim areas you already own
    if (CheckAreaOwned(event.target.MapDataId)) then
        if (debug) then print("returning false, already owned") end
        return false
    end

    if (event.target.name == "") then
        tappedAreaName = typeNames[event.target.type]
    else
        tappedAreaName = event.target.name
    end

    tappedAreaScore = 0 --i don't save this locally, this requires a network call to get and update
    tappedAreaMapDataId = event.target.MapDataId
    composer.showOverlay("overlayAreaClaim", {isModal = true})
    return false
end

function multiplayerAreaClaim(event)
    tapData.text = "Cell Tapped: " .. event.target.pluscode
    if (event.target.type == nil or event.target.type == "") then
        return false
    end

    if (event.target.name == "") then
        tappedAreaName = typeNames[event.target.type]
    else
        tappedAreaName = event.target.name
    end

    local noplus = removePlus(event.target.pluscode)
    tappedCell = event.target.pluscode --needs to be before this print or it screws up on the first tap
    tappedAreaScore = 0 --i don't save this locally, this requires a network call to get and update
    tappedAreaMapDataId = event.target.MapDataId
    composer.showOverlay("overlayMPAreaClaim", {isModal = true})
end