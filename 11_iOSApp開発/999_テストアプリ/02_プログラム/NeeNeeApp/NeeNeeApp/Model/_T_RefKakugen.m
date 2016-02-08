// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to T_RefKakugen.m instead.

#import "_T_RefKakugen.h"

const struct T_RefKakugenAttributes T_RefKakugenAttributes = {
	.charaID = @"charaID",
	.kakugenID = @"kakugenID",
};

@implementation T_RefKakugenID
@end

@implementation _T_RefKakugen

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"T_RefKakugen" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"T_RefKakugen";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"T_RefKakugen" inManagedObjectContext:moc_];
}

- (T_RefKakugenID*)objectID {
	return (T_RefKakugenID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"charaIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"charaID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"kakugenIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"kakugenID"];
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

@end

