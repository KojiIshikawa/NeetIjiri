// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_ActionResult.m instead.

#import "_T_ActionResult.h"

const struct T_ActionResultAttributes T_ActionResultAttributes = {
	.actEndDate = @"actEndDate",
	.actSetDate = @"actSetDate",
	.actStartDate = @"actStartDate",
	.itemID = @"itemID",
	.resultID = @"resultID",
};

@implementation T_ActionResultID
@end

@implementation _T_ActionResult

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"T_ActionResult" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"T_ActionResult";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"T_ActionResult" inManagedObjectContext:moc_];
}

- (T_ActionResultID*)objectID {
	return (T_ActionResultID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"itemIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"itemID"];
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

@dynamic actEndDate;

@dynamic actSetDate;

@dynamic actStartDate;

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

