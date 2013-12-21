package com.maximgalushka.omxremote.service;

import android.os.AsyncTask;
import com.google.gson.Gson;
import com.maximgalushka.omxremote.model.Command;
import com.maximgalushka.omxremote.model.FileSystem;

/**
 * @author Maxim Galushka
 */
public class FsBrowserControl extends AsyncTask<Command, Void, FileSystem> {

    @Override
    protected FileSystem doInBackground(Command... command) {
        HttpRemoteHelper helper = HttpRemoteHelper.getInstance();
        String json = helper.sendToServer(command[0]);

        Gson gson = new Gson();
        FileSystem fs = gson.fromJson(json, FileSystem.class);

        System.out.println(fs);
        return fs;
    }
}
