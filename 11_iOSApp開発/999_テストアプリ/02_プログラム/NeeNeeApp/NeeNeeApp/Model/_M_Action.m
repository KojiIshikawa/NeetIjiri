// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Action.m instead.

#import "_M_Action.h"

const struct M_ActionAttributes M_ActionAttributes = {
	.actID = @"actID",
	.actName = @"actName",
	.firstX = @"firstX",
	.firstY = @"firstY",
	.maxX = @"maxX",
	.maxY = @"maxY",
	.minX = @"minX",
	.minY = @"minY",
	.stageID = @"stageID",
};

@implementation M_ActionID
@end

@implementation _M_Action

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"M_Action" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"M_Action";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"M_Action" inManagedObjectContext:moc_];
}

- (M_ActionID*)objectID {
	return (M_ActionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"actIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"actID"];
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
	if ([key isEqualToString:@"stageIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"stageID"];
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

@dynamic actName;

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

@end

