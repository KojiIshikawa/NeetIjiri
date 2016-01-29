// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ResultActionM.m instead.

#import "_ResultActionM.h"

const struct ResultActionMAttributes ResultActionMAttributes = {
	.itemID = @"itemID",
	.message = @"message",
	.resPer = @"resPer",
	.resultID = @"resultID",
};

@implementation ResultActionMID
@end

@implementation _ResultActionM

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ResultActionM" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ResultActionM";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ResultActionM" inManagedObjectContext:moc_];
}

- (ResultActionMID*)objectID {
	return (ResultActionMID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"itemIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"itemID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"resPerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"resPer"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"resultIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"resultID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic itemID;

- (int32_t)itemIDValue {
	NSNumber *result = [self itemID];
	return [result intValue];
}

- (void)setItemIDValue:(int32_t)value_ {
	[self setItemID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveItemIDValue {
	NSNumber *result = [self primitiveItemID];
	return [result intValue];
}

- (void)setPrimitiveItemIDValue:(int32_t)value_ {
	[self setPrimitiveItemID:[NSNumber numberWithInt:value_]];
}

@dynamic message;

@dynamic resPer;

- (double)resPerValue {
	NSNumber *result = [self resPer];
	return [result doubleValue];
}

- (void)setResPerValue:(double)value_ {
	[self setResPer:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveResPerValue {
	NSNumber *result = [self primitiveResPer];
	return [result doubleValue];
}

- (void)setPrimitiveResPerValue:(double)value_ {
	[self setPrimitiveResPer:[NSNumber numberWithDouble:value_]];
}

@dynamic resultID;

- (int32_t)resultIDValue {
	NSNumber *result = [self resultID];
	return [result intValue];
}

- (void)setResultIDValue:(int32_t)value_ {
	[self setResultID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveResultIDValue {
	NSNumber *result = [self primitiveResultID];
	return [result intValue];
}

- (void)setPrimitiveResultIDValue:(int32_t)value_ {
	[self setPrimitiveResultID:[NSNumber numberWithInt:value_]];
}

@end

