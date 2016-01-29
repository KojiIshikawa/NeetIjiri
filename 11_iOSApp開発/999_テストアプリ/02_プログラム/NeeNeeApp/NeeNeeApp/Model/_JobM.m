// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JobM.m instead.

#import "_JobM.h"

const struct JobMAttributes JobMAttributes = {
	.jobID = @"jobID",
	.jobName = @"jobName",
	.jobText = @"jobText",
	.maxStageID = @"maxStageID",
	.viewNo = @"viewNo",
};

@implementation JobMID
@end

@implementation _JobM

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"JobM" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"JobM";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"JobM" inManagedObjectContext:moc_];
}

- (JobMID*)objectID {
	return (JobMID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"jobIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"jobID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"maxStageIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"maxStageID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"viewNoValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"viewNo"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic jobID;

- (int32_t)jobIDValue {
	NSNumber *result = [self jobID];
	return [result intValue];
}

- (void)setJobIDValue:(int32_t)value_ {
	[self setJobID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveJobIDValue {
	NSNumber *result = [self primitiveJobID];
	return [result intValue];
}

- (void)setPrimitiveJobIDValue:(int32_t)value_ {
	[self setPrimitiveJobID:[NSNumber numberWithInt:value_]];
}

@dynamic jobName;

@dynamic jobText;

@dynamic maxStageID;

- (int32_t)maxStageIDValue {
	NSNumber *result = [self maxStageID];
	return [result intValue];
}

- (void)setMaxStageIDValue:(int32_t)value_ {
	[self setMaxStageID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMaxStageIDValue {
	NSNumber *result = [self primitiveMaxStageID];
	return [result intValue];
}

- (void)setPrimitiveMaxStageIDValue:(int32_t)value_ {
	[self setPrimitiveMaxStageID:[NSNumber numberWithInt:value_]];
}

@dynamic viewNo;

- (int32_t)viewNoValue {
	NSNumber *result = [self viewNo];
	return [result intValue];
}

- (void)setViewNoValue:(int32_t)value_ {
	[self setViewNo:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveViewNoValue {
	NSNumber *result = [self primitiveViewNo];
	return [result intValue];
}

- (void)setPrimitiveViewNoValue:(int32_t)value_ {
	[self setPrimitiveViewNo:[NSNumber numberWithInt:value_]];
}

@end

