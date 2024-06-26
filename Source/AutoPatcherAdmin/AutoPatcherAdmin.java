import java.io.*;
import java.util.*;
import java.util.zip.*;
import java.text.SimpleDateFormat;
import java.nio.*;
import javax.swing.*;
public class AutoPatcherAdmin
{
    public static long fileCheck(String f)
        throws FileNotFoundException, IOException
    {
        return fileCheck(new File(f));
    }
    public static long fileCheck(File f)
        throws FileNotFoundException, IOException
    {
        FileInputStream fis = new FileInputStream(f);
        BufferedInputStream bis = new BufferedInputStream(fis, 8192);
        CheckedInputStream cis = new CheckedInputStream(bis, new Adler32());
        if (f.length() > 1048576) {
            cis.skip(524288);
            fis.skip(f.length() - 1048576);
            cis.skip(524288);
        } else {
            cis.skip(f.length());
        }
        cis.close();
        return cis.getChecksum().getValue();
    }
    public static String fullDirectoryScan(String dir, String subdir) {
        StringBuffer sb = new StringBuffer();
        File f;
        if (subdir == null) { 
            f = new File(dir);
            subdir = "";
        } else {
            f = new File(dir, subdir);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        File[] files = f.listFiles();
        for (int i = 0; i < files.length; i++) {
            if (!files[i].isDirectory()) {
                if (files[i].toString().endsWith("!klist.list")) continue;
                if (files[i].toString().endsWith(".gz")) continue;
                try {
                    byte[] buf = new byte[8192];
                    int len;
                    BufferedInputStream bis = new BufferedInputStream(new FileInputStream(files[i].getPath()));
                    FileOutputStream fos = new FileOutputStream(files[i].getPath() + ".gz");
//                    fos.write(bigToLittle(files[i].length()));
                    GZIPOutputStream gos = new GZIPOutputStream(fos);
                    while ((len = bis.read(buf, 0, 8192)) != -1) {
                        gos.write(buf, 0, len);
                    }
                    bis.close();
                    gos.close();
                    // Z 2002-09-07  07:51                32:54  Data/Snow/SmTiles.WIX     Data/Snow/SmTiles.WIX.kgz   48516483
                    System.out.println(subdir + files[i].getName());
                    sb.append("Z\t" + sdf.format(new Date(files[i].lastModified())) + "\t" + files[i].length() + ":" + (new File(files[i].getPath() + ".gz").length()) + "\t" + subdir.replace("/", "\\") + files[i].getName()  + "\t" + "/" + subdir.replace("\\", "/") + files[i].getName() + ".gz\t" + fileCheck(files[i]) + "\r\n");
                    } catch (FileNotFoundException e) {} catch (IOException e) {}
            }
        }
        for (int i = 0; i < files.length; i++) {
            if (files[i].isDirectory()) {
                sb.append(fullDirectoryScan(dir, subdir + files[i].getName()  + "/"));
            }
        }
        
        return sb.toString();
    }
    public static void fullDirectoryCRCGenerator(String dirWithoutSlash) {
        DataOutputStream dos;
        try {
            dos = new DataOutputStream(new FileOutputStream(dirWithoutSlash + "/!klist.lst"));
        } catch (FileNotFoundException e) {return;}
        String s = fullDirectoryScan(dirWithoutSlash, "");
        try {
            dos.writeBytes(s);
            dos.close();
        } catch (IOException e) {}
        try {
            BufferedInputStream bis = new BufferedInputStream(new FileInputStream(dirWithoutSlash + "/!klist.lst"));
            FileOutputStream fos = new FileOutputStream(dirWithoutSlash + "/!klist.gz");
            GZIPOutputStream gos = new GZIPOutputStream(fos);
            byte[] buf = new byte[8192];
            int len;
            while ((len = bis.read(buf, 0, 8192)) != -1) {
                gos.write(buf, 0, len);
            }
            bis.close();
            gos.close();
        } catch (IOException e) {}
    }
    public final static byte[] bigToLittle(long x) {
        return ByteBuffer.allocate(8).order(ByteOrder.LITTLE_ENDIAN).putLong(x).array();
    }
    public static void main(String[] args) {
        String input = JOptionPane.showInputDialog(null, "Please enter your patch directory\nExample: C:\\AceM2\\KaoriPatchFiles", "AceM2 AutoPatcherAdmin", JOptionPane.QUESTION_MESSAGE);
        if (input == null) { displayError("Program will exit since you clicked cancel"); }
        if (input.length() == 0) { displayError("Program will exit since you didn't type anything"); }
        File dirpath = null;
        try {
            dirpath = new File(input).getCanonicalFile();
        } catch (IOException ioe) {
            displayError("Invalid character caused IO Error when compiling your path");
        }
        if (!dirpath.exists()) {
            displayError("Path does not exist");
        }
        if (!dirpath.isDirectory()) {
            displayError("Path is not a directory");
        }
        fullDirectoryCRCGenerator(dirpath.toString());
        JOptionPane.showMessageDialog(null, "Done\n Upload !klist.txt and other gziped files to your FTP Server", "AutoPatcherAdmin", JOptionPane.INFORMATION_MESSAGE);
        System.exit(0);
    }
    
    public static void displayError(String str) {
        JOptionPane.showMessageDialog(null, str, "AutoPatcherAdmin", JOptionPane.ERROR_MESSAGE);
        System.exit(0);
    }
}