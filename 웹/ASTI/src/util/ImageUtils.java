package util;

import java.io.*;

import java.awt.Image;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

public class ImageUtils {

  public static void createThumbnail(String load,String save,String type,int w,int h) {

    try {
      BufferedInputStream stream_file = new BufferedInputStream(new FileInputStream(load));
      createThumbnail(stream_file,save,type,w,h);
    } catch (Exception e) {

    }

  }

  public static void createThumbnail(BufferedInputStream stream_file,String save,String type,int w,int h) {
    try {

      getImageThumbnail(stream_file,save,type,w,h);

    } catch (Exception e) {

    }

  }

  public static void getImageThumbnail(BufferedInputStream stream_file,String save,String type,int w,int h) {

    try {
      File  file = new File("C:",save);
      BufferedImage bi = ImageIO.read(stream_file);

      int width = bi.getWidth();
      int height = bi.getHeight();
      if (w < width) { width = w; }
      if (h < height) { height = h; }

      BufferedImage bufferIm = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
      
      Image atemp = bi.getScaledInstance(width, height, Image.SCALE_AREA_AVERAGING);

      Graphics2D  g2 = bufferIm.createGraphics();
      g2.drawImage(atemp, 0, 0, width, height, null);
      ImageIO.write(bufferIm, type, file);
    } catch (Exception e) {

    }

  }
}