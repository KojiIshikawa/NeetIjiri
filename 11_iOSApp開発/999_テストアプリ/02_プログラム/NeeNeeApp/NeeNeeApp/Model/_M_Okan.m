// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to M_Okan.m instead.

#import "_M_Okan.h"

const struct M_OkanAttributes M_OkanAttributes = {
	.loginDays = @"loginDays",
	.okanID = @"okanID",
	.okanText = @"okanText",
};

@implementation M_OkanID
@end

@implementation _M_Okan

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"M_Okan" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"M_Okan";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"M_Okan" inManagedObjectContext:moc_];
}

- (M_OkanID*)objectID {
	return (M_OkanID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"loginDaysValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"loginDays"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"okanIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"okanID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic loginDays;

- (int32_t)loginDaysValue {
	NSNumber *result = [self loginDays];
	return [result intValue];
}

- (void)setLoginDaysValue:(int32_t)value_ {
	[self setLoginDays:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveLoginDaysValue {
	NSNumber *result = [self primitiveLoginDays];
	return [result intValue];
}

- (void)setPrimitiveLoginDaysValue:(int32_t)value_ {
	[self setPrimitiveLoginDays:[NSNumber numberWithInt:value_]];
}

@dynamic okanID;

- (int32_t)okanIDValue {
	NSNumber *result = [self okanID];
	return [result intValue];
}

- (void)setOkanIDValue:(int32_t)value_ {
	[self setOkanID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveOkanIDValue {
	NSNumber *result = [self primitiveOkanID];
	return [result intValue];
}

- (void)setPrimitiveOkanIDValue:(int32_t)value_ {
	[self setPrimitiveOkanID:[NSNumber numberWithInt:value_]];
}

@dynamic okanText;

@end

