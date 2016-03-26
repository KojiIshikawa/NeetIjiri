// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Item.m instead.

#import "_M_Item.h"

const struct M_ItemAttributes M_ItemAttributes = {
	.animation = @"animation",
	.firstX = @"firstX",
	.firstY = @"firstY",
	.imageItem = @"imageItem",
	.itemID = @"itemID",
	.itemName = @"itemName",
	.itemText = @"itemText",
	.maxX = @"maxX",
	.maxY = @"maxY",
	.minX = @"minX",
	.minY = @"minY",
	.point = @"point",
	.procTime = @"procTime",
	.stageID = @"stageID",
	.useArea = @"useArea",
	.viewNo = @"viewNo",
};

@implementation M_ItemID
@end

@implementation _M_Item

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"M_Item" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"M_Item";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"M_Item" inManagedObjectContext:moc_];
}

- (M_ItemID*)objectID {
	return (M_ItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"animationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"animation"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"firstXValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"firstX"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"firstYValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"firstY"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"itemIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"itemID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"maxXValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"maxX"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"maxYValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"maxY"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"minXValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"minX"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"minYValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"minY"];
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

@dynamic animation;

- (int32_t)animationValue {
	NSNumber *result = [self animation];
	return [result intValue];
}

- (void)setAnimationValue:(int32_t)value_ {
	[self setAnimation:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveAnimationValue {
	NSNumber *result = [self primitiveAnimation];
	return [result intValue];
}

- (void)setPrimitiveAnimationValue:(int32_t)value_ {
	[self setPrimitiveAnimation:[NSNumber numberWithInt:value_]];
}

@dynamic firstX;

- (int32_t)firstXValue {
	NSNumber *result = [self firstX];
	return [result intValue];
}

- (void)setFirstXValue:(int32_t)value_ {
	[self setFirstX:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFirstXValue {
	NSNumber *result = [self primitiveFirstX];
	return [result intValue];
}

- (void)setPrimitiveFirstXValue:(int32_t)value_ {
	[self setPrimitiveFirstX:[NSNumber numberWithInt:value_]];
}

@dynamic firstY;

- (int32_t)firstYValue {
	NSNumber *result = [self firstY];
	return [result intValue];
}

- (void)setFirstYValue:(int32_t)value_ {
	[self setFirstY:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFirstYValue {
	NSNumber *result = [self primitiveFirstY];
	return [result intValue];
}

- (void)setPrimitiveFirstYValue:(int32_t)value_ {
	[self setPrimitiveFirstY:[NSNumber numberWithInt:value_]];
}

@dynamic imageItem;

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

@dynamic maxX;

- (int32_t)maxXValue {
	NSNumber *result = [self maxX];
	return [result intValue];
}

- (void)setMaxXValue:(int32_t)value_ {
	[self setMaxX:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMaxXValue {
	NSNumber *result = [self primitiveMaxX];
	return [result intValue];
}

- (void)setPrimitiveMaxXValue:(int32_t)value_ {
	[self setPrimitiveMaxX:[NSNumber numberWithInt:value_]];
}

@dynamic maxY;

- (int32_t)maxYValue {
	NSNumber *result = [self maxY];
	return [result intValue];
}

- (void)setMaxYValue:(int32_t)value_ {
	[self setMaxY:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMaxYValue {
	NSNumber *result = [self primitiveMaxY];
	return [result intValue];
}

- (void)setPrimitiveMaxYValue:(int32_t)value_ {
	[self setPrimitiveMaxY:[NSNumber numberWithInt:value_]];
}

@dynamic minX;

- (int32_t)minXValue {
	NSNumber *result = [self minX];
	return [result intValue];
}

- (void)setMinXValue:(int32_t)value_ {
	[self setMinX:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMinXValue {
	NSNumber *result = [self primitiveMinX];
	return [result intValue];
}

- (void)setPrimitiveMinXValue:(int32_t)value_ {
	[self setPrimitiveMinX:[NSNumber numberWithInt:value_]];
}

@dynamic minY;

- (int32_t)minYValue {
	NSNumber *result = [self minY];
	return [result intValue];
}

- (void)setMinYValue:(int32_t)value_ {
	[self setMinY:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMinYValue {
	NSNumber *result = [self primitiveMinY];
	return [result intValue];
}

- (void)setPrimitiveMinYValue:(int32_t)value_ {
	[self setPrimitiveMinY:[NSNumber numberWithInt:value_]];
}

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

