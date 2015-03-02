cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")
-- CC_USE_DEPRECATED_API = true
require "cocos.init"

-- cclog
cclog = function(...)
    print(string.format(...))
end


------------------------------------------------------------------------------------------------------------------------
function SDKKitPlateformCallBackImplWrapper_loginCallBack(retStatus, retMessage, loginUserId, loginAuthToken)
    print("ddddd");
    print(retStatus, retMessage, loginUserId, loginAuthToken)
    return true
end

function SDKKitPlateformCallBackImplWrapper_logoutCallBack(retStatus, s_retMessage)
    print(retStatus, s_retMessage)
    return true
end

function SDKKitPlateformCallBackImplWrapper_payCallBack(retMessage, loginUserId, loginAuthToken, loginServerId, payKitOrderId)
    print(retMessage, loginUserId, loginAuthToken, loginServerId, payKitOrderId)
    return true
end

function SDKKitPlateformCallBackImplWrapper_exitGameCallBack(retStatus, s_retMessage)
    print(retStatus, s_retMessage)
    return true
end

function SDKKitPlateformCallBackImplWrapper_getOrderResultCallBack(retStatus, s_retMessage)
    print(retStatus, s_retMessage)
    return true
end
------------------------------------------------------------------------------------------------------------------------
-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
end

local function initGLView()
    local director = cc.Director:getInstance()
    local glView = director:getOpenGLView()
    if nil == glView then
        glView = cc.GLViewImpl:create("Lua Empty Test")
        director:setOpenGLView(glView)
    end

    director:setOpenGLView(glView)

    glView:setDesignResolutionSize(1024, 768, cc.ResolutionPolicy.NO_BORDER)

    --turn on display FPS
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)
end

local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    initGLView()

    ---------------

    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()



    -- create menu
    local function createLayerMenu()
        local layerMenu = cc.Layer:create()
        

        local m1 = cc.MenuItemImage:create("login.png", "login.png")

        m1:registerScriptTapHandler(
            function() 
                cclog("sdkkit_login")
                sdkkit_login()
            end)

        local m2 = cc.MenuItemImage:create("kitcenter.png", "kitcenter.png")
        m2:registerScriptTapHandler(
            function() 
                cclog("sdkkit_kitCenter")
                sdkkit_kitCenter()
            end)

        local m3 = cc.MenuItemImage:create("switchaccount.png", "switchaccount.png")
        m3:registerScriptTapHandler(
            function() 
                cclog("sdkkit_switchAccount")
                sdkkit_switchAccount()
            end)
        local m4 = cc.MenuItemImage:create("pay.png", "pay.png")
        m4:registerScriptTapHandler(
            function() 
                cclog("sdkkit_pay")

             sdkkit_pay(1, {
                    payRate="100", 
                    payProductNum="1", 
                    payOrderId="111111", 
                    payServerId="1", 
                    payServerName="xxxxx", 
                    payGameLevel="111", 
                    payRoleId="121212", 
                    payRoleLevel="11", 
                    payRoleName="222222", 
                    payUserId="1123123123", 
                    payUserName="ddddddddd", 
                    payBlance="10", 
                    extInfo="dandandandadn", 
                    })
            end)
        local m5 = cc.MenuItemImage:create("usercenter.png", "usercenter.png")

        m5:registerScriptTapHandler(
            function() 
                cclog("sdkkit_userCenter")
                sdkkit_userCenter()
            end)
        local m6 = cc.MenuItemImage:create("logout.png", "logout.png")
        m6:registerScriptTapHandler(
            function() 
                cclog("sdkkit_logout")
                sdkkit_logout()
            end)
        local m7 = cc.MenuItemImage:create("onoderinfo.png", "onoderinfo.png")
        m7:registerScriptTapHandler(
            function() 
                cclog("sdkkit_getOrderInfo")
                sdkkit_getOrderInfo("11122233")
            end)
        local m8 = cc.MenuItemImage:create("floatwindow.png", "floatwindow.png")
        m8:registerScriptTapHandler(
            function() 
                cclog("sdkkit_floatWindow")
                sdkkit_floatWindow(true)
            end)
        local m9 = cc.MenuItemImage:create("exitgame.png", "exitgame.png")
        m9:registerScriptTapHandler(
            function() 
                cclog("sdkkit_exitGame")
                sdkkit_exitGame()
            end)
        local m10 = cc.MenuItemImage:create("onlogin.png", "onlogin.png")
        m10:registerScriptTapHandler(
            function() 
                cclog("sdkkit_onLogin")
                sdkkit_onLogin("1", "2", "3", "4")
            end)
        local m11 = cc.MenuItemImage:create("onpay.png", "onpay.png")
        m11:registerScriptTapHandler(
            function() 
                cclog("sdkkit_onPay")
                sdkkit_onPay("1", "2", "2", "2", "2", "2", "2", "2", "2")
            end)
        local m12 = cc.MenuItemImage:create("onupgrade.png", "onupgrade.png")
        m12:registerScriptTapHandler(
            function() 
                cclog("sdkkit_onUpgrade")
                sdkkit_onUpgrade("1", "2", "2", "2", "2", "2")
            end)
        local m13 = cc.MenuItemImage:create("oncreaterole.png", "oncreaterole.png")
        m13:registerScriptTapHandler(
            function() 
                cclog("sdkkit_onCreateRole")
                sdkkit_onCreateRole("1", "2", "2", "2")
            end)
        local m14 = cc.MenuItemImage:create("onbuttonclk.png", "onbuttonclk.png")
        m14:registerScriptTapHandler(
            function() 
                cclog("sdkkit_onButtonClick")
                sdkkit_onButtonClick("1", "2")
            end)
        local m15 = cc.MenuItemImage:create("onserverroleinfo.png", "onserverroleinfo.png")
        m15:registerScriptTapHandler(
            function() 
                cclog("sdkkit_onServerRoleInfo")
                sdkkit_onServerRoleInfo("2", 1,"2", "2", "2")
            end)


        m1:setPosition(100, 30)
        m2:setPosition(300, 30)
        m3:setPosition(500, 30)
        m4:setPosition(700, 30)
        m5:setPosition(900, 30)
        m6:setPosition(100, 230)
        m7:setPosition(300, 230)
        m8:setPosition(500, 230)
        m9:setPosition(700, 230)
        m10:setPosition(900, 230)
        m11:setPosition(100, 470)
        m12:setPosition(300, 430)
        m13:setPosition(500, 430)
        m14:setPosition(700, 430)
        m15:setPosition(900, 430)


        
        menuTools = cc.Menu:create(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15)
        local itemWidth = m8:getContentSize().width
        local itemHeight = m8:getContentSize().height
        menuTools:setPosition(origin.x + itemWidth/2, origin.y + itemHeight/2)
        layerMenu:addChild(menuTools)

        return layerMenu
    end


    -- run
    local sceneGame = cc.Scene:create()
    sceneGame:addChild(createLayerMenu())
    cc.Director:getInstance():runWithScene(sceneGame)
end

xpcall(main, __G__TRACKBACK__)
