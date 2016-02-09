// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_CharaBase.m instead.

#import "_T_CharaBase.h"

const struct T_CharaBaseAttributes T_CharaBaseAttributes = {
	.charaBirth = @"charaBirth",
	.charaName = @"charaName",
	.jobID = @"jobID",
	.kakugenID = @"kakugenID",
	.point1 = @"point1",
	.point2 = @"point2",
	.point3 = @"point3",
};

@implementation T_CharaBaseID
@end

@implementation _T_CharaBase

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"T_CharaBase" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"T_CharaBase";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"T_CharaBase" inManagedObjectContext:moc_];
}

- (T_CharaBaseID*)objectID {
	return (T_CharaBaseID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"jobIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"jobID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"kakugenIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"kakugenID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"point1Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"point1"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"point2Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"point2"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"point3Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"point3"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic charaBirth;

@dynamic charaName;

@dynamic jobID;

- (int32_t)jobIDValue {
	NSNumber *result = [self jobID];
	return [result intValue];
}

- (void)setJobIDValue:(int32_t)value_ {
	[self setJobID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveJobIDValue {
	NSNumber *result = [self primitiveJobID];
	return [result intValue];
}

- (void)setPrimitiveJobIDValue:(int32_t)value_ {
	[self setPrimitiveJobID:[NSNumber numberWithInt:value_]];
}

@dynamic kakugenID;

- (int32_t)kakugenIDValue {
	NSNumber *result = [self kakugenID];
	return [result intValue];
}

- (void)setKakugenIDValue:(int32_t)value_ {
	[self setKakugenID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveKakugenIDValue {
	NSNumber *result = [self primitiveKakugenID];
	return [result intValue];
}

- (void)setPrimitiveKakugenIDValue:(int32_t)value_ {
	[self setPrimitiveKakugenID:[NSNumber numberWithInt:value_]];
}

@dynamic point1;

- (int32_t)point1Value {
	NSNumber *result = [self point1];
	return [result intValue];
}

- (void)setPoint1Value:(int32_t)value_ {
	[self setPoint1:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePoint1Value {
	NSNumber *result = [self primitivePoint1];
	return [result intValue];
}

- (void)setPrimitivePoint1Value:(int32_t)value_ {
	[self setPrimitivePoint1:[NSNumber numberWithInt:value_]];
}

@dynamic point2;

- (int32_t)point2Value {
	NSNumber *result = [self point2];
	return [result intValue];
}

- (void)setPoint2Value:(int32_t)value_ {
	[self setPoint2:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePoint2Value {
	NSNumber *result = [self primitivePoint2];
	return [result intValue];
}

- (void)setPrimitivePoint2Value:(int32_t)value_ {
	[self setPrimitivePoint2:[NSNumber numberWithInt:value_]];
}

@dynamic point3;

- (int32_t)point3Value {
	NSNumber *result = [self point3];
	return [result intValue];
}

- (void)setPoint3Value:(int32_t)value_ {
	[self setPoint3:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePoint3Value {
	NSNumber *result = [self primitivePoint3];
	return [result intValue];
}

- (void)setPrimitivePoint3Value:(int32_t)value_ {
	[self setPrimitivePoint3:[NSNumber numberWithInt:value_]];
}

@end

