package com.maximgalushka.omxremote.service;

import android.os.AsyncTask;
import com.maximgalushka.omxremote.model.Command;
import com.maximgalushka.omxremote.model.FileSystem;
import org.junit.Test;

/**
 * @author Maxim Galushka
 */
public class RemoteControlTest {

    @SuppressWarnings("unchecked")
    @Test
    public void testSendToServer() throws Exception {
        /*RemoteControl rc = new RemoteControl();
        AsyncTask<Command, Void, String> r =
                rc.execute(new Command("browse", ""));

        rc.cancel(false);

        String result = r.get();

        FsBrowserControl fsb = new FsBrowserControl();
        AsyncTask<Command, Void, FileSystem> fsba =
                fsb.execute(new Command("browse", ""));

        FileSystem fsbra = fsba.get();*/
//        System.out.println(rc.execute("browse", "C:/"));
//        System.out.println(rc.sendToServer(new Command("browse", "C:/Users")));
//        System.out.println(rc.sendToServer(new Command("browse", "C:/")));
    }
}
