// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_GetItem.m instead.

#import "_T_GetItem.h"

const struct T_GetItemAttributes T_GetItemAttributes = {
	.charaID = @"charaID",
	.itemCount = @"itemCount",
	.itemID = @"itemID",
};

@implementation T_GetItemID
@end

@implementation _T_GetItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"T_GetItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"T_GetItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"T_GetItem" inManagedObjectContext:moc_];
}

- (T_GetItemID*)objectID {
	return (T_GetItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"charaIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"charaID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"itemCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"itemCount"];
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

@dynamic itemCount;

- (int32_t)itemCountValue {
	NSNumber *result = [self itemCount];
	return [result intValue];
}

- (void)setItemCountValue:(int32_t)value_ {
	[self setItemCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveItemCountValue {
	NSNumber *result = [self primitiveItemCount];
	return [result intValue];
}

- (void)setPrimitiveItemCountValue:(int32_t)value_ {
	[self setPrimitiveItemCount:[NSNumber numberWithInt:value_]];
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

