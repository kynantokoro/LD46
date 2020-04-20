function love.load()
    consoleLine() 
    print("love.load()")

    --import libraries and CONSTANTS
    require "src/import"

    graphicsInit()

    inputInit()

    audioInit()

    --global timer 
    t = 0

    current_room = nil

    --load objects
    local object_files = {}
    recureiveEnumerate("src/objects", object_files)
    requireFiles(object_files)

    --load rooms
    local room_files = {}
    recureiveEnumerate("src/rooms", room_files)
    requireFiles(room_files)

    gotoRoom("rTitle")
    consoleLine() 
end

function love.update(dt)
    
    Timer.update(dt)

    --increment global timer 
    t = t + 1   

    if current_room then current_room:update(dt) end 
end 

function love.draw() 
   -- camera.scale = (0.5)
    love.graphics.setCanvas(vCanvas)
    love.graphics.clear()
    
        -------------GAME------------

        --draw things on the virtual canvas
        if current_room then current_room:draw() end 
        --camera:draw()

        -------------GAME------------
    
    love.graphics.setCanvas()
    cEffect(function()
        --scale the vCanvas
        love.graphics.push()
        love.graphics.translate(canvas_offset.x, canvas_offset.y)
        love.graphics.scale(scale.x, scale.y)
        --draw the vCanvas
        --set the x_scale to 2 if mood is ATARI
        love.graphics.draw(vCanvas, 0, 0, 0, 1, 1)
        love.graphics.pop()
    end)
    love.graphics.translate(canvas_offset.x, canvas_offset.y)
    -------------GUI------------

    -------------GUI------------

end 

function graphicsInit()

    love.graphics.setDefaultFilter("nearest")

    pscale = love.window.getDPIScale()

    local windowWidth, windowHeight = love.graphics.getDimensions()

    scale = {
        x = windowWidth / (GAMEWIDTH),
        y = windowHeight / GAMEHEIGHT
    }

    gamezoom = math.floor(math.min(scale.x, scale.y))
    if gamezoom <= 1 then gamezoom = 1 end

    canvas_offset = {
        x = (scale.x - gamezoom) * (GAMEWIDTH/2),
        y = (scale.y - gamezoom) * (GAMEHEIGHT/2)
    }

    scale.x, scale.y = gamezoom, gamezoom

    gwidth = windowWidth - (canvas_offset.x * 2)
    gheight = windowHeight - (canvas_offset.y * 2)

    --shaders initialize 
    cEffect = moonshine(windowWidth, windowHeight, moonshine.effects.desaturate)
    vEffect = moonshine(GAMEWIDTH, GAMEHEIGHT, moonshine.effects.pixelate).chain(moonshine.effects.dmg)
    --vEffect.scanlines.opacity = 0.1
    --vEffect.dmg.palette = "default"
    vEffect.pixelate.size = 0.0001
    --graphics initialization
    cEffect.desaturate.tint = {255, 0, 0}
    cEffect.desaturate.strength = 0

    camera = Camera(0, 0, GAMEWIDTH, GAMEHEIGHT)

    camera.draw_deadzone = true

    vCanvas = love.graphics.newCanvas(GAMEWIDTH, GAMEHEIGHT)

    fnt = love.graphics.newFont("res/font/TimesNewPixel.fnt", "res/font/TimesNewPixel_0.png")
    love.graphics.setFont(fnt)

    if toFullscreen ~= true then
        canvas_offset.x = 0
        canvas_offset.y = 0 
        love.window.updateMode( gwidth, gheight)
    end

    
    camera:setFollowLerp(0.1) 
    camera:setFollowStyle("PLATFORMER")

    love.graphics.setLineWidth(1)

    roomInit()

    print("graphics initialized")

end  

function inputInit() 
    input:bind("left", "left")
    input:bind("right", "right")
    input:bind("up", "up")
    input:bind("down", "down")
    input:bind("r", "enter")
    input:bind("space", "space")

    input:bind('f1', function()
        print("Before collection: " .. collectgarbage("count")/1024)
        collectgarbage()
        print("After collection: " .. collectgarbage("count")/1024)
        print("Object count: ")
        local counts = type_count()
        for k, v in pairs(counts) do print(k, v) end
        consoleLine() 
    end)

    input:bind('f11', function()
        switchFullscreen() 
    end)

    input:bind('f', function()
        switchFullscreen() 
    end)

    print("input initialized")

end

