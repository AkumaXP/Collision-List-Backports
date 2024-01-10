/// collision_circle_list(x1, y2, radius, obj, prec, notme, list, ordered)
// Populates the given DS list with the IDs of instances of the given object colliding within the given point.
// It optionally orders them by distance from the origin of the circle and returns the number of instances found to be in collision.
var x1, y1, radius, obj, prec, notme, list, ordered, size;
x1      = argument0;
y1      = argument1;
radius  = argument2;
obj     = argument3;
prec    = argument4;
notme   = argument5;
list    = argument6;
ordered = argument7;
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
        if (!notme || id != other.id)
        {
            // Continue if there's no collision:
            if (!collision_circle(x1, y1, radius, id, prec, false)) continue;
            
            // Add to priority:
            ds_priority_add(priority, id, point_distance(x1, y1, id.x, id.y));
        }
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
        if (!notme || id != other.id)
        {
            // Continue if there's no collision:
            if (!collision_circle(x1, y1, radius, id, prec, false)) continue;

            // Add to list:
            ds_list_add(list, id);
        }
    }
}

// Return the number of collisions:
return ds_list_size(list) - size;
