function onCreatePost()
    initLuaShader('colorTransformFixed')
    setSpriteShader('boyfriend', 'colorTransformFixed')
    setShaderFloat('boyfriend', 'redMultiplier', .22)
    setShaderFloat('boyfriend', 'greenMultiplier', .066)
    setShaderFloat('boyfriend', 'blueMultiplier', .086)
end