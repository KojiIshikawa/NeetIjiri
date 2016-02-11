// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Stage.m instead.

#import "_M_Stage.h"

const struct M_StageAttributes M_StageAttributes = {
	.bgm = @"bgm",
	.imageBack = @"imageBack",
	.stageID = @"stageID",
	.stageName = @"stageName",
	.stageText = @"stageText",
	.viewNo = @"viewNo",
};

@implementation M_StageID
@end

@implementation _M_Stage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"M_Stage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"M_Stage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"M_Stage" inManagedObjectContext:moc_];
}

- (M_StageID*)objectID {
	return (M_StageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"stageIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"stageID"];
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

@dynamic bgm;

@dynamic imageBack;

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

@dynamic stageName;

@dynamic stageText;

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

