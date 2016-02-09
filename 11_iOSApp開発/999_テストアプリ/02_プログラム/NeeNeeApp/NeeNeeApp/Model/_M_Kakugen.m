// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Kakugen.m instead.

#import "_M_Kakugen.h"

const struct M_KakugenAttributes M_KakugenAttributes = {
	.meigenID = @"meigenID",
	.meigenText = @"meigenText",
	.viewNo = @"viewNo",
};

@implementation M_KakugenID
@end

@implementation _M_Kakugen

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"M_Kakugen" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"M_Kakugen";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"M_Kakugen" inManagedObjectContext:moc_];
}

- (M_KakugenID*)objectID {
	return (M_KakugenID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"meigenIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"meigenID"];
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

@dynamic meigenID;

- (int32_t)meigenIDValue {
	NSNumber *result = [self meigenID];
	return [result intValue];
}

- (void)setMeigenIDValue:(int32_t)value_ {
	[self setMeigenID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveMeigenIDValue {
	NSNumber *result = [self primitiveMeigenID];
	return [result intValue];
}

- (void)setPrimitiveMeigenIDValue:(int32_t)value_ {
	[self setPrimitiveMeigenID:[NSNumber numberWithInt:value_]];
}

@dynamic meigenText;

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

