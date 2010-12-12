//
//  QuickCollectionIndexPropertyEditorController.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 12/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuickCollectionIndexPropertyEditorController.h"
#import "QuickEditorController.h"
#import "PropertyMetaModel.h"
#import "NSMutableArray+Awesome.h"

@implementation QuickCollectionIndexPropertyEditorController

@synthesize collection, property, primitiveValueContainer, editingIndex, wasEditing;

#pragma mark -
#pragma mark Initialization


- (id)initWithCollection:(NSMutableArray*)_collection property:(PropertyMetaModel*)_property {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:UITableViewStylePlain])) {
        
        self.collection = _collection;
        self.property = _property;
        self.wasEditing = NO;
        
        self.primitiveValueContainer = [NSMutableDictionary dictionary];
        
    }
    return self;
}


- (bool) isSubtypeCustom
{
    return [self.property.SubTypeKey isEqualToString:PropertyMetaModelTypeKey_CustomObject];
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.property.Name;

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"ADD/EDIT" style:UIBarButtonItemStyleDone target:self action:@selector(pressedAddEdit)] autorelease];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(self.wasEditing && ![self isSubtypeCustom]){
        id val = [self.primitiveValueContainer valueForKey:@"Value"];
        if(val)
        {
            if(self.editingIndex == [self.collection count]){
                [self.collection addObject:val];
            }else{
                [self.collection replaceObjectAtIndex:self.editingIndex withObject:val];
            }
        }
    }
    self.wasEditing = NO;    
    
    [self.tableView reloadData];
}


/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
 */


/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.collection count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    id el = [self.collection objectAtIndex:indexPath.row];
    cell.textLabel.text = [self isSubtypeCustom] ? [self.property.TypeMeta describe:el] : [el description];
    
    return cell;
}


- (void) pressedAddEdit
{
    if(self.tableView.editing)
    {
        [self.tableView setEditing:NO animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"ADD/EDIT"];
        return;
    }
    
    UIActionSheet* sheet = [[[UIActionSheet alloc] initWithTitle:@"Add or Edit" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add One", @"Reorder/Delete", nil] autorelease];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
}

- (void) launchEditorForIndex:(int)i
{
    bool isAddition = i == [self.collection count];
    
    self.editingIndex = i;
    self.wasEditing = YES;
    
    if([self isSubtypeCustom]){                
        id el = isAddition ? [self.property.TypeMeta createNewInstance] : [self.collection objectAtIndex:i];
        if(isAddition)
            [self.collection addObject:el];
        QuickEditorController* controller = [[[QuickEditorController alloc] initWithObjectMeta:self.property.TypeMeta object:el] autorelease];
        [self.navigationController pushViewController:controller animated:YES];      
    }else{
        PropertyMetaModel* prop = [[[PropertyMetaModel alloc] init] autorelease];
        prop.Name = self.property.Name;
        prop.TypeKey = self.property.SubTypeKey;
        prop.PropertyKey = @"Value";
        id val = isAddition ? nil : [self.collection objectAtIndex:i];
        [self.primitiveValueContainer setValue:val forKey:prop.PropertyKey];
        UIViewController* editor = [prop newEditorOfObject:self.primitiveValueContainer navController:self.navigationController];
        
        [self.navigationController pushViewController:editor animated:YES];      
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    if(buttonIndex == 0){ //Add
        [self launchEditorForIndex:[self.collection count]];
    }else if(buttonIndex == 1){ //Edit
        [self.tableView setEditing:YES animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"DONE"];
    }else if(buttonIndex == 2){ //Cancel
        
    }        
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.collection removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.collection moveObjectFromIndex:fromIndexPath.row toIndex:toIndexPath.row];
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    [self launchEditorForIndex:indexPath.row];
    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    self.collection = nil;
    self.property = nil;
    self.primitiveValueContainer = nil;
    self.editingIndex = 0;
    
    [super dealloc];
}


@end

