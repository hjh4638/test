package mil.af.asti.test.hjh;

import java.awt.image.AreaAveragingScaleFilter;
import java.awt.image.FilteredImageSource;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.junit.Test;

import util.ImageUtils;

public class ThumbNail {
	private ImageUtils imgUtil= new ImageUtils();
	
	@Test
	public void test(){
		File origin_img = new File("C:","1.bmp");
		
		FileInputStream in;
		try {
			in = new FileInputStream(origin_img);
			BufferedInputStream b_in = new BufferedInputStream(in);
			imgUtil.createThumbnail(b_in, "test", "bmp", 100, 100);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
