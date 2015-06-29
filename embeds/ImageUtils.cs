using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

namespace qorpent.embed {
    /// <summary>
    /// 
    /// </summary>
    public static class ImageUtils {
        public static void ConvertImage(string source, string target, int canvasWidth=-1, int canvasHeight=-1) {
            var image = Image.FromFile(source);
            if (canvasHeight == -1 && canvasHeight == -1) {
                image.Save(target,ImageFormat.Png);
                return;
            }
            if (canvasWidth == -1) canvasWidth = image.Width;
            if (canvasHeight == -1) canvasHeight = image.Height;

            Image thumbnail =
                new Bitmap(canvasWidth, canvasHeight); // changed parm names
            var graphic =
                Graphics.FromImage(thumbnail);

            graphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphic.SmoothingMode = SmoothingMode.HighQuality;
            graphic.PixelOffsetMode = PixelOffsetMode.HighQuality;
            graphic.CompositingQuality = CompositingQuality.HighQuality;


            /* ------------------ new code --------------- */

            // Figure out the ratio
            var ratioX = canvasWidth/(double) image.Width;
            var ratioY = canvasHeight/(double) image.Height;
            // use whichever multiplier is smaller
            var ratio = ratioX < ratioY ? ratioX : ratioY;

            // now we can get the new height and width
            var newHeight = Convert.ToInt32(image.Height*ratio);
            var newWidth = Convert.ToInt32(image.Width*ratio);

            // Now calculate the X,Y position of the upper-left corner 
            // (one of these will always be zero)
            var posX = Convert.ToInt32((canvasWidth - (image.Width*ratio))/2);
            var posY = Convert.ToInt32((canvasHeight - (image.Height*ratio))/2);

            graphic.Clear(Color.White); // white padding
            graphic.DrawImage(image, posX, posY, newWidth, newHeight);

            /* ------------- end new code ---------------- */

            var info = ImageCodecInfo.GetImageEncoders();
            EncoderParameters encoderParameters;
            encoderParameters = new EncoderParameters(1);
            encoderParameters.Param[0] = new EncoderParameter(Encoder.Quality,
                100L);
            thumbnail.Save(target, ImageFormat.Png);
            image.Dispose();
            thumbnail.Dispose();
        }
    }
}