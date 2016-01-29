// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JobM.h instead.

#import <CoreData/CoreData.h>

extern const struct JobMAttributes {
	__unsafe_unretained NSString *jobID;
	__unsafe_unretained NSString *jobName;
	__unsafe_unretained NSString *jobText;
	__unsafe_unretained NSString *maxStageID;
	__unsafe_unretained NSString *viewNo;
} JobMAttributes;

@interface JobMID : NSManagedObjectID {}
@end

@interface _JobM : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) JobMID* objectID;

@property (nonatomic, strong) NSNumber* jobID;

@property (atomic) int32_t jobIDValue;
- (int32_t)jobIDValue;
- (void)setJobIDValue:(int32_t)value_;

//- (BOOL)validateJobID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* jobName;

//- (BOOL)validateJobName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* jobText;

//- (BOOL)validateJobText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* maxStageID;

@property (atomic) int32_t maxStageIDValue;
- (int32_t)maxStageIDValue;
- (void)setMaxStageIDValue:(int32_t)value_;

//- (BOOL)validateMaxStageID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* viewNo;

@property (atomic) int32_t viewNoValue;
- (int32_t)viewNoValue;
- (void)setViewNoValue:(int32_t)value_;

//- (BOOL)validateViewNo:(id*)value_ error:(NSError**)error_;

@end

@interface _JobM (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveJobID;
- (void)setPrimitiveJobID:(NSNumber*)value;

- (int32_t)primitiveJobIDValue;
- (void)setPrimitiveJobIDValue:(int32_t)value_;

- (NSString*)primitiveJobName;
- (void)setPrimitiveJobName:(NSString*)value;

- (NSString*)primitiveJobText;
- (void)setPrimitiveJobText:(NSString*)value;

- (NSNumber*)primitiveMaxStageID;
- (void)setPrimitiveMaxStageID:(NSNumber*)value;

- (int32_t)primitiveMaxStageIDValue;
- (void)setPrimitiveMaxStageIDValue:(int32_t)value_;

- (NSNumber*)primitiveViewNo;
- (void)setPrimitiveViewNo:(NSNumber*)value;

- (int32_t)primitiveViewNoValue;
- (void)setPrimitiveViewNoValue:(int32_t)value_;

@end
