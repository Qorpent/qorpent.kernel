using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

namespace qorpent.embed {
    /// <summary>
    /// </summary>
    public static class ImageUtils {
        public enum ImageType {
            GrayScale = 1,
            BGR = 2,
            RGB = 4,
            BGRA = 8,
            RGBA = 16
        }

        private static int GetChannelCount(ImageType format) {
            if (format == ImageType.GrayScale) {
                return 1;
            }
            if (format == ImageType.BGR || format == ImageType.RGB) {
                return 3;
            }
            return 4;
        }
        /// <summary>
        /// Converts byte buffer to Image with given bitmap type
        /// </summary>
        /// <param name="data"></param>
        /// <param name="w"></param>
        /// <param name="h"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public static Image ConvertBytesToImage(byte[] data, int w, int h, ImageType type = ImageType.RGB) {
            var bitmap = new Bitmap(w,h);
            var channels = GetChannelCount(type);
            var bluefirst = type == ImageType.BGR || type == ImageType.BGRA;
            var size = w * h * channels;
            if (data.Length < size) {
                throw new Exception("invalid buffer size");
            }
            var i = -1;
            for (var r = 0; r < h; r++) {
                for (var c = 0; c < w; c++) {
                    if (channels == 1) {
                        int gray = data[++i];
                        bitmap.SetPixel(c, r, Color.FromArgb(gray, gray, gray));
                    }
                    else {
                        var buf = new[] {data[++i], data[++i], data[++i], channels == 4 ? data[++i] : (byte)0};
                        var basecolor = Color.FromArgb(bluefirst?buf[2]:buf[0],buf[1],bluefirst?buf[0]:buf[2]);
                        if (channels == 4) {
                            bitmap.SetPixel(c, r, Color.FromArgb(buf[3], basecolor));
                        }
                        else {
                            bitmap.SetPixel(c,r,basecolor);
                        }
                    }
                }
            }
            return bitmap;
        }


        /// <summary>
        /// Converts given image to plain byte (uchar*) array 
        /// </summary>
        /// <param name="image">source image</param>
        /// <param name="type">type of image byte encoding (according to OpenCV)</param>
        /// <returns></returns>
        public static byte[] ConvertImageToBytes(Image image, ImageType type = ImageType.RGB) {
            var channels = GetChannelCount(type);
            var bluefirst = type == ImageType.BGR || type == ImageType.BGRA;
            var size = image.Width*image.Height*channels;
            var result = new byte[size];
            var bitmap = new Bitmap(image);
            var i = -1;
            for (var r = 0; r < image.Height; r++) {
                for (var c = 0; c < image.Width; c++) {
                    var pixel = bitmap.GetPixel(c, r);
                    if (channels == 1 && ((pixel.R != pixel.G) || (pixel.R != pixel.B))) {
                        pixel = GetGrayscale(pixel);
                    }
                    if (channels == 1) {
                        result[++i] = pixel.R;
                    }
                    else {
                        if (bluefirst) {
                            result[++i] = pixel.B;
                        }
                        else {
                            result[++i] = pixel.R;
                        }
                        result[++i] = pixel.G;
                        if (bluefirst) {
                            result[++i] = pixel.R;
                        }
                        else {
                            result[++i] = pixel.B;
                        }
                        if (channels == 4) {
                            result[++i] = pixel.A;
                        }
                    }
                }
            }

            return result;
        }

        private static Color GetGrayscale(Color pixel) {
            var grayScale = (int) ((pixel.R*0.3) + (pixel.G*0.59) + (pixel.B*0.11));
            return Color.FromArgb(grayScale, 0, 0);
        }

        public static void ConvertImage(string source, string target, int canvasWidth = -1, int canvasHeight = -1) {
            var image = Image.FromFile(source);
            if (canvasHeight == -1 && canvasHeight == -1) {
                image.Save(target, ImageFormat.Png);
                return;
            }
            if (canvasWidth == -1) {
                canvasWidth = image.Width;
            }
            if (canvasHeight == -1) {
                canvasHeight = image.Height;
            }

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


            thumbnail.Save(target, ImageFormat.Png);
            image.Dispose();
            thumbnail.Dispose();
        }
    }
}