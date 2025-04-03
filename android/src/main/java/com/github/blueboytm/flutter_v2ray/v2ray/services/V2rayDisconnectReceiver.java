package com.github.blueboytm.flutter_v2ray.v2ray.services;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;

import com.github.blueboytm.flutter_v2ray.v2ray.V2rayController;

public class V2rayDisconnectReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        try {
            // В данном случае вызываем метод для разрыва соединения
            V2rayController.StopV2ray(context);

            // Получаем доступ к SharedPreferences
            SharedPreferences sharedPreferences = context.getApplicationContext()
                .getSharedPreferences("com.github.blueboytm.flutter_v2ray.preferences", Context.MODE_PRIVATE);
                
            SharedPreferences.Editor editor = sharedPreferences.edit();
            editor.remove("server_id");
            editor.remove("start_time");
            editor.apply();  // Применяем изменения

            Log.d("V2rayDisconnectReceiver", "server_id and start_time removed from SharedPreferences");
        } catch (Exception e) {
            Log.e("V2rayDisconnectReceiver", "onReceive failed", e);
        }
    }
}