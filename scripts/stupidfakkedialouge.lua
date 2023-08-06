local dialogueStuff = {} -- will hold the entire split dialogue.txt file
function onCreatePost()
    if not seenCutscene and isStoryMode then
        local bgColors = {['allegro'] = 'a14423', ['moderato'] = '6f2544', ['finale'] = '3c6a6f'}
        makeLuaSprite('diaBg', '', -200, -200)
        makeGraphic('diaBg', screenWidth * 1.3, screenHeight * 1.3, bgColors[songName:lower()])
        setObjectCamera('diaBg', 'hud')
        setObjectOrder('diaBg', getObjectOrder('scoreTxt') + 1)
        setProperty('diaBg.alpha', 0)
        addLuaSprite('diaBg')
        
        runTimer('diaBgFadeIn', 0.83, 5)
        
        local boxSprite = 'diaBoxDay'
        if songName:lower() == 'moderato' then
            boxSprite = 'diaBoxSunset'
        elseif songName:lower() == 'finale' then
            boxSprite = 'diaBoxNight'
        end
    
        makeAnimatedLuaSprite('robo', 'diaBoxes/Allegro_Dialogue', 100, 12)
        local animNames = {'neutral', 'talking neutral', 'pointing at himself', 'describing bg', 'excited', 'talking alt', 'sassy', 'semi-evil neutral', 'semi-evil talking', 'evil neutral', 'talking evil glow'}
        for i = 1, 11 do
            addAnimationByPrefix('robo', 'enter'..i, animNames[i], 24, false)
        end
        setObjectCamera('robo', 'hud')
        addLuaSprite('robo')
        setObjectOrder('robo', getObjectOrder('scoreTxt') + 1)
        setProperty('robo.visible', false)
    
        makeAnimatedLuaSprite('bfPort', 'dialogue/BF_Dialogue', 750, 200)
        addAnimationByPrefix('bfPort', 'idle', 'BF LOOP', 24, false)
        setObjectCamera('bfPort', 'hud')
        setGraphicSize('bfPort', getProperty('bfPort.width') * 0.9)
        addLuaSprite('bfPort')
        setObjectOrder('bfPort', getObjectOrder('scoreTxt') + 2)
        setProperty('bfPort.visible', false)
    
        makeAnimatedLuaSprite('diaBox', 'diaBoxes/'..boxSprite, 0, 325)
        addAnimationByPrefix('diaBox', 'open', 'Speech Bubble Normal Open',30, false)
        addAnimationByIndices('diaBox', 'idle', 'Speech Bubble Normal Open', '13')
        setObjectCamera('diaBox', 'hud')
        setProperty('diaBox.width', 200)
        setProperty('diaBox.height', 200)
        setGraphicSize('diaBox', getProperty('diaBox.width') * 6 * 0.9)
        screenCenter('diaBox', 'x')
        addLuaSprite('diaBox', true)
        setObjectOrder('diaBox', getObjectOrder('scoreTxt') + 5)
        setProperty('diaBox.visible', false)
    
        makeLuaSprite('lilArrow', 'diaBoxes/al-textbox', 1042, 590)
        setGraphicSize('lilArrow', getProperty('lilArrow.width') * 4)
        setProperty('lilArrow.antialiasing', false)
        setObjectOrder('lilArrow', getObjectOrder('diaBox') + 1)
        setObjectCamera('lilArrow', 'hud')
        addLuaSprite('lilArrow')
        setProperty('lilArrow.visible', false)
    
        makeLuaText('dialogueTxt', '',  screenWidth * 0.6, 240, 500)
        setObjectCamera('dialogueTxt', 'hud');
        setObjectOrder('dialogueTxt', getObjectOrder('diaBox') + 2)
        setTextColor('dialogueTxt', '3F2021')
        setTextSize('dialogueTxt', 37);
        setTextBorder('dialogueTxt', 0)
        addLuaText('dialogueTxt');
        setTextFont('dialogueTxt', "PhantomMuff Full Letters 1.1.5.ttf");
        setTextAlignment('dialogueTxt', 'left');
    
        makeLuaText('dropText', '',  screenWidth * 0.6, 242, 502)
        setObjectCamera('dropText', 'hud');
        setObjectOrder('dropText', getObjectOrder('diaBox') + 1)
        setTextColor('dropText', 'D89494')
        setTextSize('dropText', 37);
        setTextBorder('dropText', 0)
        addLuaText('dropText');
        setTextFont('dropText', "PhantomMuff Full Letters 1.1.5.ttf");
        setTextAlignment('dropText', 'left');
        
        local leDiaPath = (currentModDirectory == '' and '' or currentModDirectory..'/')..'data/'..songName:lower()..'/dialogue.txt'
        local diaExists = checkFileExists(leDiaPath)
        local initialText = diaExists and getTextFromFile(leDiaPath) or 'bf:oops!'

        dialogueStuff = split(initialText, ':')
        for i = 1, #dialogueStuff do
            if dialogueStuff[i] == '' then 
                table.remove(dialogueStuff, i)
            end
        end
    end
end

function split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, tostring(match));
    end
    return result;
end

local canAdvance = true
local finishedDialogue = false
local curDiaLine = 1
local curDialogue = {}

