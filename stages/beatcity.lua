function onCreate()
    if (songName == 'Allegro') then
        makeLuaSprite('beatCityDay', 'allegro/stage/beatcity/bcDay', -377, -309)
        setScrollFactor('beatCityDay', 1, 1)
        addLuaSprite('beatCityDay')
    elseif (songName == 'Moderato') then
        makeLuaSprite('beatCitySunset', 'allegro/stage/beatcity/bcSunset', -377, -309)
        setScrollFactor('beatCitySunset', 1, 1)
        addLuaSprite('beatCitySunset')
    elseif (songName == 'Finale') then
        makeLuaSprite('beatCityNight', 'allegro/stage/beatcity/bcNight', -377, -309)
        setScrollFactor('beatCityNight', 1, 1)
        addLuaSprite('beatCityNight')
    end
end