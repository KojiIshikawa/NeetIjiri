// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StageM.m instead.

#import "_StageM.h"

const struct StageMAttributes StageMAttributes = {
	.bgm = @"bgm",
	.stageID = @"stageID",
	.stageName = @"stageName",
	.stageText = @"stageText",
	.viewNo = @"viewNo",
	.wallPaper = @"wallPaper",
};

@implementation StageMID
@end

@implementation _StageM

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"StageM" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"StageM";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"StageM" inManagedObjectContext:moc_];
}

- (StageMID*)objectID {
	return (StageMID*)[super objectID];
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

@dynamic wallPaper;

@end

