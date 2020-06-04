package com.example.voiceover_notification_plugin;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;

public class NotificationReturnSlot extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        switch (intent.getAction()) {
            case "prev":
            VoiceoverNotificationPlugin.callEvent("prev");
                break;
            case "next":
            VoiceoverNotificationPlugin.callEvent("next");
                break;
            case "toggle":
                String title = intent.getStringExtra("title");
                String author = intent.getStringExtra("author");
                String coverArt = intent.getStringExtra("coverArt");
                boolean play = intent.getBooleanExtra("play",true);

                if(play)
                VoiceoverNotificationPlugin.callEvent("play");
                else
                VoiceoverNotificationPlugin.callEvent("pause");

                VoiceoverNotificationPlugin.showNotification(title, author,coverArt, play);
                break;
            case "select":
                Intent closeDialog = new Intent(Intent.ACTION_CLOSE_SYSTEM_DIALOGS);
                context.sendBroadcast(closeDialog);
                String packageName = context.getPackageName();
                PackageManager pm = context.getPackageManager();
                Intent launchIntent = pm.getLaunchIntentForPackage(packageName);
                context.startActivity(launchIntent);

                VoiceoverNotificationPlugin.callEvent("select");
        }
    }
}

