// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_ActionImage.m instead.

#import "_M_ActionImage.h"

const struct M_ActionImageAttributes M_ActionImageAttributes = {
	.actionID = @"actionID",
	.imageAct = @"imageAct",
	.stageID = @"stageID",
	.way = @"way",
};

@implementation M_ActionImageID
@end

@implementation _M_ActionImage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"M_ActionImage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"M_ActionImage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"M_ActionImage" inManagedObjectContext:moc_];
}

- (M_ActionImageID*)objectID {
	return (M_ActionImageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"actionIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"actionID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"stageIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"stageID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"wayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"way"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic actionID;

- (int32_t)actionIDValue {
	NSNumber *result = [self actionID];
	return [result intValue];
}

- (void)setActionIDValue:(int32_t)value_ {
	[self setActionID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveActionIDValue {
	NSNumber *result = [self primitiveActionID];
	return [result intValue];
}

- (void)setPrimitiveActionIDValue:(int32_t)value_ {
	[self setPrimitiveActionID:[NSNumber numberWithInt:value_]];
}

@dynamic imageAct;

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

@dynamic way;

- (int32_t)wayValue {
	NSNumber *result = [self way];
	return [result intValue];
}

- (void)setWayValue:(int32_t)value_ {
	[self setWay:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveWayValue {
	NSNumber *result = [self primitiveWay];
	return [result intValue];
}

- (void)setPrimitiveWayValue:(int32_t)value_ {
	[self setPrimitiveWay:[NSNumber numberWithInt:value_]];
}

@end

