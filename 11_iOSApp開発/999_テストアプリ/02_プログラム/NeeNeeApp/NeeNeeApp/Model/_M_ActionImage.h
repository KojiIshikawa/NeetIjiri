// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_ActionImage.h instead.

#import <CoreData/CoreData.h>

extern const struct M_ActionImageAttributes {
	__unsafe_unretained NSString *imageAct;
	__unsafe_unretained NSString *itemID;
	__unsafe_unretained NSString *serialNo;
	__unsafe_unretained NSString *way;
} M_ActionImageAttributes;

@interface M_ActionImageID : NSManagedObjectID {}
@end

@interface _M_ActionImage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) M_ActionImageID* objectID;

@property (nonatomic, strong) NSString* imageAct;

//- (BOOL)validateImageAct:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* itemID;

@property (atomic) int32_t itemIDValue;
- (int32_t)itemIDValue;
- (void)setItemIDValue:(int32_t)value_;

//- (BOOL)validateItemID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* serialNo;

@property (atomic) int32_t serialNoValue;
- (int32_t)serialNoValue;
- (void)setSerialNoValue:(int32_t)value_;

//- (BOOL)validateSerialNo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* way;

@property (atomic) int32_t wayValue;
- (int32_t)wayValue;
- (void)setWayValue:(int32_t)value_;

//- (BOOL)validateWay:(id*)value_ error:(NSError**)error_;

@end

@interface _M_ActionImage (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveImageAct;
- (void)setPrimitiveImageAct:(NSString*)value;

- (NSNumber*)primitiveItemID;
- (void)setPrimitiveItemID:(NSNumber*)value;

- (int32_t)primitiveItemIDValue;
- (void)setPrimitiveItemIDValue:(int32_t)value_;

- (NSNumber*)primitiveSerialNo;
- (void)setPrimitiveSerialNo:(NSNumber*)value;

- (int32_t)primitiveSerialNoValue;
- (void)setPrimitiveSerialNoValue:(int32_t)value_;

- (NSNumber*)primitiveWay;
- (void)setPrimitiveWay:(NSNumber*)value;

- (int32_t)primitiveWayValue;
- (void)setPrimitiveWayValue:(int32_t)value_;

@end
