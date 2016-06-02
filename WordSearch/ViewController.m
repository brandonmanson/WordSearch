//
//  ViewController.m
//  WordSearch
//
//  Created by Brandon Manson on 6/2/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *wordSearch;
@property (strong, nonatomic) IBOutlet UILabel *notificationLabel;
@property (strong, nonatomic) IBOutlet UITextField *wordGuessTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _wordSearch.text = @"";
    _notificationLabel.text = @"";
    [self generateWordSearch];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createWordsArray {
    _wordsInWordSearch = [NSMutableArray arrayWithObjects:@"FAR", @"ACTS", @"GRIZZLY", @"STACK", @"RAGING", @"PHONE", @"TABLET", @"IRE", @"WISH", @"TACO", nil];
}

- (NSString *)pickRandomLetter {
    NSArray *alphabet = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    return alphabet[arc4random() % [alphabet count]];
}

- (NSString *)pickWordAndRemoveFromArray {
    if ([_wordsInWordSearch count] > 0) {
        int wordIndex = arc4random() % [_wordsInWordSearch count];
        NSString *word = _wordsInWordSearch[wordIndex];
        [_wordsToCheckAgainst addObject:word];
        [_wordsInWordSearch removeObjectAtIndex:wordIndex];
        return word;
    } else {
        return nil;
    }
}

- (void)addRandomLettersToArray:(NSMutableArray *)array {
    int i = 1;
    while (i < 10) {
        [array addObject:[self pickRandomLetter]];
        i++;
    }
}

- (void)shuffleCharArray:(NSMutableArray *)charArray {
    for (int i = 0; i < [charArray count]; i++) {
        int randomIndex = arc4random() % [charArray count];
        [charArray exchangeObjectAtIndex:i withObjectAtIndex:randomIndex];
    }
}

- (void)addLettersAndShuffle:(NSMutableArray *)array {
    [self addRandomLettersToArray:array];
    [self shuffleCharArray:array];
}

- (NSString *)createLineInWordSearch {
    NSString *word = [self pickWordAndRemoveFromArray];
    NSMutableArray *chars = [NSMutableArray arrayWithObjects:word, nil];
    [self addLettersAndShuffle:chars];
    [chars addObject:@"\n"];
    NSString *line = [chars componentsJoinedByString:@""];
    NSLog(@"%@", line);
    return line;
}

- (void)generateWordSearch {
    [self createWordsArray];
    _wordsToCheckAgainst = [[NSMutableArray alloc]init];
    int i = 0;
    while (i < 11) {
        NSLog(@"Words in _wordsInSearch: %lu", [_wordsInWordSearch count]);
        NSLog(@"Words in _wordsToCheckAgainst: %lu", [_wordsToCheckAgainst count]);
        NSLog(@"Creating line %i", i);
        NSString *newLine = [self createLineInWordSearch];
        _wordSearch.text = [_wordSearch.text stringByAppendingString:newLine];
        i++;
    }
}

- (void)checkUserInput:(NSString *)userInput {
    NSString *normalizedInput = [userInput uppercaseString];
    NSError *error;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\W" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSInteger numberOfMatches = [regex numberOfMatchesInString:normalizedInput options:0 range:NSMakeRange(0, [normalizedInput length])];
    if (numberOfMatches > 0) {
        _notificationLabel.text = @"Letters only please";
    } else {
        if ([_wordsToCheckAgainst containsObject:normalizedInput]) {
            _notificationLabel.text = [NSString stringWithFormat:@"%@ found!", normalizedInput];
        } else {
            _notificationLabel.text = @"Nope. Try again.";
        }
    }
}
- (IBAction)guessButtonPressed:(UIButton *)sender {
    [self checkUserInput:_wordGuessTextField.text];
}

@end
