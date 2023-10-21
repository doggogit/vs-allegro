function onCreatePost()
    initLuaShader('colorTransformFixed')
    setSpriteShader('boyfriend', 'colorTransformFixed')

    if (songName == 'Allegro') then
        setShaderFloat('boyfriend', 'redMultiplier', .77)
        setShaderFloat('boyfriend', 'greenMultiplier', .42)
        setShaderFloat('boyfriend', 'blueMultiplier', 0)
    elseif (songName == 'Moderato') then
        setShaderFloat('boyfriend', 'redMultiplier', .22)
        setShaderFloat('boyfriend', 'greenMultiplier', .066)
        setShaderFloat('boyfriend', 'blueMultiplier', .086)
    elseif (songName == 'Finale') then
        setShaderFloat('boyfriend', 'redMultiplier', -.05)
        setShaderFloat('boyfriend', 'greenMultiplier', .1)
        setShaderFloat('boyfriend', 'blueMultiplier', .05)
    end
end
