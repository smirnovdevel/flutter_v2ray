import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.github.blueboytm.flutter_v2ray.v2ray.V2rayController;

public class V2rayDisconnectReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        try {
            // В данном случае вызываем метод для разрыва соединения
            V2rayController.StopV2ray(context);
        } catch (Exception e) {
            Log.e("V2rayDisconnectReceiver", "onReceive failed", e);
        }
    }
}