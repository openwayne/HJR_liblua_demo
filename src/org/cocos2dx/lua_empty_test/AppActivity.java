package org.cocos2dx.lua_empty_test;

import org.cocos2dx.lib.Cocos2dxActivity;

import android.os.Bundle;

import com.gameworks.sdkkit.sdknative.GWPlateformBusinessImplWrapper;
import com.gameworks.sdkkit.sdknative.GWPlatformCollectionsImplWrapper;
import com.gameworks.sdkkit.sdknative.GWPlatformJniHelper;
import com.gameworks.sdkkit.sdknative.GWSDKKitPlateformCallBackImplWrapper;
import com.hjr.sdkkit.core.HJRSDKKitPlateformCore;
import com.hjr.sdkkit.entity.ParamsContainer;

public class AppActivity extends Cocos2dxActivity {
    private HJRSDKKitPlateformCore plateformSDK;

	@Override
    protected void onCreate(final Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		plateformSDK = HJRSDKKitPlateformCore.initGWPlateform(new GWSDKKitPlateformCallBackImplWrapper());
		GWPlateformBusinessImplWrapper.setContext(this, plateformSDK);
		GWPlatformCollectionsImplWrapper.setPlateform(plateformSDK, this);
		ParamsContainer localParamsContainer = new ParamsContainer();
		plateformSDK.Business.init(this, localParamsContainer);
		GWPlatformJniHelper.nativeSetContext(this);
    }
}
