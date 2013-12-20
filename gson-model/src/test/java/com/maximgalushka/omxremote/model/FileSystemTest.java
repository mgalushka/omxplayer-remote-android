package com.maximgalushka.omxremote.model;

import com.google.gson.Gson;
import org.junit.Assert;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Maxim Galushka
 */
public class FileSystemTest {

    @Before
    public void setUp() throws Exception {

    }

    @After
    public void tearDown() throws Exception {

    }

    @Test
    public void fromJsonTest(){
        String json = "{ \"path\": \"C:\\\\Users\\\\Default\", \"content\": [ { \"path\": \"C:\\\\Users\\\\Default\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\AppData\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Desktop\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Documents\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Downloads\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Favorites\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Links\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Music\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\NTUSER.DAT\", \"name\": \"\", \"type\": \"FILE\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\NTUSER.DAT.LOG1\", \"name\": \"\", \"type\": \"FILE\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\NTUSER.DAT.LOG2\", \"name\": \"\", \"type\": \"FILE\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\NTUSER.DAT{97e1de87-d6fa-11e1-be62-94c0340a1222}.TM.blf\", \"name\": \"\", \"type\": \"FILE\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\NTUSER.DAT{97e1de87-d6fa-11e1-be62-94c0340a1222}.TMContainer00000000000000000001.regtrans-ms\", \"name\": \"\", \"type\": \"FILE\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\NTUSER.DAT{97e1de87-d6fa-11e1-be62-94c0340a1222}.TMContainer00000000000000000002.regtrans-ms\", \"name\": \"\", \"type\": \"FILE\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Pictures\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Roaming\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Saved Games\", \"name\": \"\", \"type\": \"DIR\" }, { \"path\": \"C:\\\\Users\\\\Default\\\\Videos\", \"name\": \"\", \"type\": \"DIR\" } ]}";

        Gson gson = new Gson();

        FileSystem fs = gson.fromJson(json, FileSystem.class);

        Assert.assertNotNull(fs);

        System.out.println(fs);
    }

    @Test
    public void toJsonTest(){
        FileSystem result = new FileSystem("/media");

        FileItem dir = new FileItem("/media/films", "files", "DIR");
        FileItem file = new FileItem("/media/films/1.avi", "1.avi", "FILE");

        List<FileItem> items = new ArrayList<FileItem>();
        items.add(dir);
        items.add(file);

        result.setContent(items);

        Gson gson = new Gson();
        String json = gson.toJson(result);

        System.out.println(json);
    }
}
