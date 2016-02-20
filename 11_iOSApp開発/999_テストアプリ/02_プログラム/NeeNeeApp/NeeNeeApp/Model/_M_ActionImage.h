// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_ActionImage.h instead.

#import <CoreData/CoreData.h>

extern const struct M_ActionImageAttributes {
	__unsafe_unretained NSString *actID;
	__unsafe_unretained NSString *imageAct;
	__unsafe_unretained NSString *stageID;
	__unsafe_unretained NSString *way;
} M_ActionImageAttributes;

@interface M_ActionImageID : NSManagedObjectID {}
@end

@interface _M_ActionImage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) M_ActionImageID* objectID;

@property (nonatomic, strong) NSNumber* actID;

@property (atomic) int32_t actIDValue;
- (int32_t)actIDValue;
- (void)setActIDValue:(int32_t)value_;

//- (BOOL)validateActID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageAct;

//- (BOOL)validateImageAct:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* stageID;

@property (atomic) int32_t stageIDValue;
- (int32_t)stageIDValue;
- (void)setStageIDValue:(int32_t)value_;

//- (BOOL)validateStageID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* way;

@property (atomic) int32_t wayValue;
- (int32_t)wayValue;
- (void)setWayValue:(int32_t)value_;

//- (BOOL)validateWay:(id*)value_ error:(NSError**)error_;

@end

@interface _M_ActionImage (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveActID;
- (void)setPrimitiveActID:(NSNumber*)value;

- (int32_t)primitiveActIDValue;
- (void)setPrimitiveActIDValue:(int32_t)value_;

- (NSString*)primitiveImageAct;
- (void)setPrimitiveImageAct:(NSString*)value;

- (NSNumber*)primitiveStageID;
- (void)setPrimitiveStageID:(NSNumber*)value;

- (int32_t)primitiveStageIDValue;
- (void)setPrimitiveStageIDValue:(int32_t)value_;

- (NSNumber*)primitiveWay;
- (void)setPrimitiveWay:(NSNumber*)value;

- (int32_t)primitiveWayValue;
- (void)setPrimitiveWayValue:(int32_t)value_;

@end
