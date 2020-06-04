package com.example.voiceover_notification_plugin;


import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.content.Intent;

import androidx.core.content.ContextCompat;

/** VoiceoverNotificationPlugin */
public class VoiceoverNotificationPlugin implements MethodCallHandler {
  private static Registrar registrar;
  private static MethodChannel channel;

  private VoiceoverNotificationPlugin(Registrar r) {
    registrar = r;
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    VoiceoverNotificationPlugin.channel = new MethodChannel(registrar.messenger(), "flutter_media_notification");
    VoiceoverNotificationPlugin.channel.setMethodCallHandler(new VoiceoverNotificationPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case "showNotification":
        final String title = call.argument("title");
        final String author = call.argument("author");
        final boolean isPlaying = call.argument("isPlaying");
        final String coverArt = call.argument("coverArt");
        showNotification(title, author, coverArt, isPlaying);
        result.success(null);
        break;
      case "hideNotification":
        hideNotification();
        result.success(null);
        break;
      default:
        result.notImplemented();
    }
  }

  static void callEvent(String event) {

    VoiceoverNotificationPlugin.channel.invokeMethod(event, null, new Result() {
      @Override
      public void success(Object o) {
        // this will be called with o = "some string"
      }

      @Override
      public void error(String s, String s1, Object o) {}

      @Override
      public void notImplemented() {}
    });
  }

  static void showNotification(String title, String author, String coverArt, boolean play) {

    Intent serviceIntent = new Intent(registrar.context(), NotificationPanel.class);
    serviceIntent.putExtra("title", title);
    serviceIntent.putExtra("author", author);
    serviceIntent.putExtra("coverArt", coverArt);
    serviceIntent.putExtra("isPlaying", play);

    registrar.context().startService(serviceIntent);
  }

  private void hideNotification() {
    Intent serviceIntent = new Intent(registrar.context(), NotificationPanel.class);
    registrar.context().stopService(serviceIntent);
  }
}