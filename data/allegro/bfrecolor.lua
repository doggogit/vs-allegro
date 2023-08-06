function onCreatePost()
    initLuaShader('colorTransformFixed')
    setSpriteShader('boyfriend', 'colorTransformFixed')
    setShaderFloat('boyfriend', 'redMultiplier', .77)
    setShaderFloat('boyfriend', 'greenMultiplier', .42)
    setShaderFloat('boyfriend', 'blueMultiplier', 0)
end