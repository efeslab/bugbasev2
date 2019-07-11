# [bug 76041](https://bugs.php.net/bug.php?id=76041)
- behavior: segmentation fault
- description: draw anti-alised line on a palette image resource
- sketch: 
    
    - `php_gd_gdImageCreate` at ext/gd/libgd/gd.c:213

        `im->tpixels = 0;`

        line 2 `$im=imagecreate(100,100);` in `poc.php` is to create a new palette based image that doesn't support truecolor.

    - `php_gd_gdImageSetAntiAliased` at ext/gd/libgd/gd.c:2826

        `im->AA = 1;`

        line 3 `imageantialias($im,true);` activate the fast drawing antialiased methods for lines and wired polygons, which is a feature that works only with truecolor images.

    - `zif_imageline` at ext/gd/gd.c:3191

        ```C
        if (im->AA) {
            gdImageSetAntiAliased(im, col);
            col = gdAntiAliased;
        }
        gdImageLine(im, x1, y1, x2, y2, col);
        ```

        - `php_gd_gdImageLine` at ext/gd/libgd/gd.c:1053

            ```C
            if (color == gdAntiAliased) {
                /*
                    gdAntiAliased passed as color: use the much faster, much cheaper
                    and equally attractive gdImageAALine implementation. That
                    clips too, so don't clip twice.
                    */
                gdImageAALine(im, x1, y1, x2, y2, im->AA_color);
                return;
            }
            ```

            - `php_gd_gdImageAALine` at ext/gd/libgd/gd.c:1270

                `gdImageSetAAPixelColor(im, x, y + 1, col, (~frac >> 8) & 0xFF);`

                Set truecolor for antialised line pixel by pixel.

                - `gdImageSetAAPixelColor` at ext/gd/libgd/gd.c:1230

                    `im->tpixels[y][x]=gdTrueColorAlpha(dr, dg, db,  gdAlphaOpaque);`

                    However, `$im` is a palette based image, which means it doesn't have truecolor pixels. Recal `im->tpixels = 0`, segmentation fault.

- patch: [check if the image is of true color before draw anti-alised lines](http://git.php.net/?p=php-src.git;a=commit;h=d83467d70b9986ed3084c62fbbd07a0d8955951f)
