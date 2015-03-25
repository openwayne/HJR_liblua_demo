package org.cocos2dx.lua_empty_test;

import org.cocos2dx.lib.Cocos2dxActivity;

import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;

import com.hjr.sdkkit.sdknative.SDKKitPlateformBusinessImplWrapper;
import com.hjr.sdkkit.sdknative.SDKKitPlateformCallBackImplWrapper;
import com.hjr.sdkkit.sdknative.SDKKitPlatformCollectionsImplWrapper;
import com.hjr.sdkkit.sdknative.SDKKitPlatformJniHelper;
import com.hjr.sdkkt.framework.mw.openapi.HJRSDKKitPlateformCore;

public class AppActivity extends Cocos2dxActivity {
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

}
