import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class V2rayDisconnectReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        // В данном случае вызываем метод для разрыва соединения
        V2rayController.StopV2ray(context);
    }
}