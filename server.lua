local EXPECTED_RESOURCE_NAME = 'RiseNova_TalkSync'

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return 
    end

    local currentName = GetCurrentResourceName()

    if currentName ~= EXPECTED_RESOURCE_NAME then
        print('^1====================================================^7')
        print('^1[RiseNova Scripts] RESOURCE NAME MISMATCH!^7')
        print(('^3Expected:^7 ^2%s^7'):format(EXPECTED_RESOURCE_NAME))
        print(('^3Current:^7  ^1%s^7'):format(currentName))
        print('^1Please rename the resource folder to the expected name^7')
        print('^1to ensure proper support, updates and functionality.^7')
        print('^1====================================================^7')

        StopResource(currentName)
    else
        print(('^2[RiseNova Scripts]^7 %s started successfully.'):format(EXPECTED_RESOURCE_NAME))
    end
end)
