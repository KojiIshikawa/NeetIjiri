// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OkanM.h instead.

#import <CoreData/CoreData.h>

extern const struct OkanMAttributes {
	__unsafe_unretained NSString *okanID;
	__unsafe_unretained NSString *okanText;
} OkanMAttributes;

@interface OkanMID : NSManagedObjectID {}
@end

@interface _OkanM : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) OkanMID* objectID;

@property (nonatomic, strong) NSNumber* okanID;

@property (atomic) int32_t okanIDValue;
- (int32_t)okanIDValue;
- (void)setOkanIDValue:(int32_t)value_;

//- (BOOL)validateOkanID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* okanText;

//- (BOOL)validateOkanText:(id*)value_ error:(NSError**)error_;

@end

@interface _OkanM (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveOkanID;
- (void)setPrimitiveOkanID:(NSNumber*)value;

- (int32_t)primitiveOkanIDValue;
- (void)setPrimitiveOkanIDValue:(int32_t)value_;

- (NSString*)primitiveOkanText;
- (void)setPrimitiveOkanText:(NSString*)value;

@end
