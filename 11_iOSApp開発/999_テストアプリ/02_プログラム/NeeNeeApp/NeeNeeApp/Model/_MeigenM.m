// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MeigenM.m instead.

#import "_MeigenM.h"

const struct MeigenMAttributes MeigenMAttributes = {
	.meigenID = @"meigenID",
	.meigenText = @"meigenText",
	.viewNo = @"viewNo",
};

@implementation MeigenMID
@end

@implementation _MeigenM

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MeigenM" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MeigenM";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MeigenM" inManagedObjectContext:moc_];
}

- (MeigenMID*)objectID {
	return (MeigenMID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"meigenIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"meigenID"];
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

@dynamic meigenID;

- (int32_t)meigenIDValue {
	NSNumber *result = [self meigenID];
	return [result intValue];
}

- (void)setMeigenIDValue:(int32_t)value_ {
	[self setMeigenID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMeigenIDValue {
	NSNumber *result = [self primitiveMeigenID];
	return [result intValue];
}

- (void)setPrimitiveMeigenIDValue:(int32_t)value_ {
	[self setPrimitiveMeigenID:[NSNumber numberWithInt:value_]];
}

@dynamic meigenText;

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

