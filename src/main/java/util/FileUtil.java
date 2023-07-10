package util;

import java.io.File;
import java.io.FileOutputStream;

public class FileUtil {
    public static String uploadFile(byte[] file, String filePath, String fileName) throws Exception {
        File targetFile = new File(filePath);
        if(!targetFile.exists()){
            targetFile.mkdirs();
        }
        String path =filePath+fileName;
        FileOutputStream out = new FileOutputStream(path);
        out.write(file);
        out.flush();
        out.close();
        return "/fileImages/"+fileName;
    }
}
