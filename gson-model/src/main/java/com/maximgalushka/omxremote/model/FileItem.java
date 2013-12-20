package com.maximgalushka.omxremote.model;

/**
 * @author Maxim Galushka
 */
public class FileItem {
    private String path;
    private String name;
    private String type;

    public FileItem(String _path, String _name, String _type) {
        this.path = _path;
        this.name = _name;
        this.type = _type;
    }

    public String getPath() {
        return this.path;
    }

    public String getName() {
        return this.name;
    }

    public String getType() {
        return this.type;
    }

    public String toString() {
        return "{path = [" + path + "], name = [" + name + "], type = [" + type + "]}";
    }
}