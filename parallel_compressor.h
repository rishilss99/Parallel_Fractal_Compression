#ifndef __PARALLEL_COMPRESSOR_H__
#define __PARALLEL_COMPRESSOR_H__

#include "compressor.h"


class CudaCompressor : public Compressor {

private:
    Image* image;
    CompressedImage compIm;
    int* cudaImageData;
    CodebookElement* bestCodebook;

public:
    CudaCompressor(const std::string& imageFilename, int rangeSize, int domainSize);
    virtual ~CudaCompressor();
    void compress();
    void saveToFile(const std::string& filename);
    CompressedImage* getCompressedContents();
};


#endif