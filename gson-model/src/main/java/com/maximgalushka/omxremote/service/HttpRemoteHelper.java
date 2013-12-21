package com.maximgalushka.omxremote.service;

import ch.boye.httpclientandroidlib.HttpEntity;
import ch.boye.httpclientandroidlib.HttpResponse;
import ch.boye.httpclientandroidlib.client.HttpClient;
import ch.boye.httpclientandroidlib.client.methods.HttpPost;
import ch.boye.httpclientandroidlib.entity.StringEntity;
import ch.boye.httpclientandroidlib.impl.client.DefaultHttpClient;
import ch.boye.httpclientandroidlib.params.CoreConnectionPNames;
import ch.boye.httpclientandroidlib.util.EntityUtils;
import com.google.gson.Gson;
import com.maximgalushka.omxremote.model.Command;

/**
 * @author Maxim Galushka
 */
public final class HttpRemoteHelper {

    //private DefaultHttpClient httpClient;
    private String ROOT = "http://192.168.1.103/omx/command.php";

    // TODO: implement timeout model
    private static final int TIMEOUT = 5000;

    private static HttpRemoteHelper instance = new HttpRemoteHelper();

    private HttpRemoteHelper(){}

    public static HttpRemoteHelper getInstance(){
        return instance;
    }

    /**
     * Sends simple post command to server and returns json result
     *
     * @param command wrapped command to execute
     * @return json result string
     */
    public String sendToServer(Command command) {
        HttpClient httpClient = new DefaultHttpClient();

        try {
            httpClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, TIMEOUT);
            httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, TIMEOUT);

            System.out.println("Execute command: " + command);

            Gson gson = new Gson(); // Or use new GsonBuilder().create();
            String request = gson.toJson(command);

            System.out.println("json request: " + request);

            HttpPost httpPost = new HttpPost(ROOT);
            httpPost.setEntity(new StringEntity(request));

            System.out.println("before execute");
            HttpResponse httpResponse = httpClient.execute(httpPost);
            System.out.println("after execute");
            HttpEntity entity = httpResponse.getEntity();
            System.out.println("after get entity");

            if (entity != null) {
                String response = EntityUtils.toString(entity);
                System.out.println("json response: " + response);
                EntityUtils.consumeQuietly(entity);
                return response;
            }
        } catch (Exception io) {
            io.printStackTrace();
        } finally {
            httpClient.getConnectionManager().shutdown();
        }
        return null;
    }
}
