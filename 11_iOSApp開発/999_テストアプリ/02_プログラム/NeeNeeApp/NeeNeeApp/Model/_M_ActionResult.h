// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_ActionResult.h instead.

#import <CoreData/CoreData.h>

extern const struct M_ActionResultAttributes {
	__unsafe_unretained NSString *itemID;
	__unsafe_unretained NSString *message;
	__unsafe_unretained NSString *rankKBN;
	__unsafe_unretained NSString *resPer;
	__unsafe_unretained NSString *resultID;
} M_ActionResultAttributes;

@interface M_ActionResultID : NSManagedObjectID {}
@end

@interface _M_ActionResult : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) M_ActionResultID* objectID;

@property (nonatomic, strong) NSNumber* itemID;

@property (atomic) int32_t itemIDValue;
- (int32_t)itemIDValue;
- (void)setItemIDValue:(int32_t)value_;

//- (BOOL)validateItemID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* message;

//- (BOOL)validateMessage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* rankKBN;

//- (BOOL)validateRankKBN:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* resPer;

@property (atomic) double resPerValue;
- (double)resPerValue;
- (void)setResPerValue:(double)value_;

//- (BOOL)validateResPer:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* resultID;

@property (atomic) int32_t resultIDValue;
- (int32_t)resultIDValue;
- (void)setResultIDValue:(int32_t)value_;

//- (BOOL)validateResultID:(id*)value_ error:(NSError**)error_;

@end

@interface _M_ActionResult (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveItemID;
- (void)setPrimitiveItemID:(NSNumber*)value;

- (int32_t)primitiveItemIDValue;
- (void)setPrimitiveItemIDValue:(int32_t)value_;

- (NSString*)primitiveMessage;
- (void)setPrimitiveMessage:(NSString*)value;

- (NSString*)primitiveRankKBN;
- (void)setPrimitiveRankKBN:(NSString*)value;

- (NSNumber*)primitiveResPer;
- (void)setPrimitiveResPer:(NSNumber*)value;

- (double)primitiveResPerValue;
- (void)setPrimitiveResPerValue:(double)value_;

- (NSNumber*)primitiveResultID;
- (void)setPrimitiveResultID:(NSNumber*)value;

- (int32_t)primitiveResultIDValue;
- (void)setPrimitiveResultIDValue:(int32_t)value_;

@end