local splitText = {}
local lettersShown = 0
local yappin = ''

local finishedLine = false
local inDialogue = false
local seenVid = false

function onStartCountdown()
    if isStoryMode and not finishedDialogue and not seenCutscene then
        if songName:lower() == 'finale' and not seenVid then
            seenVid = true
            startVideo('finale-cutscene')
            return Function_Stop
        end
        setProperty('inCutscene', true)
        runTimer('startDialogue', 1)
        return Function_Stop;
    end
    return Function_Continue;
end

function setUpDialogue()
    if curDiaLine <= 1 then
        playMusic('bg-'..songName:lower(), 0, true)
        soundFadeIn('', 1)
        setProperty('diaBox.visible', true)
        playAnim('diaBox', 'open')
    end

    lettersShown = 0
    canAdvance = true
    yappin = ''
    setProperty('lilArrow.visible', false)
    setTextString('dialogueTxt', '')
    setProperty('dialogueTxt.visible', true)

    curDialogue = {dialogueStuff[curDiaLine], dialogueStuff[curDiaLine+1]} -- person talking, dialogue

    splitText = {}
    for letter in curDialogue[2]:gmatch(".") do table.insert(splitText, letter) end

    if curDialogue[1] ~= 'same' then
        if curDialogue[1] == 'bf' then
            setProperty('bfPort.x',800)
            setProperty('robo.visible', false)
            setProperty('bfPort.visible', true)
            doTweenX('bfPortIn', 'bfPort', 750, 0.1, 'circOut')
        else
            setProperty('robo.visible', true)
            setProperty('bfPort.visible', false)
            playAnim('robo', 'enter'..curDialogue[1]:gsub('al', ''))
        end
    end

    setProperty('diaBox.visible', true)
    inDialogue = true
    finishedLine = false
    playSound('allegroText', 1)
    runTimer('addTx', 0.15 / playbackRate) -- so text ain't floating there before the textbox shows
end

function onTimerCompleted(t, l, ll)
    if t == 'diaBgFadeIn' then
        setProperty('diaBg.alpha', getProperty('diaBg.alpha') + ((1 / 5) * 0.7))
        if getProperty('diaBg.alpha') > 0.7 then setProperty('diaBg.alpha', 0.7) end
    end
    if t == 'leave' then
        canAdvance = false
        runTimer('diaDone', 0.2, 5)
        runTimer('startDaSong', 1.2)
    end

    if t == 'diaDone' then
        removeLuaSprite('robo', true)
        removeLuaSprite('bfPort', true)
        setProperty('diaBg.alpha', getProperty('diaBg.alpha') - ((1 / 5) * 0.7))
        setProperty('diaBox.alpha', getProperty('diaBox.alpha') - (1 / 5))
        setProperty('dialogueTxt.alpha', getProperty('dialogueTxt.alpha') - (1 / 5))
    end

    if t == 'startDaSong' then
        inDialogue = false
        finishedDialogue = true
        removeLuaSprite('lilArrow', true)
        removeLuaSprite('diaBox', true)
        removeLuaSprite('diaBg', true)
        startCountdown()
    end

    if t == 'addTx' then
        if #splitText ~= lettersShown then
            lettersShown = lettersShown + 1 
        else 
            finishedLine = true 
            setProperty('lilArrow.visible', true)
        end

        if not finishedLine then
            yappin = yappin .. splitText[lettersShown]
            playSound('allegroText', 1, 'alle') 
        end

        if inDialogue then
            setTextString('dialogueTxt', yappin)
            runTimer('addTx', 0.04 / playbackRate) 
        end
    end
    if t == 'startDialogue' then
        setUpDialogue()
    end
end

function onUpdate()
    if inDialogue then
        setProperty('lilArrow.visible', finishedLine)
        setTextString('dropText', getTextString('dialogueTxt'))
        setProperty('dropText.alpha', getProperty('dialogueTxt.alpha'))

        local diaAni = getProperty('diaBox.animation.curAnim.name')
        if diaAni == 'open' and getProperty('diaBox.animation.curAnim.finished') then        
            playAnim('diaBox', 'idle')
        end

        if finishedLine and not getProperty('bfPort.animation.curAnim.finished') then
            if getProperty('bfPort.animation.curAnim.curFrame') == 5 then
                setProperty('bfPort.animation.curAnim.curFrame', 5)
                setProperty('bfPort.animation.curAnim.finished', true)
            end
        end

        if not finishedDialogue and inDialogue then
            if keyJustPressed('accept') and canAdvance then
                if not finishedLine then
                    finishedLine = true
                    cancelTimer('addTx')
                    playSound('allegroEnter')
                    setTextString('dialogueTxt', curDialogue[2])
                else
                    if curDiaLine <= #dialogueStuff - 1 then
                        curDiaLine = curDiaLine + 2
                    end
                    updateDialogue()
                end
            elseif keyJustPressed('back') then
                runTimer('leave', 0.1)
            end
        end
    end
end

function updateDialogue()
    canAdvance = false
    playSound('allegroEnter', 1)
    if curDiaLine <= #dialogueStuff - 1 then
        setUpDialogue()
    else
        runTimer('leave', 0.1)
    end
end