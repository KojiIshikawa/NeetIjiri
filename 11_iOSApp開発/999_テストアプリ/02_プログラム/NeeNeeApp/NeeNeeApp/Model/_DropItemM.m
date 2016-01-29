// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DropItemM.m instead.

#import "_DropItemM.h"

const struct DropItemMAttributes DropItemMAttributes = {
	.dropItemID = @"dropItemID",
	.dropPer = @"dropPer",
	.itemID = @"itemID",
};

@implementation DropItemMID
@end

@implementation _DropItemM

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"DropItemM" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"DropItemM";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"DropItemM" inManagedObjectContext:moc_];
}

- (DropItemMID*)objectID {
	return (DropItemMID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"dropItemIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"dropItemID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"dropPerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"dropPer"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"itemIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"itemID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic dropItemID;

- (int32_t)dropItemIDValue {
	NSNumber *result = [self dropItemID];
	return [result intValue];
}

- (void)setDropItemIDValue:(int32_t)value_ {
	[self setDropItemID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveDropItemIDValue {
	NSNumber *result = [self primitiveDropItemID];
	return [result intValue];
}

- (void)setPrimitiveDropItemIDValue:(int32_t)value_ {
	[self setPrimitiveDropItemID:[NSNumber numberWithInt:value_]];
}

@dynamic dropPer;

- (double)dropPerValue {
	NSNumber *result = [self dropPer];
	return [result doubleValue];
}

- (void)setDropPerValue:(double)value_ {
	[self setDropPer:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveDropPerValue {
	NSNumber *result = [self primitiveDropPer];
	return [result doubleValue];
}

- (void)setPrimitiveDropPerValue:(double)value_ {
	[self setPrimitiveDropPer:[NSNumber numberWithDouble:value_]];
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

@end

