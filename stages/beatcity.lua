function onCreate()
    if (songName == 'Allegro') then
        makeLuaSprite('beatCityDay', 'beatcity/bcDay', -377, -309)
        setScrollFactor('beatCityDay', 1, 1)
        addLuaSprite('beatCityDay')
    elseif (songName == 'Moderato') then
        makeLuaSprite('beatCitySunset', 'beatcity/bcSunset', -377, -309)
        setScrollFactor('beatCitySunset', 1, 1)
        addLuaSprite('beatCitySunset')
    elseif (songName == 'Finale') then
        makeLuaSprite('beatCityNight', 'beatcity/bcNight', -377, -309)
        setScrollFactor('beatCityNight', 1, 1)
        addLuaSprite('beatCityNight')
    end
end