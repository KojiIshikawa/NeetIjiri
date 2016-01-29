// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MeigenM.h instead.

#import <CoreData/CoreData.h>

extern const struct MeigenMAttributes {
	__unsafe_unretained NSString *meigenID;
	__unsafe_unretained NSString *meigenText;
	__unsafe_unretained NSString *viewNo;
} MeigenMAttributes;

@interface MeigenMID : NSManagedObjectID {}
@end

@interface _MeigenM : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MeigenMID* objectID;

@property (nonatomic, strong) NSNumber* meigenID;

@property (atomic) int32_t meigenIDValue;
- (int32_t)meigenIDValue;
- (void)setMeigenIDValue:(int32_t)value_;

//- (BOOL)validateMeigenID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* meigenText;

//- (BOOL)validateMeigenText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* viewNo;

@property (atomic) int32_t viewNoValue;
- (int32_t)viewNoValue;
- (void)setViewNoValue:(int32_t)value_;

//- (BOOL)validateViewNo:(id*)value_ error:(NSError**)error_;

@end

@interface _MeigenM (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveMeigenID;
- (void)setPrimitiveMeigenID:(NSNumber*)value;

- (int32_t)primitiveMeigenIDValue;
- (void)setPrimitiveMeigenIDValue:(int32_t)value_;

- (NSString*)primitiveMeigenText;
- (void)setPrimitiveMeigenText:(NSString*)value;

- (NSNumber*)primitiveViewNo;
- (void)setPrimitiveViewNo:(NSNumber*)value;

- (int32_t)primitiveViewNoValue;
- (void)setPrimitiveViewNoValue:(int32_t)value_;

@end
