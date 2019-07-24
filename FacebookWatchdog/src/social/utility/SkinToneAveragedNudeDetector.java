package social.utility;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.io.IOException;
import java.io.File;

/**
 *  This class is used to get color of image pixels and to check if image contains more nudity than threshold  
 *  @author Sujit Thorat
 */
/**public class SkinToneAveragedNudeDetector extends SkinToneNudeDetector {

    @Override
    public boolean isNude(File file) throws IOException {
        final BufferedImage bufferedImage = ImageIO.read(file);
        final Raster raster = bufferedImage.getData();

        final int[] rgb = new int[4];
        final int totalPixels = raster.getHeight() * raster.getWidth();
        int skinTonePixels = 0;
        for (int y = 0; y < raster.getHeight(); y++) {
            for (int x = 0; x < raster.getWidth(); x++) {
                raster.getPixel(x, y, rgb);

                for (int[] skinTone : SKIN_TONES) {
                    int xs = Math.abs(skinTone[0] - rgb[0]);
                    xs *= xs;
                    int ys = Math.abs(skinTone[1] - rgb[1]);
                    ys *= ys;
                    int zs = Math.abs(skinTone[2] - rgb[2]);
                    zs *= zs;

                    boolean matchesSkinTone = Math.sqrt(xs + ys + zs) <= skinToneDelta;
                    if (matchesSkinTone) {
                        skinTonePixels++;
                        break;
                    }
                }
            }
        }
        final double threshold = skinTonePixels / (double) totalPixels * 100.0;
        return threshold > isPornDelta;
    }

}*/
