// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OkanM.m instead.

#import "_OkanM.h"

const struct OkanMAttributes OkanMAttributes = {
	.okanID = @"okanID",
	.okanText = @"okanText",
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

	if ([key isEqualToString:@"okanIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"okanID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic okanID;

- (int32_t)okanIDValue {
	NSNumber *result = [self okanID];
	return [result intValue];
}

- (void)setOkanIDValue:(int32_t)value_ {
	[self setOkanID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveOkanIDValue {
	NSNumber *result = [self primitiveOkanID];
	return [result intValue];
}

- (void)setPrimitiveOkanIDValue:(int32_t)value_ {
	[self setPrimitiveOkanID:[NSNumber numberWithInt:value_]];
}

@dynamic okanText;

@end

