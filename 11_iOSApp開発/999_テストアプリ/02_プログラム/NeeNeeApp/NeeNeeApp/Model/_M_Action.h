// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Action.h instead.

#import <CoreData/CoreData.h>

extern const struct M_ActionAttributes {
	__unsafe_unretained NSString *actID;
	__unsafe_unretained NSString *actName;
	__unsafe_unretained NSString *firstX;
	__unsafe_unretained NSString *firstY;
	__unsafe_unretained NSString *maxX;
	__unsafe_unretained NSString *maxY;
	__unsafe_unretained NSString *minX;
	__unsafe_unretained NSString *minY;
	__unsafe_unretained NSString *stageID;
} M_ActionAttributes;

@interface M_ActionID : NSManagedObjectID {}
@end

@interface _M_Action : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) M_ActionID* objectID;

@property (nonatomic, strong) NSNumber* actID;

@property (atomic) int32_t actIDValue;
- (int32_t)actIDValue;
- (void)setActIDValue:(int32_t)value_;

//- (BOOL)validateActID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* actName;

//- (BOOL)validateActName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* firstX;

@property (atomic) int32_t firstXValue;
- (int32_t)firstXValue;
- (void)setFirstXValue:(int32_t)value_;

//- (BOOL)validateFirstX:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* firstY;

@property (atomic) int32_t firstYValue;
- (int32_t)firstYValue;
- (void)setFirstYValue:(int32_t)value_;

//- (BOOL)validateFirstY:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* maxX;

@property (atomic) int32_t maxXValue;
- (int32_t)maxXValue;
- (void)setMaxXValue:(int32_t)value_;

//- (BOOL)validateMaxX:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* maxY;

@property (atomic) int32_t maxYValue;
- (int32_t)maxYValue;
- (void)setMaxYValue:(int32_t)value_;

//- (BOOL)validateMaxY:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* minX;

@property (atomic) int32_t minXValue;
- (int32_t)minXValue;
- (void)setMinXValue:(int32_t)value_;

//- (BOOL)validateMinX:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* minY;

@property (atomic) int32_t minYValue;
- (int32_t)minYValue;
- (void)setMinYValue:(int32_t)value_;

//- (BOOL)validateMinY:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* stageID;

@property (atomic) int32_t stageIDValue;
- (int32_t)stageIDValue;
- (void)setStageIDValue:(int32_t)value_;

//- (BOOL)validateStageID:(id*)value_ error:(NSError**)error_;

@end

@interface _M_Action (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveActID;
- (void)setPrimitiveActID:(NSNumber*)value;

- (int32_t)primitiveActIDValue;
- (void)setPrimitiveActIDValue:(int32_t)value_;

- (NSString*)primitiveActName;
- (void)setPrimitiveActName:(NSString*)value;

- (NSNumber*)primitiveFirstX;
- (void)setPrimitiveFirstX:(NSNumber*)value;

- (int32_t)primitiveFirstXValue;
- (void)setPrimitiveFirstXValue:(int32_t)value_;

- (NSNumber*)primitiveFirstY;
- (void)setPrimitiveFirstY:(NSNumber*)value;

- (int32_t)primitiveFirstYValue;
- (void)setPrimitiveFirstYValue:(int32_t)value_;

- (NSNumber*)primitiveMaxX;
- (void)setPrimitiveMaxX:(NSNumber*)value;

- (int32_t)primitiveMaxXValue;
- (void)setPrimitiveMaxXValue:(int32_t)value_;

- (NSNumber*)primitiveMaxY;
- (void)setPrimitiveMaxY:(NSNumber*)value;

- (int32_t)primitiveMaxYValue;
- (void)setPrimitiveMaxYValue:(int32_t)value_;

- (NSNumber*)primitiveMinX;
- (void)setPrimitiveMinX:(NSNumber*)value;

- (int32_t)primitiveMinXValue;
- (void)setPrimitiveMinXValue:(int32_t)value_;

- (NSNumber*)primitiveMinY;
- (void)setPrimitiveMinY:(NSNumber*)value;

- (int32_t)primitiveMinYValue;
- (void)setPrimitiveMinYValue:(int32_t)value_;

- (NSNumber*)primitiveStageID;
- (void)setPrimitiveStageID:(NSNumber*)value;

- (int32_t)primitiveStageIDValue;
- (void)setPrimitiveStageIDValue:(int32_t)value_;

@end
