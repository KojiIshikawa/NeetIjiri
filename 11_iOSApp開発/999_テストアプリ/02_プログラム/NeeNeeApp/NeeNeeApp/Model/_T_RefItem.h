// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_RefItem.h instead.

#import <CoreData/CoreData.h>

extern const struct T_RefItemAttributes {
	__unsafe_unretained NSString *charaID;
	__unsafe_unretained NSString *itemID;
} T_RefItemAttributes;

@interface T_RefItemID : NSManagedObjectID {}
@end

@interface _T_RefItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) T_RefItemID* objectID;

@property (nonatomic, strong) NSNumber* charaID;

@property (atomic) int32_t charaIDValue;
- (int32_t)charaIDValue;
- (void)setCharaIDValue:(int32_t)value_;

//- (BOOL)validateCharaID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* itemID;

@property (atomic) int32_t itemIDValue;
- (int32_t)itemIDValue;
- (void)setItemIDValue:(int32_t)value_;

//- (BOOL)validateItemID:(id*)value_ error:(NSError**)error_;

@end

@interface _T_RefItem (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCharaID;
- (void)setPrimitiveCharaID:(NSNumber*)value;

- (int32_t)primitiveCharaIDValue;
- (void)setPrimitiveCharaIDValue:(int32_t)value_;

- (NSNumber*)primitiveItemID;
- (void)setPrimitiveItemID:(NSNumber*)value;

- (int32_t)primitiveItemIDValue;
- (void)setPrimitiveItemIDValue:(int32_t)value_;

@end
