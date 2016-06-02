//
//  ViewController.h
//  WordSearch
//
//  Created by Brandon Manson on 6/2/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

// 5x5 square
// Array of words inside of square
// Return string from UISwipeGestureRecognizer - UPDATE: nah. way out of scope for the time we have right now.
// User input field for guessing words. Check input against words in array.
// Pick one of the words, remove it from _wordsInWordSearch. Create NSMUtableArray of count 10 - word length
//


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(strong, nonatomic)NSString *wordSearchString;
@property(strong, nonatomic)NSMutableArray *wordsInWordSearch;
@property(strong, nonatomic)NSMutableArray *wordsToCheckAgainst;

- (void)checkUserInput:(NSString *)userInput;
- (NSString *)pickWordAndRemoveFromArray;
- (void)addRandomLettersToArray:(NSMutableArray *)array;
- (void)shuffleCharArray:(NSMutableArray *)charArray;
- (void)addLettersAndShuffle:(NSMutableArray *)array;
- (NSString *)createLineInWordSearch;
- (NSString *)pickRandomLetter;
- (void)createWordsArray;
- (void)generateWordSearch;


@end

