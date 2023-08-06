function onCreatePost()
    initLuaShader('colorTransformFixed')
    setSpriteShader('boyfriend', 'colorTransformFixed')
    setShaderFloat('boyfriend', 'redMultiplier', -.05)
    setShaderFloat('boyfriend', 'greenMultiplier', .1)
    setShaderFloat('boyfriend', 'blueMultiplier', .05)
end