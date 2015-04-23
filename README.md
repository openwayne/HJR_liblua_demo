
![cocos2d-x](https://camo.githubusercontent.com/62f509218415e5f677180a479fd65cfe54a17f04/687474703a2f2f7777772e636f636f7332642d782e6f72672f6174746163686d656e74732f3830312f636f636f733264785f706f7274726169742e706e67)


#快发大师Lua接入文档
------------------

##1.介绍
>   好接入为CP商提供一套第三方SDK接入解决方案，整个接入过程，不改变任何SDK的功能、特性、参数等，对于最终玩家而言是完全透明无感知的。 目的是让CP商能有更多时间更专注于游戏本身的品质，无需花费大量时间在对接第三方渠道上。

[DEMO](https://github.com/openwayne/HJR_liblua_demo)
[LIB](https://github.com/openwayne/liblua_sdkkit)
    

##2.接入流程
![流程](http://www.haojieru.com/ueditor/php/upload/image/20150211/1423620197362069.png)
##3.接入步骤
*  把`lua_sdk`文件夹下的android文件夹中的`工程`导入`eclipse`
*  对项目的`AndroidManifest.xml`进行配置
    *    权限声明
    ```xml
        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
        <uses-permission android:name="android.permission.READ_PHONE_STATE" />
        <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
        <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
        <uses-permission android:name="android.permission.READ_LOGS"/>
        <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    ```

    *   `application`节点内配置

    ```xml
        <application
            android:allowBackup="true"
            android:name="com.hjr.sdkkit.bridge.app.HJRSDKKitBaseApplication"
            android:icon="@drawable/ic_launcher"
            android:label="@string/app_name" >
            <activity
                android:name="com.kfmaster.sdkkit.KFMasterActivity"
                android:configChanges="screenSize|keyboardHidden|orientation"
                android:label="@string/app_name" >
                <intent-filter>
                    <action android:name="android.intent.action.MAIN" />
                    <category android:name="android.intent.category.LAUNCHER" />
                </intent-filter>
            </activity>
            <!-- 游戏密钥：填入gamekey -->
            <meta-data
                android:name="HJR_GAMEKEY"
                android:value="d128360c051b94077118048bf92457fd" >
            </meta-data>
            <!--请勿修改！-->
            <meta-data
                android:name="HJR_CHANNEL"
                android:value="\ 0103" >
            </meta-data>
            <!--注意：在打正式包之前，务必修改 HJR_DATA_URL_DEBUG = false-->
            <meta-data
                android:name="HJR_DATA_URL_DEBUG"
                android:value="true" />
        </application>
    ```

    *   `AndroidManifest.xml`配置注意事项
        *   游戏如果有自己的`application`， 需要继承至`com.hjr.sdkkit.bridge.app.HJRSDKKitBaseApplication`，并且配置`android:name="你自己的Application"`中。
        *   如果没有自己的`application`直接配置`android:name="com.hjr.sdkkit.bridge.app.HJRSDKKitBaseApplication"`中。
    *   程序内修改
        *   打开自己工程的main activity，添加以下代码至onCreate方法
            
            ```java
                private HJRSDKKitPlateformCore plateformSDK;
            
                @Override
                protected void onCreate(final Bundle savedInstanceState) {
                    super.onCreate(savedInstanceState);
                    
                    plateformSDK = HJRSDKKitPlateformCore.initHJRPlateform(new SDKKitPlateformCallBackImplWrapper());
                    SDKKitPlateformBusinessImplWrapper.setContext(this, plateformSDK);
                    SDKKitPlatformCollectionsImplWrapper.setPlateform(plateformSDK, this);
                    plateformSDK.Business.init(this);
                    SDKKitPlatformJniHelper.nativeSetContext(this);
                }
                
            ```

        *   打开自己工程的main activity，添加生命周期函数
            
            ```java
            
                // /
                //以下接口，无需做任何修改，拷贝进游戏的主Activity即可
                // ------------------------------生命周期函数 开始-------------------------
                // /
                @Override
                protected void onResume() {
                    super.onResume();
                    if (plateformSDK != null) {
                        plateformSDK.LifeCycle.onResume();
                    }
                }
            
                @Override
                protected void onPause() {
                    super.onPause();
                    if (plateformSDK != null) {
                        plateformSDK.LifeCycle.onPause();
                    }
                }
            
                @Override
                protected void onStop() {
                    super.onStop();
                    if (plateformSDK != null) {
                        plateformSDK.LifeCycle.onStop();
                    }
                }
            
                @Override
                protected void onDestroy() {
                    super.onDestroy();
                    if (plateformSDK != null) {
                        plateformSDK.LifeCycle.onDestroy();
                    }
                    
                }
            
                @Override
                public void onConfigurationChanged(Configuration newConfig) {
                    super.onConfigurationChanged(newConfig);
                    if (plateformSDK != null) {
                        plateformSDK.LifeCycle.onConfigurationChanged(newConfig);
                    }
                }
                
                @Override
                protected void onSaveInstanceState(Bundle outState) {
                    super.onSaveInstanceState(outState);
                    if (plateformSDK != null) {
                        plateformSDK.LifeCycle.onSaveInstanceState(outState);
                    }
                }
                
                @Override
                protected void onNewIntent(Intent intent) {
                    super.onNewIntent(intent);
                    if (plateformSDK != null) {
                        plateformSDK.LifeCycle.onNewIntent(intent);
                    }
                }
            
                // /
                // ------------------------------生命周期函数 结束-------------------------
                // /

            ```



##4.SDK接口调用说明

*   在lua代码中添加
    ```lua
        import sdkkit.lua
    ```
    
*   修改`sdkkit.lua`在各个函数函数体内实现游戏相关逻辑
*   在c++代码启动lua虚拟机后传入luastate
    ```c
        #include "sdkkit.h"

        initLuaFrame(L);
    ```

*   lua绑定接口
    *   登录
        ```lua
        function sdkkit_login()

        ```
        
    *   支付
        ```lua
        function sdkkit_pay(payAmount, payData)
        
        payAmount       :充值金额(必须传int类型)
        payData         :lua table
        ```
        
        *   payData结构如下
        
        ```lua
        productId       :物品id
        productName     :物品名称
        payProductNum   :购买数量
        payOrderId      :订单id
        payServerId     :服务器id
        payServerName   :服务器名称
        payGameLevel    :玩家等级
        payRoleId       :角色id
        payRoleLevel    :角色等级
        payRoleName     :角色名称
        payUserId       :用户id
        payUserName     :用户名称
        payBlance       :账户余额 
        extInfo         :透传参数
        ```
       
    *   用户中心
        ```lua
        function sdkkit_userCenter()
        ```
        
    *   注销
        ```lua
        function sdkkit_logout()
        ```
        
    *   获取订单结果
        ```lua
        function sdkkit_getOrderInfo(payOrderId)
        
        payOrderId      :订单id
        ```
        
    *   退出游戏
        ```lua
        function sdkkit_exitGame()
        ```
        
    *   登录统计
        ```lua
        function sdkkit_onLogin(userId, serverId)

        userId          :用户id
        serverId        :服务器id
        ```
        
    *   支付统计
        ```lua
        function sdkkit_onPay(amount, serverId, serverName, userId, roleId, orderNumber, roleGrade)

        amount          :充值金额
        serverId        :服务器id
        serverName      :服务器名称
        userId          :用户id
        roleId          :角色id
        orderNumber     :产品数量
        roleGrade       :角色等级
        ```
        
    *   玩家升级统计
        ```lua
        function sdkkit_onUpgrade(userId, serverId, roleGrade, roleId, roleName, roleServerName)

        userId          :用户id
        serverId        :服务器id
        roleGrade       :角色等级
        roleId          :角色id
        roleName        :角色名称
        roleServerName  :角色所在服务器名称
        ```
        
    *   上传区服和角色信息
        ```lua
        function sdkkit_onServerRoleInfo(roleId, roleName, roleLevel, serverId, serverName, rolePartyName, roleVipLevel)

        roleId          :角色id
        roleName        :角色名称
        roleLevel       :角色等级
        serverId        :服务器id
        serverName      :服务器名称
        rolePartyName   :角色工会名称
        roleVipLevel    :角色vip等级
        ```
        
    *   按钮点击统计
        ```lua
        function sdkkit_onButtonClick(userId, buttonName)

        userId          :用户id
        buttonName      :按钮名称
        ```
        
    *   创建角色统计
        ```lua
        function sdkkit_onCreateRole(userId, roleId,
            roleName, serverId, serverName)

        userId          :用户id
        roleId          :角色id
        roleName        :角色名称
        serverId        :服务器id
        serverName      :服务器名称
        ```
        
##5.技术支持
点击访问：好接入开发者社区
    
QQ：940111913
    
Email：<support@haojieru.com>
    
为了尽快响应您的反馈，请提供您的gamekey及log中的详细出错日志，您所提供的内容越详细越有助于我们帮您解决问题。