local logoSize = 0
local yeah = true

function onCreate()
    setProperty('skipCountdown',true)
end

function onCreatePost()
    --lang = 'es'
    --lang = 'fr'


    setPropertyFromClass('PauseSubState', 'songName', 'pauseMario')
    
    setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-cat')
    makeLuaSprite('bg', 'dec_2', -950, -400);
    makeLuaSprite('bg-front', 'dec_1', -950, -400);
    
    makeLuaSprite('bg2', 'bg2', -1450, -870);

    logoImage = 'TCMS_logo'
    stageImage = 'front'

    if lang == 'fr' or lang == 'es' then
        logoImage = 'TCMS_logo-'..lang
        stageImage = 'front-'..lang
    end

    makeLuaSprite('logo', logoImage, 0, 0);
    screenCenter('logo')
    setScrollFactor('logo', 0, 0)
    setGraphicSize('logo', 0, 0)
    
    makeLuaSprite('bg-front2', stageImage, -1450, -870);

    makeAnimatedLuaSprite('drapes', 'ridaux', 0, 0);
    addAnimationByPrefix('drapes', 'open', 'ouvre', 30, false);
    addAnimationByPrefix('drapes', 'close', 'ferme', 30, false);
    setObjectCamera('drapes', 'other')
    screenCenter('drapes')
    setProperty('drapes.scale.x', 0.7)
    setProperty('drapes.scale.y', 0.7)

    addLuaSprite('bg', false)
    addLuaSprite('bg-front', true)
    addLuaSprite('logo', true)
    addLuaSprite('drapes', true)

    setProperty('dad.alpha', 0)
    setProperty('boyfriend.alpha', 0)
    setProperty('drapes.alpha', 0)
    setProperty('camHUD.alpha', 0)
    triggerEvent('Camera Follow Pos',0,125)
end

function onBeatHit()
    if curBeat == 4 then
        setProperty('dad.alpha', 1)
        setProperty('boyfriend.alpha', 1)
        triggerEvent('Play Animation','hey','bf')
        triggerEvent('Play Animation','hey','dad')
        doTweenAlpha('camHUDtween', 'camHUD', 1, 1)
    end
    if curBeat == 7 then
        triggerEvent('Camera Follow Pos')
    end
    if curBeat == 104 then
        setProperty('drapes.alpha', 1)
        objectPlayAnimation('drapes', 'close', true);
    end
    if curBeat == 106 then
        setProperty('cameraSpeed', 10)
        triggerEvent('Camera Follow Pos',0,-100)
        setProperty('dad.x', getProperty('dad.x') - 100)
        setProperty('boyfriend.x', getProperty('boyfriend.x') + 100)
        value1 = 0.5
        setProperty("defaultCamZoom",value1) 
        setProperty("camGame.zoom",value1)
        setProperty('bg.y', -600)
        setProperty('bg.scale.x', 1.5)
        setProperty('bg.scale.y', 1.5)
        setProperty('bg-front.y', -500)
        setProperty('bg-front.scale.x', 1.5)
        setProperty('bg-front.scale.y', 1.5)
        addLuaSprite('bg2', false)
        addLuaSprite('bg-front2', true)
    end
    if curBeat == 108 then
        setProperty('drapes.x', getProperty('drapes.x')+100)
        setProperty('drapes.y', getProperty('drapes.y')+100)
        objectPlayAnimation('drapes', 'open', true);
    end
    if curBeat == 208 then
        setProperty('drapes.alpha', 1)
        setProperty('drapes.x', getProperty('drapes.x')-100)
        setProperty('drapes.y', getProperty('drapes.y')-100)
        objectPlayAnimation('drapes', 'close', true);
    end
    if curBeat % 2 == 0 then
        setProperty('iconP1.angle', -15)
        doTweenAngle('angleP1', 'iconP1', 0, (getPropertyFromClass('Conductor', 'crochet') / 1300 * getProperty('gfSpeed')), 'quadOut')
        setProperty('iconP2.angle', 15)
        doTweenAngle('angleP2', 'iconP2', 0, (getPropertyFromClass('Conductor', 'crochet') / 1300 * getProperty('gfSpeed')), 'quadOut')
    else
        setProperty('iconP1.angle', 15)
        doTweenAngle('angleP1', 'iconP1', 0, (getPropertyFromClass('Conductor', 'crochet') / 1300 * getProperty('gfSpeed')), 'quadOut')
        setProperty('iconP2.angle', -15)
        doTweenAngle('angleP2', 'iconP2', 0, (getPropertyFromClass('Conductor', 'crochet') / 1300 * getProperty('gfSpeed')), 'quadOut')
    end
end

function onUpdate()
    if curBeat < 2 then
        if yeah then
            logoSize = logoSize + 0.02
            if logoSize > 2 then
                yeah = false
            end
        else
            if logoSize > 1.7 then
                logoSize = logoSize - 0.02
            end
        end
    end

    if curBeat > 2 and logoSize > 0 then
        logoSize = logoSize - 0.03
    end
    if curBeat > 2 and logoSize < 0 then
        removeLuaSprite('logo')
    end
    
	setProperty('logo.scale.x', logoSize)
	setProperty('logo.scale.y', logoSize)

	if getProperty('drapes.animation.curAnim.name') == 'open' and getProperty('drapes.animation.curAnim.finished') then
		setProperty('drapes.alpha', 0);
    end
end

function onPause()
    playSound('pause')
end

function onResume()
    playSound('resume')
end