// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_RefJob.m instead.

#import "_T_RefJob.h"

const struct T_RefJobAttributes T_RefJobAttributes = {
	.charaID = @"charaID",
	.jobID = @"jobID",
};

@implementation T_RefJobID
@end

@implementation _T_RefJob

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"T_RefJob" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"T_RefJob";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"T_RefJob" inManagedObjectContext:moc_];
}

- (T_RefJobID*)objectID {
	return (T_RefJobID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"charaIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"charaID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"jobIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"jobID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic charaID;

- (int32_t)charaIDValue {
	NSNumber *result = [self charaID];
	return [result intValue];
}

- (void)setCharaIDValue:(int32_t)value_ {
	[self setCharaID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCharaIDValue {
	NSNumber *result = [self primitiveCharaID];
	return [result intValue];
}

- (void)setPrimitiveCharaIDValue:(int32_t)value_ {
	[self setPrimitiveCharaID:[NSNumber numberWithInt:value_]];
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

@end

