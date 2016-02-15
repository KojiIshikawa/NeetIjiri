// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Okan.h instead.

#import <CoreData/CoreData.h>

extern const struct M_OkanAttributes {
	__unsafe_unretained NSString *loginDays;
	__unsafe_unretained NSString *okanID;
	__unsafe_unretained NSString *okanText;
} M_OkanAttributes;

@interface M_OkanID : NSManagedObjectID {}
@end

@interface _M_Okan : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) M_OkanID* objectID;

@property (nonatomic, strong) NSNumber* loginDays;

@property (atomic) int32_t loginDaysValue;
- (int32_t)loginDaysValue;
- (void)setLoginDaysValue:(int32_t)value_;

//- (BOOL)validateLoginDays:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* okanID;

@property (atomic) int32_t okanIDValue;
- (int32_t)okanIDValue;
- (void)setOkanIDValue:(int32_t)value_;

//- (BOOL)validateOkanID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* okanText;

//- (BOOL)validateOkanText:(id*)value_ error:(NSError**)error_;

@end

@interface _M_Okan (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveLoginDays;
- (void)setPrimitiveLoginDays:(NSNumber*)value;

- (int32_t)primitiveLoginDaysValue;
- (void)setPrimitiveLoginDaysValue:(int32_t)value_;

- (NSNumber*)primitiveOkanID;
- (void)setPrimitiveOkanID:(NSNumber*)value;

- (int32_t)primitiveOkanIDValue;
- (void)setPrimitiveOkanIDValue:(int32_t)value_;

- (NSString*)primitiveOkanText;
- (void)setPrimitiveOkanText:(NSString*)value;

@end
