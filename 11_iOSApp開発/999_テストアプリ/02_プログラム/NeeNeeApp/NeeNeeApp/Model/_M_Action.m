// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Action.m instead.

#import "_M_Action.h"

const struct M_ActionAttributes M_ActionAttributes = {
	.actID = @"actID",
	.actName = @"actName",
	.imageAct = @"imageAct",
	.way = @"way",
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
	if ([key isEqualToString:@"wayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"way"];
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

@dynamic imageAct;

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

