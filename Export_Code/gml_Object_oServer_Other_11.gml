var list;
list = ds_list_create()
ds_list_set(list, 0, global.metdead)
ds_list_set(list, 1, global.event)
ds_list_set(list, 2, global.item)
ds_list_set(list, 3, global.dmap)
ds_list_set(list, 4, global.monstersleft)
if file_exists((working_directory + global.saveString))
    file_delete((working_directory + global.saveString))
file = file_text_open_write((working_directory + global.saveString))
file_text_write_string(file, ds_list_write(list))
file_text_close(file)
ds_list_destroy(list)
