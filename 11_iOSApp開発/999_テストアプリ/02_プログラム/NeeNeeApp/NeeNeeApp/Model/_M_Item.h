// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Item.h instead.

#import <CoreData/CoreData.h>

extern const struct M_ItemAttributes {
	__unsafe_unretained NSString *actID;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *itemID;
	__unsafe_unretained NSString *itemName;
	__unsafe_unretained NSString *itemText;
	__unsafe_unretained NSString *point;
	__unsafe_unretained NSString *procTime;
	__unsafe_unretained NSString *stageID;
	__unsafe_unretained NSString *useArea;
	__unsafe_unretained NSString *viewNo;
} M_ItemAttributes;

@interface M_ItemID : NSManagedObjectID {}
@end

@interface _M_Item : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) M_ItemID* objectID;

@property (nonatomic, strong) NSNumber* actID;

@property (atomic) int32_t actIDValue;
- (int32_t)actIDValue;
- (void)setActIDValue:(int32_t)value_;

//- (BOOL)validateActID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* itemID;

@property (atomic) int32_t itemIDValue;
- (int32_t)itemIDValue;
- (void)setItemIDValue:(int32_t)value_;

//- (BOOL)validateItemID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* itemName;

//- (BOOL)validateItemName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* itemText;

//- (BOOL)validateItemText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* point;

@property (atomic) int32_t pointValue;
- (int32_t)pointValue;
- (void)setPointValue:(int32_t)value_;

//- (BOOL)validatePoint:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* procTime;

@property (atomic) int32_t procTimeValue;
- (int32_t)procTimeValue;
- (void)setProcTimeValue:(int32_t)value_;

//- (BOOL)validateProcTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* stageID;

@property (atomic) int32_t stageIDValue;
- (int32_t)stageIDValue;
- (void)setStageIDValue:(int32_t)value_;

//- (BOOL)validateStageID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* useArea;

@property (atomic) int32_t useAreaValue;
- (int32_t)useAreaValue;
- (void)setUseAreaValue:(int32_t)value_;

//- (BOOL)validateUseArea:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* viewNo;

@property (atomic) int32_t viewNoValue;
- (int32_t)viewNoValue;
- (void)setViewNoValue:(int32_t)value_;

//- (BOOL)validateViewNo:(id*)value_ error:(NSError**)error_;

@end

@interface _M_Item (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveActID;
- (void)setPrimitiveActID:(NSNumber*)value;

- (int32_t)primitiveActIDValue;
- (void)setPrimitiveActIDValue:(int32_t)value_;

- (NSString*)primitiveImage;
- (void)setPrimitiveImage:(NSString*)value;

- (NSNumber*)primitiveItemID;
- (void)setPrimitiveItemID:(NSNumber*)value;

- (int32_t)primitiveItemIDValue;
- (void)setPrimitiveItemIDValue:(int32_t)value_;

- (NSString*)primitiveItemName;
- (void)setPrimitiveItemName:(NSString*)value;

- (NSString*)primitiveItemText;
- (void)setPrimitiveItemText:(NSString*)value;

- (NSNumber*)primitivePoint;
- (void)setPrimitivePoint:(NSNumber*)value;

- (int32_t)primitivePointValue;
- (void)setPrimitivePointValue:(int32_t)value_;

- (NSNumber*)primitiveProcTime;
- (void)setPrimitiveProcTime:(NSNumber*)value;

- (int32_t)primitiveProcTimeValue;
- (void)setPrimitiveProcTimeValue:(int32_t)value_;

- (NSNumber*)primitiveStageID;
- (void)setPrimitiveStageID:(NSNumber*)value;

- (int32_t)primitiveStageIDValue;
- (void)setPrimitiveStageIDValue:(int32_t)value_;

- (NSNumber*)primitiveUseArea;
- (void)setPrimitiveUseArea:(NSNumber*)value;

- (int32_t)primitiveUseAreaValue;
- (void)setPrimitiveUseAreaValue:(int32_t)value_;

- (NSNumber*)primitiveViewNo;
- (void)setPrimitiveViewNo:(NSNumber*)value;

- (int32_t)primitiveViewNoValue;
- (void)setPrimitiveViewNoValue:(int32_t)value_;

@end
