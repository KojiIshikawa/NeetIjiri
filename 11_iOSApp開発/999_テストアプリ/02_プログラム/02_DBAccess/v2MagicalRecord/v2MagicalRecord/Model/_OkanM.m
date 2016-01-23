// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OkanM.m instead.

#import "_OkanM.h"

const struct OkanMAttributes OkanMAttributes = {
	.deleteFlg = @"deleteFlg",
	.okanCode = @"okanCode",
	.okanValue = @"okanValue",
};

@implementation OkanMID
@end

@implementation _OkanM

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"OkanM" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"OkanM";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"OkanM" inManagedObjectContext:moc_];
}

- (OkanMID*)objectID {
	return (OkanMID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"deleteFlgValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"deleteFlg"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"okanCodeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"okanCode"];
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

@dynamic okanCode;

- (int32_t)okanCodeValue {
	NSNumber *result = [self okanCode];
	return [result intValue];
}

- (void)setOkanCodeValue:(int32_t)value_ {
	[self setOkanCode:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveOkanCodeValue {
	NSNumber *result = [self primitiveOkanCode];
	return [result intValue];
}

- (void)setPrimitiveOkanCodeValue:(int32_t)value_ {
	[self setPrimitiveOkanCode:[NSNumber numberWithInt:value_]];
}

@dynamic okanValue;

@end

