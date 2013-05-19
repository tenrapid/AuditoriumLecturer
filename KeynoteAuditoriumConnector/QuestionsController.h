//
//  QuestionsController.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 10.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Auditorium, AuditoriumController, Slideshow;

@interface QuestionsController : NSObject

@property (assign) IBOutlet Auditorium *auditorium;
@property (assign) IBOutlet AuditoriumController *auditoriumController;
@property (assign) IBOutlet Slideshow *slideshow;

@end
