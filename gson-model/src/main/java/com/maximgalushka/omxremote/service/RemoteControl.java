package com.maximgalushka.omxremote.service;

import android.os.AsyncTask;
import com.maximgalushka.omxremote.model.Command;

/**
 * @author Maxim Galushka
 */
public class RemoteControl extends AsyncTask<Command, Void, String> {

    @Override
    protected String doInBackground(Command... commands) {
        HttpRemoteHelper helper = HttpRemoteHelper.getInstance();
        return helper.sendToServer(commands[0]);
    }
}
