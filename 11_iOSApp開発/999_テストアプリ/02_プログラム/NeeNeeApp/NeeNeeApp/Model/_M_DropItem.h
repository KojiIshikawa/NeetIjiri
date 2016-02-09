// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_DropItem.h instead.

#import <CoreData/CoreData.h>

extern const struct M_DropItemAttributes {
	__unsafe_unretained NSString *dropItemID;
	__unsafe_unretained NSString *dropPer;
	__unsafe_unretained NSString *itemID;
} M_DropItemAttributes;

@interface M_DropItemID : NSManagedObjectID {}
@end

@interface _M_DropItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) M_DropItemID* objectID;

@property (nonatomic, strong) NSNumber* dropItemID;

@property (atomic) int32_t dropItemIDValue;
- (int32_t)dropItemIDValue;
- (void)setDropItemIDValue:(int32_t)value_;

//- (BOOL)validateDropItemID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* dropPer;

@property (atomic) double dropPerValue;
- (double)dropPerValue;
- (void)setDropPerValue:(double)value_;

//- (BOOL)validateDropPer:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* itemID;

@property (atomic) int32_t itemIDValue;
- (int32_t)itemIDValue;
- (void)setItemIDValue:(int32_t)value_;

//- (BOOL)validateItemID:(id*)value_ error:(NSError**)error_;

@end

@interface _M_DropItem (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveDropItemID;
- (void)setPrimitiveDropItemID:(NSNumber*)value;

- (int32_t)primitiveDropItemIDValue;
- (void)setPrimitiveDropItemIDValue:(int32_t)value_;

- (NSNumber*)primitiveDropPer;
- (void)setPrimitiveDropPer:(NSNumber*)value;

- (double)primitiveDropPerValue;
- (void)setPrimitiveDropPerValue:(double)value_;

- (NSNumber*)primitiveItemID;
- (void)setPrimitiveItemID:(NSNumber*)value;

- (int32_t)primitiveItemIDValue;
- (void)setPrimitiveItemIDValue:(int32_t)value_;

@end
