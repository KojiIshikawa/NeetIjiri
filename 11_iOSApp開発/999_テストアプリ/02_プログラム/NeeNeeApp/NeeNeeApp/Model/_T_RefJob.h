// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_RefJob.h instead.

#import <CoreData/CoreData.h>

extern const struct T_RefJobAttributes {
	__unsafe_unretained NSString *charaID;
	__unsafe_unretained NSString *jobID;
} T_RefJobAttributes;

@interface T_RefJobID : NSManagedObjectID {}
@end

@interface _T_RefJob : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) T_RefJobID* objectID;

@property (nonatomic, strong) NSNumber* charaID;

@property (atomic) int32_t charaIDValue;
- (int32_t)charaIDValue;
- (void)setCharaIDValue:(int32_t)value_;

//- (BOOL)validateCharaID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* jobID;

@property (atomic) int32_t jobIDValue;
- (int32_t)jobIDValue;
- (void)setJobIDValue:(int32_t)value_;

//- (BOOL)validateJobID:(id*)value_ error:(NSError**)error_;

@end

@interface _T_RefJob (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCharaID;
- (void)setPrimitiveCharaID:(NSNumber*)value;

- (int32_t)primitiveCharaIDValue;
- (void)setPrimitiveCharaIDValue:(int32_t)value_;

- (NSNumber*)primitiveJobID;
- (void)setPrimitiveJobID:(NSNumber*)value;

- (int32_t)primitiveJobIDValue;
- (void)setPrimitiveJobIDValue:(int32_t)value_;

@end
