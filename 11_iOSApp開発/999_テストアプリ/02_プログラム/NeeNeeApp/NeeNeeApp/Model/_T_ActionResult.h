// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_ActionResult.h instead.

#import <CoreData/CoreData.h>

extern const struct T_ActionResultAttributes {
	__unsafe_unretained NSString *actEndDate;
	__unsafe_unretained NSString *actSetDate;
	__unsafe_unretained NSString *actStartDate;
	__unsafe_unretained NSString *itemID;
	__unsafe_unretained NSString *resultID;
} T_ActionResultAttributes;

@interface T_ActionResultID : NSManagedObjectID {}
@end

@interface _T_ActionResult : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) T_ActionResultID* objectID;

@property (nonatomic, strong) NSDate* actEndDate;

//- (BOOL)validateActEndDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* actSetDate;

//- (BOOL)validateActSetDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* actStartDate;

//- (BOOL)validateActStartDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* itemID;

@property (atomic) int32_t itemIDValue;
- (int32_t)itemIDValue;
- (void)setItemIDValue:(int32_t)value_;

//- (BOOL)validateItemID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* resultID;

@property (atomic) int32_t resultIDValue;
- (int32_t)resultIDValue;
- (void)setResultIDValue:(int32_t)value_;

//- (BOOL)validateResultID:(id*)value_ error:(NSError**)error_;

@end

@interface _T_ActionResult (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveActEndDate;
- (void)setPrimitiveActEndDate:(NSDate*)value;

- (NSDate*)primitiveActSetDate;
- (void)setPrimitiveActSetDate:(NSDate*)value;

- (NSDate*)primitiveActStartDate;
- (void)setPrimitiveActStartDate:(NSDate*)value;

- (NSNumber*)primitiveItemID;
- (void)setPrimitiveItemID:(NSNumber*)value;

- (int32_t)primitiveItemIDValue;
- (void)setPrimitiveItemIDValue:(int32_t)value_;

- (NSNumber*)primitiveResultID;
- (void)setPrimitiveResultID:(NSNumber*)value;

- (int32_t)primitiveResultIDValue;
- (void)setPrimitiveResultIDValue:(int32_t)value_;

@end
