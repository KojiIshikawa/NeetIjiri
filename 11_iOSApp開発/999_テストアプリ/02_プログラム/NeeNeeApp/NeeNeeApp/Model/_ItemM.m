// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ItemM.m instead.

#import "_ItemM.h"

const struct ItemMAttributes ItemMAttributes = {
	.actID = @"actID",
	.image = @"image",
	.itemID = @"itemID",
	.itemName = @"itemName",
	.itemText = @"itemText",
	.point = @"point",
	.procTime = @"procTime",
	.stageID = @"stageID",
	.useArea = @"useArea",
	.viewNo = @"viewNo",
};

@implementation ItemMID
@end

@implementation _ItemM

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ItemM" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ItemM";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ItemM" inManagedObjectContext:moc_];
}

- (ItemMID*)objectID {
	return (ItemMID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"actIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"actID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"itemIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"itemID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"pointValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"point"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"procTimeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"procTime"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"stageIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"stageID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"useAreaValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"useArea"];
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

@dynamic actID;

- (int32_t)actIDValue {
	NSNumber *result = [self actID];
	return [result intValue];
}

- (void)setActIDValue:(int32_t)value_ {
	[self setActID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveActIDValue {
	NSNumber *result = [self primitiveActID];
	return [result intValue];
}

- (void)setPrimitiveActIDValue:(int32_t)value_ {
	[self setPrimitiveActID:[NSNumber numberWithInt:value_]];
}

@dynamic image;

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

@dynamic itemName;

@dynamic itemText;

@dynamic point;

- (int32_t)pointValue {
	NSNumber *result = [self point];
	return [result intValue];
}

- (void)setPointValue:(int32_t)value_ {
	[self setPoint:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePointValue {
	NSNumber *result = [self primitivePoint];
	return [result intValue];
}

- (void)setPrimitivePointValue:(int32_t)value_ {
	[self setPrimitivePoint:[NSNumber numberWithInt:value_]];
}

@dynamic procTime;

- (int32_t)procTimeValue {
	NSNumber *result = [self procTime];
	return [result intValue];
}

- (void)setProcTimeValue:(int32_t)value_ {
	[self setProcTime:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveProcTimeValue {
	NSNumber *result = [self primitiveProcTime];
	return [result intValue];
}

- (void)setPrimitiveProcTimeValue:(int32_t)value_ {
	[self setPrimitiveProcTime:[NSNumber numberWithInt:value_]];
}

@dynamic stageID;

- (int32_t)stageIDValue {
	NSNumber *result = [self stageID];
	return [result intValue];
}

- (void)setStageIDValue:(int32_t)value_ {
	[self setStageID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveStageIDValue {
	NSNumber *result = [self primitiveStageID];
	return [result intValue];
}

- (void)setPrimitiveStageIDValue:(int32_t)value_ {
	[self setPrimitiveStageID:[NSNumber numberWithInt:value_]];
}

@dynamic useArea;

- (int32_t)useAreaValue {
	NSNumber *result = [self useArea];
	return [result intValue];
}

- (void)setUseAreaValue:(int32_t)value_ {
	[self setUseArea:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveUseAreaValue {
	NSNumber *result = [self primitiveUseArea];
	return [result intValue];
}

- (void)setPrimitiveUseAreaValue:(int32_t)value_ {
	[self setPrimitiveUseArea:[NSNumber numberWithInt:value_]];
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

