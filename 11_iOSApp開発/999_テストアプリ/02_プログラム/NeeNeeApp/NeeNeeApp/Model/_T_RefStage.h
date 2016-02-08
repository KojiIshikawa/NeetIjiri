// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_RefStage.h instead.

#import <CoreData/CoreData.h>

extern const struct T_RefStageAttributes {
	__unsafe_unretained NSString *charaID;
	__unsafe_unretained NSString *stageID;
} T_RefStageAttributes;

@interface T_RefStageID : NSManagedObjectID {}
@end

@interface _T_RefStage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) T_RefStageID* objectID;

@property (nonatomic, strong) NSNumber* charaID;

@property (atomic) int32_t charaIDValue;
- (int32_t)charaIDValue;
- (void)setCharaIDValue:(int32_t)value_;

//- (BOOL)validateCharaID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* stageID;

@property (atomic) int32_t stageIDValue;
- (int32_t)stageIDValue;
- (void)setStageIDValue:(int32_t)value_;

//- (BOOL)validateStageID:(id*)value_ error:(NSError**)error_;

@end

@interface _T_RefStage (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCharaID;
- (void)setPrimitiveCharaID:(NSNumber*)value;

- (int32_t)primitiveCharaIDValue;
- (void)setPrimitiveCharaIDValue:(int32_t)value_;

- (NSNumber*)primitiveStageID;
- (void)setPrimitiveStageID:(NSNumber*)value;

- (int32_t)primitiveStageIDValue;
- (void)setPrimitiveStageIDValue:(int32_t)value_;

@end
