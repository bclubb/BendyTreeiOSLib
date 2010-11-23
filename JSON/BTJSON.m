//
//  BTSerializer.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 11/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BTJSON.h"
#import "JSON.h"
#import "NSArray+Awesome.h"
#import <objc/runtime.h>





#pragma mark EXTENSIONS

@implementation NSObject (BTJSON)

- (NSString*) serialize
{
    return [[BTSerializer current] serialize:self];
}

@end

@implementation NSString (BTJSON)

- (id) deserialize
{
    return [self deserialize:nil];
}

- (id) deserialize:(Class)type
{
    return [[BTSerializer current] deserialize:self toType:type];
}

@end



#pragma mark -
#pragma mark BTSERIALIZER STARTS HERE

@interface BTSerializer()
- (id) convertCustomObjectToCoreType:(id)obj;
- (id) convertCoreType:(id)obj toCustomObjectOfType:(Class)type;
- (NSArray*) findModelClasses;
- (NSArray*) getClassesForClass:(Class)subclass;
- (bool) class:(Class)classA descendsFrom:(Class)classB;
- (bool) descendsFromNSObject:(Class)classA;
+ (bool) arraysAreSame:(NSArray*)a and:(NSArray*)b;
- (NSArray*) getClassesMatchingDictionary:(NSDictionary*)dic;
+ (NSArray*) getPropertyNamesForSpecificClass:(Class)cls;
+ (NSArray*) getPropertyNamesForClasses:(NSArray*)classes;
+ (Class) getTypeOfProperty:(NSString*)name onObject:(id)obj;
@end


@implementation BTSerializer

@synthesize AllClasses;


#pragma mark Registering Classes

- (void) registerClasses:(NSArray*)classes
{
    NSMutableArray* all = [NSMutableArray array];
    [all addObjectsFromArray:classes];
    for(Class cls in [self findModelClasses]){
        if(![all containsObject:cls]){
            [all addObject:cls];
        }
    }
    self.AllClasses = all;
}


#pragma mark Serializing

- (NSString*) serialize:(id)obj
{
    return [[self convertCustomObjectToCoreType:obj] JSONRepresentation];
}

- (id) convertCustomObjectToCoreType:(id)obj
{
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSDictionary class]]){
        return obj;
    }
    
    if([obj isKindOfClass:[NSDate class]]){
        NSDate* date = (NSDate*)obj;
        return [NSString stringWithFormat:@"/Date(%.f)/", [date timeIntervalSince1970]];
    }
    
    if([obj isKindOfClass:[NSArray class]]){
        NSArray* oldArr = (NSArray*)obj;
        NSMutableArray* arr = [NSMutableArray array];
        for(id el in oldArr){
            [arr addObject:[self convertCustomObjectToCoreType:el]];
        }
        return arr;
    }
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    NSArray* classes = [self getClassesForClass:[obj class]];
    NSArray* propertyNames = [BTSerializer getPropertyNamesForClasses:classes];
    for(NSString* propertyName in propertyNames){
        id origVal = [obj valueForKey:propertyName];
        id val = [self convertCustomObjectToCoreType:origVal];
        [dic setValue:val forKey:propertyName];   
    }
    return dic;    
}


#pragma mark Deserializing

- (id) deserialize:(NSString*)json
{
    return [self deserialize:json toType:nil];
}

- (id) deserialize:(NSString*)json toType:(Class)type
{
    if(self.AllClasses == nil){
        NSLog(@"Please register classes for deserialization using [BTSerializer current].Classes = [NSArray arrayWithObjects:[SomeClass class], etc, nil];");
        return nil;
    }
    
    id coreType = [json JSONValue];
    return [self convertCoreType:coreType toCustomObjectOfType:type];   
}

