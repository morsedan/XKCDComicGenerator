//
//  ViewController.m
//  XKCDComics
//
//  Created by morse on 1/30/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "ViewController.h"
#import "Comic.h"
#import "LSILog.h"
#import "LSIErrors.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property int maxComicNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maxComicNumber = 0;
    [self fetchLastComic];
    
    
    
    
    
}

- (void)fetchLastComic {
    NSURL *url = [NSURL URLWithString:@"https://xkcd.com/info.0.json"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (error) {
            NSLog(@"Error: %@", error);
            // TODO: Completion
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"Data is missing", LSIDataNilError);
            NSLog(@"Error: %@", dataError);
            // TODO: Completion
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        Comic *comic = [[Comic alloc] initWithDictionary:json];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.maxComicNumber = comic.num;
            NSLog(@"%i", comic.num);
        });
        
    }] resume];
}

- (void)fetchComic {
    NSURL *baseURL = [NSURL URLWithString:@"https://xkcd.com"];
    //    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES]
    int randomNumber = arc4random_uniform(self.maxComicNumber);
    int comicNumber = randomNumber;
    NSString *comicNumberString = [NSString stringWithFormat:@"%i", comicNumber];
    NSURL *url = [[baseURL URLByAppendingPathComponent:comicNumberString] URLByAppendingPathComponent:@"info.0.json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (error) {
            NSLog(@"Error: %@", error);
            // TODO: Completion
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"Data is missing", LSIDataNilError);
            NSLog(@"Error: %@", dataError);
            // TODO: Completion
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        Comic *comic = [[Comic alloc] initWithDictionary:json];
        
        // TODO: Completion
        
        
        
        NSLog(@"imageURL: %@", comic.imageURL);
        
        [self downloadImage:comic.imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.text = comic.title;
        });
        
    }] resume];
}

- (void)downloadImage:(NSURL *)url {
    
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    UIImage *image = [UIImage imageWithData:data];
    //    NSLog(@"Image: %@", image);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            // TODO: Completion
        }
        
        //        if (response) {
        //            NSLog(@"Response: %@", response);
        //        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"Data is missing", LSIDataNilError);
            NSLog(@"Error: %@", dataError);
            // TODO: Completion
        }
        
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"Image: %@", image);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            
        });
    }] resume];
}

- (IBAction)tapped:(id)sender {
    self.titleLabel.text = @"Fetching Comic";
    self.imageView.image = nil;
    [self fetchComic];
}



@end
