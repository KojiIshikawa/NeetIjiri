// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_RefStage.m instead.

#import "_T_RefStage.h"

const struct T_RefStageAttributes T_RefStageAttributes = {
	.charaID = @"charaID",
	.stageID = @"stageID",
};

@implementation T_RefStageID
@end

@implementation _T_RefStage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"T_RefStage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"T_RefStage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"T_RefStage" inManagedObjectContext:moc_];
}

- (T_RefStageID*)objectID {
	return (T_RefStageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"charaIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"charaID"];
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

