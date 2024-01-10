/// instance_position_list(x, y, obj, list, ordered)
// Populates the given DS list with the IDs of instances of the given object which would collide with the current instance at the given position.
// It optionally orders them by distance from the point and returns the number of instances found to be in collision.
var xx, yy, obj, list, ordered, size;
xx      = argument0;
yy      = argument1;
obj     = argument2;
list    = argument3;
ordered = argument4;
size    = ds_list_size(list);

// Check for ordering:
if (ordered)
{
    // Setup priority:
    var priority;
    priority = ds_priority_create();

    // Evaluate:
    with (obj)
    {
        // Continue if there's no collision:
        if (!instance_position(xx, yy, id)) continue;
        
        // Add to priority:
        ds_priority_add(priority, id, point_distance(xx, yy, id.x, id.y));
    }
    
    // Add to list from priority:
    while (!ds_priority_empty(priority))
    {
        ds_list_add(list, ds_priority_delete_min(priority));
    }
    ds_priority_destroy(priority);
}
else
{
    // Evaluate:
    with (obj)
    {
        // Continue if there's no collision:
        if (!instance_position(xx, yy, id)) continue;

        // Add to list:
        ds_list_add(list, id);
    }
}

// Return the number of collisions:
return ds_list_size(list) - size;