- (id) convertCoreType:(id)obj toCustomObjectOfType:(Class)type
{
    if([obj isKindOfClass:[NSArray class]]){
        NSArray* arr = (NSArray*)obj;
        NSMutableArray* newArr = [NSMutableArray array];
        for(id el in arr){
            [newArr addObject:[self convertCoreType:el toCustomObjectOfType:nil]];
        }
        return newArr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]]){
        NSDictionary* dic = (NSDictionary*)obj;
        if(type == nil)
        {
            NSArray* types = [self getClassesMatchingDictionary:dic];
            if([types count] == 0){
                [NSException raise:@"Unknown JSON Object" format:@"No matching classes were found for JSON object %@", [dic JSONRepresentation]];
            }else if([types count] > 1){
                [NSException raise:@"Ambiguous JSON Object" format:@"Found too many (%i) classes matching JSON object %@", [types count], [dic JSONRepresentation]];
            }else{
                type = [types objectAtIndex:0];
            }
        }
        
        id newObj = [[[type alloc] init] autorelease];
        for(NSString* key in [dic allKeys]){
            id oldVal = [dic valueForKey:key];
            Class valType = [BTSerializer getTypeOfProperty:key onObject:newObj];
            id newVal = [self convertCoreType:oldVal toCustomObjectOfType:valType];
            [newObj setValue:newVal forKey:key];
        }
        return newObj;
    }
    
    return obj;
}


#pragma mark Reflection

- (NSArray*) findModelClasses
{
    NSMutableArray* allClasses = [NSMutableArray array];
    int classCount = objc_getClassList(NULL, 0);
    Class classes[classCount];
    objc_getClassList( classes, classCount );
    while (classCount--) {
        @try {
            Class cls = classes[classCount];   
            if(![self descendsFromNSObject:cls]) continue;
            NSString* name = [cls description];
            
            if([name hasSuffix:@"Model"])            
                [allClasses addObject:cls];
        }
        @catch (NSException * e) { }
        @finally { }
    }
    return allClasses;
}

- (NSArray*) getClassesForClass:(Class)subclass
{
    NSMutableArray* classes = [NSMutableArray array];
    
    for(Class class in self.AllClasses){
        if(![self class:class descendsFrom:subclass])
            continue;
        
        [classes addObject:class];
    }
    
    return classes;
}

- (bool) class:(Class)classA descendsFrom:(Class)classB
{
    while(1)
    {
        if(classA == classB) return YES;
        id superClass = class_getSuperclass(classA);
        if(classA == superClass) return (superClass == classB);
        classA = superClass;
    }
}

- (bool) descendsFromNSObject:(Class)classA
{
    return [self class:classA descendsFrom:[NSObject class]];
}

+ (bool) arraysAreSame:(NSArray*)a and:(NSArray*)b
{
    if([a count] != [b count]) 
        return NO;
    
    for(NSString* aKey in a){
        if(![b containsObject:aKey])
            return NO;
    }
    return YES;
}

- (NSArray*) getClassesMatchingDictionary:(NSDictionary*)dic
{
    NSMutableArray* classes = [NSMutableArray array];
    
    for(Class class in self.AllClasses){
        NSArray* dicKeys = [dic allKeys];
        NSArray* superClasses = [self getClassesForClass:class];
        NSArray* propertyNames = [BTSerializer getPropertyNamesForClasses:superClasses];
        
        bool isMatch = [BTSerializer arraysAreSame:dicKeys and:propertyNames];
        if(isMatch)
            [classes addObject:class];
    }
    
    return classes;
}

+ (NSArray*) getPropertyNamesForSpecificClass:(Class)cls
{
    NSMutableArray* names = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
            [names addObject:propertyName];
        }
    }
    free(properties);   
    return names;
}

+ (NSArray*) getPropertyNamesForClasses:(NSArray*)classes
{
    NSMutableArray* names = [NSMutableArray array];
    for(Class cls in classes){
        if(cls == [NSObject class]) continue;
        
        [names addObjectsFromArray:[self getPropertyNamesForSpecificClass:cls]];
    }
    return names;
}

+ (Class) getTypeOfProperty:(NSString*)name onObject:(id)obj {
    
    objc_property_t property = class_getProperty([obj class], [name UTF8String]);
    if (property == NULL)
        return nil;
    
    NSString* attributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSASCIIStringEncoding];
    NSString* attribute = [[[attributes componentsSeparatedByString:@","] objectAtIndex:0] substringFromIndex:1];
    
    if([attribute length] > 3)
    {
        NSString* typeName = [attribute substringWithRange:NSMakeRange(2, [attribute length] - 3)];
        Class cls = NSClassFromString(typeName);
        return cls;
    }
    
    return [NSNumber class];
}


#pragma mark Singleton

// Singleton
static BTSerializer* _current = NULL;
+ (BTSerializer*) current
{
    @synchronized(self)
    {
        if(_current == NULL)
            _current = [[self alloc] init];
    }
    return _current;
}


#pragma mark Deallocation

- (void) dealloc
{
    self.AllClasses = nil;
    
    [super dealloc];
}



@end
