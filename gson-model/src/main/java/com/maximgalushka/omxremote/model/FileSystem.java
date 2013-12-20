package com.maximgalushka.omxremote.model;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Maxim Galushka
 */
public class FileSystem {

    // root path for current snapshot
    private String path;

    // List<FileItem>
    private List<FileItem> content;

    public FileSystem(String _path) {
        this.path = _path;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public List getContent() {
        return content;
    }

    public void setContent(List content) {
        this.content = content;
    }

    public ArrayList ketaiList() {
        ArrayList<String> result = new ArrayList<String>();
        for (FileItem item : content) {
            if ("DIR".equals(item.getType())) {
                result.add(item.getPath());
            }
            if ("FILE".equals(item.getType())) {
                result.add(item.getName());
            }
        }
        return result;
    }

    public FileItem find(String path) {
        for (FileItem item : content) {
            if (item.getPath().equals(path)) {
                return item;
            }
            if (item.getName().equals(path)) {
                return item;
            }
        }
        return null;
    }

    public String toString() {
        return "path = [" + path + "], content = [" + content + "]";
    }
}
