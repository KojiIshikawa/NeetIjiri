// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GorokuM.h instead.

#import <CoreData/CoreData.h>

extern const struct GorokuMAttributes {
	__unsafe_unretained NSString *deleteFlg;
	__unsafe_unretained NSString *gorokuCode;
	__unsafe_unretained NSString *gorokuValue;
} GorokuMAttributes;

@interface GorokuMID : NSManagedObjectID {}
@end

@interface _GorokuM : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) GorokuMID* objectID;

@property (nonatomic, strong) NSNumber* deleteFlg;

@property (atomic) int32_t deleteFlgValue;
- (int32_t)deleteFlgValue;
- (void)setDeleteFlgValue:(int32_t)value_;

//- (BOOL)validateDeleteFlg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* gorokuCode;

@property (atomic) int32_t gorokuCodeValue;
- (int32_t)gorokuCodeValue;
- (void)setGorokuCodeValue:(int32_t)value_;

//- (BOOL)validateGorokuCode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* gorokuValue;

//- (BOOL)validateGorokuValue:(id*)value_ error:(NSError**)error_;

@end

@interface _GorokuM (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveDeleteFlg;
- (void)setPrimitiveDeleteFlg:(NSNumber*)value;

- (int32_t)primitiveDeleteFlgValue;
- (void)setPrimitiveDeleteFlgValue:(int32_t)value_;

- (NSNumber*)primitiveGorokuCode;
- (void)setPrimitiveGorokuCode:(NSNumber*)value;

- (int32_t)primitiveGorokuCodeValue;
- (void)setPrimitiveGorokuCodeValue:(int32_t)value_;

- (NSString*)primitiveGorokuValue;
- (void)setPrimitiveGorokuValue:(NSString*)value;

@end
