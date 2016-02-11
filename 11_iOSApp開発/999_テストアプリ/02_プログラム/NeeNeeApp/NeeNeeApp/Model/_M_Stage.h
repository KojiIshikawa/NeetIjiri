// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Stage.h instead.

#import <CoreData/CoreData.h>

extern const struct M_StageAttributes {
	__unsafe_unretained NSString *bgm;
	__unsafe_unretained NSString *imageBack;
	__unsafe_unretained NSString *stageID;
	__unsafe_unretained NSString *stageName;
	__unsafe_unretained NSString *stageText;
	__unsafe_unretained NSString *viewNo;
} M_StageAttributes;

@interface M_StageID : NSManagedObjectID {}
@end

@interface _M_Stage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) M_StageID* objectID;

@property (nonatomic, strong) NSString* bgm;

//- (BOOL)validateBgm:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageBack;

//- (BOOL)validateImageBack:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* stageID;

@property (atomic) int32_t stageIDValue;
- (int32_t)stageIDValue;
- (void)setStageIDValue:(int32_t)value_;

//- (BOOL)validateStageID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* stageName;

//- (BOOL)validateStageName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* stageText;

//- (BOOL)validateStageText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* viewNo;

@property (atomic) int32_t viewNoValue;
- (int32_t)viewNoValue;
- (void)setViewNoValue:(int32_t)value_;

//- (BOOL)validateViewNo:(id*)value_ error:(NSError**)error_;

@end

@interface _M_Stage (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBgm;
- (void)setPrimitiveBgm:(NSString*)value;

- (NSString*)primitiveImageBack;
- (void)setPrimitiveImageBack:(NSString*)value;

- (NSNumber*)primitiveStageID;
- (void)setPrimitiveStageID:(NSNumber*)value;

- (int32_t)primitiveStageIDValue;
- (void)setPrimitiveStageIDValue:(int32_t)value_;

- (NSString*)primitiveStageName;
- (void)setPrimitiveStageName:(NSString*)value;

- (NSString*)primitiveStageText;
- (void)setPrimitiveStageText:(NSString*)value;

- (NSNumber*)primitiveViewNo;
- (void)setPrimitiveViewNo:(NSNumber*)value;

- (int32_t)primitiveViewNoValue;
- (void)setPrimitiveViewNoValue:(int32_t)value_;

@end
