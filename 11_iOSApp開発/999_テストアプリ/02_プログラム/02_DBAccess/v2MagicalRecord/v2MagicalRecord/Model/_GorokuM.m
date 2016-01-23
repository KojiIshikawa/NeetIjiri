// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GorokuM.m instead.

#import "_GorokuM.h"

const struct GorokuMAttributes GorokuMAttributes = {
	.deleteFlg = @"deleteFlg",
	.gorokuCode = @"gorokuCode",
	.gorokuValue = @"gorokuValue",
};

@implementation GorokuMID
@end

@implementation _GorokuM

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GorokuM" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GorokuM";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GorokuM" inManagedObjectContext:moc_];
}

- (GorokuMID*)objectID {
	return (GorokuMID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"deleteFlgValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"deleteFlg"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"gorokuCodeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"gorokuCode"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic deleteFlg;

- (int32_t)deleteFlgValue {
	NSNumber *result = [self deleteFlg];
	return [result intValue];
}

- (void)setDeleteFlgValue:(int32_t)value_ {
	[self setDeleteFlg:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveDeleteFlgValue {
	NSNumber *result = [self primitiveDeleteFlg];
	return [result intValue];
}

- (void)setPrimitiveDeleteFlgValue:(int32_t)value_ {
	[self setPrimitiveDeleteFlg:[NSNumber numberWithInt:value_]];
}

@dynamic gorokuCode;

- (int32_t)gorokuCodeValue {
	NSNumber *result = [self gorokuCode];
	return [result intValue];
}

- (void)setGorokuCodeValue:(int32_t)value_ {
	[self setGorokuCode:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveGorokuCodeValue {
	NSNumber *result = [self primitiveGorokuCode];
	return [result intValue];
}

- (void)setPrimitiveGorokuCodeValue:(int32_t)value_ {
	[self setPrimitiveGorokuCode:[NSNumber numberWithInt:value_]];
}

@dynamic gorokuValue;

@end

