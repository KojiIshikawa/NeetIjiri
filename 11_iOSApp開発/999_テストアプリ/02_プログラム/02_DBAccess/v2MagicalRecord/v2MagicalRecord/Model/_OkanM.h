// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OkanM.h instead.

#import <CoreData/CoreData.h>

extern const struct OkanMAttributes {
	__unsafe_unretained NSString *deleteFlg;
	__unsafe_unretained NSString *okanCode;
	__unsafe_unretained NSString *okanValue;
} OkanMAttributes;

@interface OkanMID : NSManagedObjectID {}
@end

@interface _OkanM : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) OkanMID* objectID;

@property (nonatomic, strong) NSNumber* deleteFlg;

@property (atomic) int32_t deleteFlgValue;
- (int32_t)deleteFlgValue;
- (void)setDeleteFlgValue:(int32_t)value_;

//- (BOOL)validateDeleteFlg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* okanCode;

@property (atomic) int32_t okanCodeValue;
- (int32_t)okanCodeValue;
- (void)setOkanCodeValue:(int32_t)value_;

//- (BOOL)validateOkanCode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* okanValue;

//- (BOOL)validateOkanValue:(id*)value_ error:(NSError**)error_;

@end

@interface _OkanM (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveDeleteFlg;
- (void)setPrimitiveDeleteFlg:(NSNumber*)value;

- (int32_t)primitiveDeleteFlgValue;
- (void)setPrimitiveDeleteFlgValue:(int32_t)value_;

- (NSNumber*)primitiveOkanCode;
- (void)setPrimitiveOkanCode:(NSNumber*)value;

- (int32_t)primitiveOkanCodeValue;
- (void)setPrimitiveOkanCodeValue:(int32_t)value_;

- (NSString*)primitiveOkanValue;
- (void)setPrimitiveOkanValue:(NSString*)value;

@end