function audioInit() 
    --wav sfx loading 
    snd_jump1 = love.audio.newSource("res/SFX/jump8bit.wav", "static")
    snd_jump2 = love.audio.newSource("res/SFX/jump8bit.wav", "static")
    snd_jump3 = love.audio.newSource("res/SFX/jump8bit.wav", "static")
    snd_landing = love.audio.newSource("res/SFX/landing8bit.wav", "static")
    snd_attack = love.audio.newSource("res/SFX/landing8bit.wav", "static")
    snd_pickdown = love.audio.newSource("res/SFX/pickdown8bit.wav", "static")
    snd_pickup = love.audio.newSource("res/SFX/pickup8bit.wav", "static")
    snd_walking = love.audio.newSource("res/SFX/walking8bit.wav", "static")
    snd_thankyou = love.audio.newSource("res/SFX/thankyou8bit.wav", "static")
    snd_yourewelcome = love.audio.newSource("res/SFX/yourewelcome8bit.wav", "static")
    snd_gun = love.audio.newSource("res/SFX/GUN8bit.wav", "static")
    snd_key = love.audio.newSource("res/SFX/KeyPickup8bit.wav", "static")
    snd_dead = love.audio.newSource("res/SFX/DEAD8bit.wav", "static")
    snd_alldead = love.audio.newSource("res/SFX/ALLDEAD8bit.wav", "static")
    snd_found = love.audio.newSource("res/SFX/FOUND8bit.wav", "static")
    snd_door = love.audio.newSource("res/SFX/DOOR8bit.wav", "static")

    --tracker files loading
    love.audio.setEffect("myReverb", {type = "reverb", gain = 1, density = 5, decaytime = 3})
    --snd_noise = love.audio.newSource("res/tracker/gamenoise.it", "stream")
    --snd_noise:setEffect("myReverb")

    snd_yourewelcome:setPitch(0.5)
    snd_landing:setPitch(1.4)
    snd_walking:setVolume(0.6)
    snd_jump1:setVolume(0.6)
    snd_jump2:setVolume(0.6)
    snd_jump3:setVolume(0.6)
    snd_jump2:setPitch(1.02)
    snd_jump3:setPitch(1.04)

    --love.audio.play(snd_noise)
    --love.audio.setVolume(0.8)
end 

--this function loops throgh item in a folder and list it in a table
function recureiveEnumerate(folder, file_list) 
    local items = love.filesystem.getDirectoryItems(folder) 
    for _, item in ipairs(items) do 
        local file_path = folder .. "/" .. item
        local file_info = love.filesystem.getInfo(file_path)
        if file_info.type == "file" then 
            table.insert(file_list, file_path) 
            --also checks if the file is a directory and if so loops through in that too
        elseif file_info.type == "directory" then 
            recureiveEnumerate(file_path, file_list) 
        end 
    end 
end 

--loop through a list and require those file
function requireFiles(files)
    for _, file in ipairs(files) do
        print("loaded :" .. file)
        local file = file:sub(1, -5)
        require(file)
    end
end

function gotoRoom(room_type, ...)
    print("current_room is :" ..  room_type)
    current_room = _G[room_type](...)
end 


function love.resize(w, h)
    print("resized " .. " w : " .. w .. " h : " .. h)
    graphicsInit()
end

function love.keyreleased(key) 
    if key == "escape" then 
        love.event.quit()
    end 
end 

function consoleLine() 
    print("--------------------------")
end 

function count_all(f)
    local seen = {}
    local count_table
    count_table = function(t)
        if seen[t] then return end
            f(t)
	    seen[t] = true
	    for k,v in pairs(t) do
	        if type(v) == "table" then
		    count_table(v)
	        elseif type(v) == "userdata" then
		    f(v)
	        end
	end
    end
    count_table(_G)
end

function type_count()
    local counts = {}
    local enumerate = function (o)
        local t = type_name(o)
        counts[t] = (counts[t] or 0) + 1
    end
    count_all(enumerate)
    return counts
end

global_type_table = nil
function type_name(o)
    if global_type_table == nil then
        global_type_table = {}
            for k,v in pairs(_G) do
	        global_type_table[v] = k
	    end
	global_type_table[0] = "table"
    end
    return global_type_table[getmetatable(o) or 0] or "Unknown"
end

function switchFullscreen()
    local dWidth, dHeight = love.window.getDesktopDimensions()
    
    toFullscreen = not love.window.getFullscreen()

    if toFullscreen then print("now full screen" .. dWidth .. dHeight) 
    else print("exit full screen ") end

    love.window.setFullscreen(toFullscreen, "desktop")

    graphicsInit()

end

function roomInit()
    --shaders initialize 
    --cEffect = moonshine(windowWidth, windowHeight, moonshine.effects.desaturate)
    --vEffect = moonshine(GAMEWIDTH*2, GAMEHEIGHT, moonshine.effects.scanlines)
    --vEffect.scanlines.opacity = 0.1
    --graphics initialization
    cEffect.desaturate.tint = {255, 0, 0}
    cEffect.desaturate.strength = 0

    camera = Camera(0, 0, GAMEWIDTH, GAMEHEIGHT)

    camera.draw_deadzone = true

    vCanvas = love.graphics.newCanvas(GAMEWIDTH, GAMEHEIGHT)
    
    camera:setFollowLerp(1.0) 

    love.graphics.setLineWidth(1)
end