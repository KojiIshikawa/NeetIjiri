// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Action.h instead.

#import <CoreData/CoreData.h>

extern const struct M_ActionAttributes {
	__unsafe_unretained NSString *actID;
	__unsafe_unretained NSString *actName;
	__unsafe_unretained NSString *imageAct;
	__unsafe_unretained NSString *way;
} M_ActionAttributes;

@interface M_ActionID : NSManagedObjectID {}
@end

@interface _M_Action : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) M_ActionID* objectID;

@property (nonatomic, strong) NSNumber* actID;

@property (atomic) int32_t actIDValue;
- (int32_t)actIDValue;
- (void)setActIDValue:(int32_t)value_;

//- (BOOL)validateActID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* actName;

//- (BOOL)validateActName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageAct;

//- (BOOL)validateImageAct:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* way;

@property (atomic) int32_t wayValue;
- (int32_t)wayValue;
- (void)setWayValue:(int32_t)value_;

//- (BOOL)validateWay:(id*)value_ error:(NSError**)error_;

@end

@interface _M_Action (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveActID;
- (void)setPrimitiveActID:(NSNumber*)value;

- (int32_t)primitiveActIDValue;
- (void)setPrimitiveActIDValue:(int32_t)value_;

- (NSString*)primitiveActName;
- (void)setPrimitiveActName:(NSString*)value;

- (NSString*)primitiveImageAct;
- (void)setPrimitiveImageAct:(NSString*)value;

- (NSNumber*)primitiveWay;
- (void)setPrimitiveWay:(NSNumber*)value;

- (int32_t)primitiveWayValue;
- (void)setPrimitiveWayValue:(int32_t)value_;

@end
