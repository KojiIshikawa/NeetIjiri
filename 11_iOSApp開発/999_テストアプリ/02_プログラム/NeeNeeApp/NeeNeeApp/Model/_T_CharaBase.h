// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_CharaBase.h instead.

#import <CoreData/CoreData.h>

extern const struct T_CharaBaseAttributes {
	__unsafe_unretained NSString *charaBirth;
	__unsafe_unretained NSString *charaID;
	__unsafe_unretained NSString *charaName;
	__unsafe_unretained NSString *jobID;
	__unsafe_unretained NSString *kakugenID;
	__unsafe_unretained NSString *point1;
	__unsafe_unretained NSString *point2;
	__unsafe_unretained NSString *point3;
} T_CharaBaseAttributes;

@interface T_CharaBaseID : NSManagedObjectID {}
@end

@interface _T_CharaBase : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) T_CharaBaseID* objectID;

@property (nonatomic, strong) NSDate* charaBirth;

//- (BOOL)validateCharaBirth:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* charaID;

@property (atomic) int32_t charaIDValue;
- (int32_t)charaIDValue;
- (void)setCharaIDValue:(int32_t)value_;

//- (BOOL)validateCharaID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* charaName;

//- (BOOL)validateCharaName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* jobID;

@property (atomic) int32_t jobIDValue;
- (int32_t)jobIDValue;
- (void)setJobIDValue:(int32_t)value_;

//- (BOOL)validateJobID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* kakugenID;

@property (atomic) int32_t kakugenIDValue;
- (int32_t)kakugenIDValue;
- (void)setKakugenIDValue:(int32_t)value_;

//- (BOOL)validateKakugenID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* point1;

@property (atomic) int32_t point1Value;
- (int32_t)point1Value;
- (void)setPoint1Value:(int32_t)value_;

//- (BOOL)validatePoint1:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* point2;

@property (atomic) int32_t point2Value;
- (int32_t)point2Value;
- (void)setPoint2Value:(int32_t)value_;

//- (BOOL)validatePoint2:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* point3;

@property (atomic) int32_t point3Value;
- (int32_t)point3Value;
- (void)setPoint3Value:(int32_t)value_;

//- (BOOL)validatePoint3:(id*)value_ error:(NSError**)error_;

@end

@interface _T_CharaBase (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCharaBirth;
- (void)setPrimitiveCharaBirth:(NSDate*)value;

- (NSNumber*)primitiveCharaID;
- (void)setPrimitiveCharaID:(NSNumber*)value;

- (int32_t)primitiveCharaIDValue;
- (void)setPrimitiveCharaIDValue:(int32_t)value_;

- (NSString*)primitiveCharaName;
- (void)setPrimitiveCharaName:(NSString*)value;

- (NSNumber*)primitiveJobID;
- (void)setPrimitiveJobID:(NSNumber*)value;

- (int32_t)primitiveJobIDValue;
- (void)setPrimitiveJobIDValue:(int32_t)value_;

- (NSNumber*)primitiveKakugenID;
- (void)setPrimitiveKakugenID:(NSNumber*)value;

- (int32_t)primitiveKakugenIDValue;
- (void)setPrimitiveKakugenIDValue:(int32_t)value_;

- (NSNumber*)primitivePoint1;
- (void)setPrimitivePoint1:(NSNumber*)value;

- (int32_t)primitivePoint1Value;
- (void)setPrimitivePoint1Value:(int32_t)value_;

- (NSNumber*)primitivePoint2;
- (void)setPrimitivePoint2:(NSNumber*)value;

- (int32_t)primitivePoint2Value;
- (void)setPrimitivePoint2Value:(int32_t)value_;

- (NSNumber*)primitivePoint3;
- (void)setPrimitivePoint3:(NSNumber*)value;

- (int32_t)primitivePoint3Value;
- (void)setPrimitivePoint3Value:(int32_t)value_;

@end
