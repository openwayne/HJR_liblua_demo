cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")
-- CC_USE_DEPRECATED_API = true
require "cocos.init"

-- cclog
cclog = function(...)
    print(string.format(...))
end


------------------------------------------------------------------------------------------------------------------------
function SDKKitPlateformCallBackImplWrapper_loginCallBack(retStatus, s_retMessage, s_loginUserId, s_loginUserName, s_loginAuthToken, s_loginOpenId)
    print("lua SDKKitPlateformCallBackImplWrapper_loginCallBack");
    print(retStatus, s_retMessage, s_loginUserId, s_loginUserName, s_loginAuthToken, s_loginOpenId)
    return true
end

function SDKKitPlateformCallBackImplWrapper_logoutCallBack(retStatus, s_retMessage)
    print("lua SDKKitPlateformCallBackImplWrapper_logoutCallBack")
    print(retStatus, s_retMessage)
    return true
end

function SDKKitPlateformCallBackImplWrapper_payCallBack(retMessage, retStatus, s_retMessage, s_payKitOrderId)
    print("lua SDKKitPlateformCallBackImplWrapper_payCallBack")
    print(retStatus, s_retMessage, s_payKitOrderId)
    return true
end

function SDKKitPlateformCallBackImplWrapper_exitGameCallBack(retStatus, s_retMessage)
    print("lua SDKKitPlateformCallBackImplWrapper_exitGameCallBack")
    print(retStatus, s_retMessage)
    return true
end

function SDKKitPlateformCallBackImplWrapper_getOrderResultCallBack(retStatus, s_retMessage)
    print("lua SDKKitPlateformCallBackImplWrapper_getOrderResultCallBack")
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

        local m4 = cc.MenuItemImage:create("pay.png", "pay.png")
        m4:registerScriptTapHandler(
            function() 
                cclog("sdkkit_pay")

             sdkkit_pay(1, {
                    productId="100", 
                    productName="1", 
                    payProductNum="111111", 
                    payOrderId="1", 
                    payServerId="xxxxx", 
                    payServerName="111", 
                    payGameLevel="121212", 
                    payRoleId="11", 
                    payRoleLevel="222222", 
                    payRoleName="1123123123", 
                    payUserId="ddddddddd", 
                    payUserName="10", 
                    payBlance="",
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
                sdkkit_onLogin("1", "2")
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
                sdkkit_onCreateRole("1", "2", "2", "2", "2dd")
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
                sdkkit_onServerRoleInfo("2", "2", 1,"2", "2", "2", "2")
            end)


        m1:setPosition(100, 430)
        m4:setPosition(100, 380)
        m5:setPosition(100, 330)
        m6:setPosition(100, 280)
        m7:setPosition(100, 230)
        m9:setPosition(100, 180)

        m10:setPosition(400, 430)
        m11:setPosition(400, 380)
        m12:setPosition(400, 330)
        m13:setPosition(400, 280)
        m14:setPosition(400, 230)
        m15:setPosition(400, 180)


        
        menuTools = cc.Menu:create(m1, m4, m5, m6, m7, m9, m10, m11, m12, m13, m14, m15)
        local itemWidth = m1:getContentSize().width
        local itemHeight = m1:getContentSize().height
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
