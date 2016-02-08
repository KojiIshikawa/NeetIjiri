// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_RefKakugen.h instead.

#import <CoreData/CoreData.h>

extern const struct T_RefKakugenAttributes {
	__unsafe_unretained NSString *charaID;
	__unsafe_unretained NSString *kakugenID;
} T_RefKakugenAttributes;

@interface T_RefKakugenID : NSManagedObjectID {}
@end

@interface _T_RefKakugen : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) T_RefKakugenID* objectID;

@property (nonatomic, strong) NSNumber* charaID;

@property (atomic) int32_t charaIDValue;
- (int32_t)charaIDValue;
- (void)setCharaIDValue:(int32_t)value_;

//- (BOOL)validateCharaID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* kakugenID;

@property (atomic) int32_t kakugenIDValue;
- (int32_t)kakugenIDValue;
- (void)setKakugenIDValue:(int32_t)value_;

//- (BOOL)validateKakugenID:(id*)value_ error:(NSError**)error_;

@end

@interface _T_RefKakugen (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCharaID;
- (void)setPrimitiveCharaID:(NSNumber*)value;

- (int32_t)primitiveCharaIDValue;
- (void)setPrimitiveCharaIDValue:(int32_t)value_;

- (NSNumber*)primitiveKakugenID;
- (void)setPrimitiveKakugenID:(NSNumber*)value;

- (int32_t)primitiveKakugenIDValue;
- (void)setPrimitiveKakugenIDValue:(int32_t)value_;

@end
