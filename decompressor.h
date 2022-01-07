#ifndef __DECOMPRESSOR_H__
#define __DECOMPRESSOR_H__

#include "fractal.h"

class RefDecompressor {

private:
    CompressedImage compIm;
    Image* image;

public:
    RefDecompressor(const std::string& compressedFilename);
    virtual ~RefDecompressor();
    void decompress();
    void step();
    Image* getImage();
};

#endif