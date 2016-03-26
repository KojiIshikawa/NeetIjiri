// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_ActionImage.m instead.

#import "_M_ActionImage.h"

const struct M_ActionImageAttributes M_ActionImageAttributes = {
	.imageAct = @"imageAct",
	.itemID = @"itemID",
	.serialNo = @"serialNo",
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

	if ([key isEqualToString:@"itemIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"itemID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"serialNoValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"serialNo"];
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

@dynamic imageAct;

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

@dynamic serialNo;

- (int32_t)serialNoValue {
	NSNumber *result = [self serialNo];
	return [result intValue];
}

- (void)setSerialNoValue:(int32_t)value_ {
	[self setSerialNo:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveSerialNoValue {
	NSNumber *result = [self primitiveSerialNo];
	return [result intValue];
}

- (void)setPrimitiveSerialNoValue:(int32_t)value_ {
	[self setPrimitiveSerialNo:[NSNumber numberWithInt:value_]];
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

