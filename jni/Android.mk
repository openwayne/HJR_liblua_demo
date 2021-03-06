LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := lua_empty_test_shared

LOCAL_MODULE_FILENAME := liblua_empty_test

LOCAL_SRC_FILES := main.cpp \
                   ../../Classes/AppDelegate.cpp

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../Classes \
					$(LOCAL_PATH)/../../lua_sdkkit \
                    $(LOCAL_PATH)/../../../../../external/lua/tolua \

LOCAL_STATIC_LIBRARIES := lua_sdkkit
LOCAL_STATIC_LIBRARIES += cocos2d_lua_static

include $(BUILD_SHARED_LIBRARY)

$(call import-module, lua_sdkkit)
$(call import-module, scripting/lua-bindings/proj.android)
