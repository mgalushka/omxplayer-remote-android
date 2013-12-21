package com.maximgalushka.omxremote.model;

/**
 * @author Maxim Galushka
 */
public class Command {

    private String request;
    private String path;

    public Command() {
    }

    public Command(String ... params) {
        this();
        if(params.length >= 1) {
            this.request = params[0];
        }
        if(params.length >= 2) {
            this.path = params[1];
        }
    }

    public Command(String _request) {
        this.request = _request;
    }

    public Command(String _request, String _path) {
        this.request = _request;
        this.path = _path;
    }

    public String getRequest() {
        return this.request;
    }

    public String getPath() {
        return this.path;
    }

    public String toString() {
        return "{request = " + this.request + ", path = " + this.path + "}";
    }

}
