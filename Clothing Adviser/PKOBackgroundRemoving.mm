//
//  PKOBackgroundRemoving.mm
//  backgroundRemoving
//
//  Created by Pavol Kominak on 15/01/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOBackgroundRemoving.h"

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "segment-image.h"
#import "pnmfile.h"


std::string convertMatToPBM(cv::InputArray jpgImage);
std::string pathToImage(NSString *imageName);
void clearBorderInGrayImage(cv::Mat &img);
cv::Mat moprphologyOpen(cv::InputArray input);
void segmentImage(std::string inputFile, std::string outputFile, float sigma, float k, int min_size, int &num_ccs);
cv::Mat removeBackgroundFromSegmentedImage(cv::InputArray originalImage, std::string segmentedFileName);
cv::Mat removeBackground(cv::InputArray originalImage, float sigma, float k, int min_size, int &num_ccs);


static NSString *const PKOTemporaryOriginalPbmImageName = @"temporary_pbm_image.pbm";
static NSString *const PKOTemporarySegmentedPbmImageName = @"temporary_segmented_image.pbm";
static int const PKOMedianBlurSize = 13;
static int const PKOMorphologyOpenSize = 10;


UIImage* removeBackgroundFromImage(UIImage *inputImage, float sigma, float k, int min_size, NSString *filename)
{
	cv::Mat originalMat;
	UIImageToMat(inputImage, originalMat);
	
	int num_ccs;
	cv::Mat finalMat = removeBackground(originalMat, sigma, k, min_size, num_ccs);

	UIImage *finalImage = MatToUIImage(finalMat);
	
//	cv::imwrite(pathToImage(filename), finalMat);
	
	// Saving final image
//	cv::Mat matToSave;
//	cv::cvtColor(originalMat, matToSave, cv::COLOR_BGR2RGB);
//	cv::imwrite(pathToImage(filename), matToSave);
//	cv::cvtColor(finalMat, matToSave, cv::COLOR_BGR2RGB);
//	cv::imwrite(pathToImage([NSString stringWithFormat:@"final_%@", filename]), matToSave);
	
	return finalImage;
}




cv::Mat removeBackground(cv::InputArray originalImage, float sigma, float k, int min_size, int &num_ccs)
{
	std::string inputFilename = convertMatToPBM(originalImage);
	std::string segmentedFilename = pathToImage(PKOTemporarySegmentedPbmImageName);
	segmentImage(inputFilename, segmentedFilename, sigma, k, min_size, num_ccs);
	
	cv::Mat finalImage = removeBackgroundFromSegmentedImage(originalImage, segmentedFilename);
	return finalImage;
}

cv::Mat removeBackgroundFromSegmentedImage(cv::InputArray originalImage, std::string segmentedFilename)
{
	cv::Mat segmentedImage = cv::imread(segmentedFilename);
//	cv::imwrite("/Users/palli/Downloads/1segmented.png", segmentedImage);
	
	cv::Mat grayImage;
	cv::cvtColor(segmentedImage, grayImage, cv::COLOR_BGR2GRAY);
//	cv::imwrite("/Users/palli/Downloads/2gray.png", grayImage);

	clearBorderInGrayImage(grayImage);
//	cv::imwrite("/Users/palli/Downloads/3borderCleared.png", grayImage);
	
	cv::Mat blurredImage;
	cv::medianBlur(grayImage, blurredImage, PKOMedianBlurSize);
//	cv::imwrite("/Users/palli/Downloads/4blurred.png", blurredImage);
	
	cv::Mat bwImage = blurredImage > 0;
//	cv::imwrite("/Users/palli/Downloads/5binary.png", bwImage);
	
	cv::Mat opened = moprphologyOpen(bwImage);
//	cv::imwrite("/Users/palli/Downloads/6opened.png", opened);
	
	cv::Mat finalImage;
	originalImage.copyTo(finalImage, opened);
	
//	cv::Mat finalConverted;
//	cv::cvtColor(finalImage, finalConverted, cv::COLOR_BGR2RGB);
//	cv::imwrite("/Users/palli/Downloads/7final.png", finalConverted);
	
	return finalImage;
}

void segmentImage(std::string inputFilename, std::string outputFilename, float sigma, float k, int min_size, int &num_ccs)
{
	image<rgb> *inputPbmImage = loadPPM(inputFilename.c_str());
	image<rgb> *segmented = segment_image(inputPbmImage, sigma, k, min_size, &num_ccs);
	
	savePPM(segmented, outputFilename.c_str());
}

std::string convertMatToPBM(cv::InputArray inputImage)
{
	std::string pbmImagePath = pathToImage(PKOTemporaryOriginalPbmImageName);
	
	cv::Mat convertedMat;
	cv::cvtColor(inputImage, convertedMat, cv::COLOR_BGR2RGB);
	
	cv::imwrite(pbmImagePath, convertedMat);
	
	return pbmImagePath;
}

cv::Mat moprphologyOpen(cv::InputArray input)
{
	int morph_size = PKOMorphologyOpenSize;
	cv::Mat element = cv::getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(2*morph_size + 1, 2*morph_size + 1));
	
	cv::Mat result;
	cv::morphologyEx(input, result, cv::MORPH_OPEN, element);
	
	return result;
}

void clearBorderInGrayImage(cv::Mat &img)
{
	uchar black(0);
	uchar *row;
	
	for (int y = 0; y < img.rows; y += img.rows - 1)
	{
		row = img.ptr<uchar>(y);
		for (int x = 0; x < img.cols; ++x)
		{
			if (row[x] != black) {
				cv::floodFill(img, cv::Point(x,y), black);
			}
		}
	}
	
	for (int y = 0; y < img.rows; ++y)
	{
		row = img.ptr<uchar>(y);
		for (int x = 0; x < img.cols; x += img.cols - 1)
		{
			if (row[x] != black) {
				cv::floodFill(img, cv::Point(x,y), black);
			}
		}
	}
}


// HELPERS

std::string pathToImage(NSString *imageName)
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *outputPath = [documentsDirectory stringByAppendingPathComponent:imageName];
	std::string outputImagePath = [outputPath cStringUsingEncoding:NSMacOSRomanStringEncoding];
	
	//	printf("%s \n", outputImagePath.c_str());
	
	return outputImagePath;
}

UIImage* resizeImageToNewSize(UIImage *originalImage, CGSize newSize)
{
	//UIGraphicsBeginImageContext(newSize);
	// In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
	// Pass 1.0 to force exact pixel size.
	UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
	[originalImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}