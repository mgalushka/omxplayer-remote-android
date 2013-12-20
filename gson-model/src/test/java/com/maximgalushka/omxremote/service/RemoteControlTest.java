package com.maximgalushka.omxremote.service;

import com.maximgalushka.omxremote.model.Command;
import org.junit.Test;

/**
 * @author Maxim Galushka
 */
public class RemoteControlTest {
    @Test
    public void testSendToServer() throws Exception {
        RemoteControl rc = new RemoteControl();
        System.out.println(rc.sendToServer(new Command("browse", "C:/")));
        System.out.println(rc.sendToServer(new Command("browse", "C:/Users")));
        System.out.println(rc.sendToServer(new Command("browse", "C:/")));
    }
}
