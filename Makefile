EXECUTABLE := fractal_compression

CU_FILES   := parallel_compressor.cu

CU_DEPS    :=

CC_FILES   := main.cpp display.cpp decompressor.cpp compressor.cpp fractal.cpp

LOGS	   := logs

###########################################################

ARCH=$(shell uname | sed -e 's/-.*//g')
OBJDIR=objs
CXX=g++ -m64
CXXFLAGS=-O3 -Wall -g
HOSTNAME=$(shell hostname)

LIBS       :=
FRAMEWORKS := 

ifeq ($(HOSTNAME), latedays.andrew.cmu.edu)
# Building on Latedays
NVCCFLAGS=-O3 -m64 -arch compute_20
LIBS += GL glut cudart
LDFLAGS=-L/usr/local/cuda/lib64/ -lcudart
else
# Building on Linux
NVCCFLAGS=-O3 -m64 -arch compute_20
LIBS += GL glut
#cudart
LDFLAGS=-L/usr/local/depot/cuda-6.5/lib64/ -lcudart
endif

LDLIBS  := $(addprefix -l, $(LIBS))
LDFRAMEWORKS := $(addprefix -framework , $(FRAMEWORKS))

NVCC=nvcc

OBJS=$(OBJDIR)/main.o $(OBJDIR)/display.o $(OBJDIR)/benchmark.o $(OBJDIR)/refCompressor.o \
     $(OBJDIR)/ppm.o $(OBJDIR)/refDecompressor.o $(OBJDIR)/compressedFile.o \
     $(OBJDIR)/fractal.o $(OBJDIR)/cudaCompressor.o


.PHONY: dirs clean

default: $(EXECUTABLE)

dirs:
		mkdir -p $(OBJDIR)/

clean:
		rm -rf $(OBJDIR) *~ $(EXECUTABLE) $(LOGS)

check:	default
		./checker.pl

$(EXECUTABLE): dirs $(OBJS)
		$(CXX) $(CXXFLAGS) -o $@ $(OBJS) $(LDFLAGS) $(LDLIBS) $(LDFRAMEWORKS)

$(OBJDIR)/%.o: %.cpp
		$(CXX) $< $(CXXFLAGS) -c -o $@

$(OBJDIR)/%.o: %.cu
		$(NVCC) $< $(NVCCFLAGS) -c -o $@