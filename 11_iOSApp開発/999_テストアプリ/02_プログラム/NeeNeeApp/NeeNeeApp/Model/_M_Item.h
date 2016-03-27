// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Item.h instead.

#import <CoreData/CoreData.h>

extern const struct M_ItemAttributes {
	__unsafe_unretained NSString *animeKBN;
	__unsafe_unretained NSString *firstX;
	__unsafe_unretained NSString *firstY;
	__unsafe_unretained NSString *imageItem;
	__unsafe_unretained NSString *itemID;
	__unsafe_unretained NSString *itemName;
	__unsafe_unretained NSString *itemText;
	__unsafe_unretained NSString *maxX;
	__unsafe_unretained NSString *maxY;
	__unsafe_unretained NSString *minX;
	__unsafe_unretained NSString *minY;
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

@property (nonatomic, strong) NSNumber* animeKBN;

@property (atomic) int32_t animeKBNValue;
- (int32_t)animeKBNValue;
- (void)setAnimeKBNValue:(int32_t)value_;

//- (BOOL)validateAnimeKBN:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* firstX;

@property (atomic) int32_t firstXValue;
- (int32_t)firstXValue;
- (void)setFirstXValue:(int32_t)value_;

//- (BOOL)validateFirstX:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* firstY;

@property (atomic) int32_t firstYValue;
- (int32_t)firstYValue;
- (void)setFirstYValue:(int32_t)value_;

//- (BOOL)validateFirstY:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageItem;

//- (BOOL)validateImageItem:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* itemID;

@property (atomic) int32_t itemIDValue;
- (int32_t)itemIDValue;
- (void)setItemIDValue:(int32_t)value_;

//- (BOOL)validateItemID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* itemName;

//- (BOOL)validateItemName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* itemText;

//- (BOOL)validateItemText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* maxX;

@property (atomic) int32_t maxXValue;
- (int32_t)maxXValue;
- (void)setMaxXValue:(int32_t)value_;

//- (BOOL)validateMaxX:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* maxY;

@property (atomic) int32_t maxYValue;
- (int32_t)maxYValue;
- (void)setMaxYValue:(int32_t)value_;

//- (BOOL)validateMaxY:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* minX;

@property (atomic) int32_t minXValue;
- (int32_t)minXValue;
- (void)setMinXValue:(int32_t)value_;

//- (BOOL)validateMinX:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* minY;

@property (atomic) int32_t minYValue;
- (int32_t)minYValue;
- (void)setMinYValue:(int32_t)value_;

//- (BOOL)validateMinY:(id*)value_ error:(NSError**)error_;

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

- (NSNumber*)primitiveAnimeKBN;
- (void)setPrimitiveAnimeKBN:(NSNumber*)value;

- (int32_t)primitiveAnimeKBNValue;
- (void)setPrimitiveAnimeKBNValue:(int32_t)value_;

- (NSNumber*)primitiveFirstX;
- (void)setPrimitiveFirstX:(NSNumber*)value;

- (int32_t)primitiveFirstXValue;
- (void)setPrimitiveFirstXValue:(int32_t)value_;

- (NSNumber*)primitiveFirstY;
- (void)setPrimitiveFirstY:(NSNumber*)value;

- (int32_t)primitiveFirstYValue;
- (void)setPrimitiveFirstYValue:(int32_t)value_;

- (NSString*)primitiveImageItem;
- (void)setPrimitiveImageItem:(NSString*)value;

- (NSNumber*)primitiveItemID;
- (void)setPrimitiveItemID:(NSNumber*)value;

- (int32_t)primitiveItemIDValue;
- (void)setPrimitiveItemIDValue:(int32_t)value_;

- (NSString*)primitiveItemName;
- (void)setPrimitiveItemName:(NSString*)value;

- (NSString*)primitiveItemText;
- (void)setPrimitiveItemText:(NSString*)value;

- (NSNumber*)primitiveMaxX;
- (void)setPrimitiveMaxX:(NSNumber*)value;

- (int32_t)primitiveMaxXValue;
- (void)setPrimitiveMaxXValue:(int32_t)value_;

- (NSNumber*)primitiveMaxY;
- (void)setPrimitiveMaxY:(NSNumber*)value;

- (int32_t)primitiveMaxYValue;
- (void)setPrimitiveMaxYValue:(int32_t)value_;

- (NSNumber*)primitiveMinX;
- (void)setPrimitiveMinX:(NSNumber*)value;

- (int32_t)primitiveMinXValue;
- (void)setPrimitiveMinXValue:(int32_t)value_;

- (NSNumber*)primitiveMinY;
- (void)setPrimitiveMinY:(NSNumber*)value;

- (int32_t)primitiveMinYValue;
- (void)setPrimitiveMinYValue:(int32_t)value_;

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
