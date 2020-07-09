import CWaylandClient
import CWaylandEGL

var compositor: UnsafeMutableRawPointer? =  nil

func global_registry_handler(data: UnsafeMutableRawPointer?, registry: OpaquePointer?, id: UInt32, interface: UnsafePointer<Int8>?, version: UInt32) {
    print("Got a registry event")
    let interfaceStr = String(cString: interface!)
    if interfaceStr == "wl_compositor" {
        // compositor = withUnsafePointer(to: wl_compositor_interface) {
        //     wl_registry_bind(registry, id, $0, 1)
        // }
        compositor = wl_registry_bind(registry, id, wl_compositor_interface_ptr, 1)
    }
}

func global_registry_remove(data: UnsafeMutableRawPointer?, registry: OpaquePointer?, id: UInt32) {
    print("Got a registry remove event")
}

var display = wl_display_connect(nil);
if display == nil {
    print("Connect to display failed!")
    exit(1)
}
print("Connect to display succeeded!")

var registry = wl_display_get_registry(display)

var registry_listener = wl_registry_listener(global: global_registry_handler, global_remove: global_registry_remove)

wl_registry_add_listener(registry, &registry_listener, nil)

wl_display_dispatch(display)
wl_display_roundtrip(display)


// var surface: UnsafePointer? = nil
// var window = wl_egl_window_create(surface, 800, 600)


wl_display_disconnect(display)
print("Hello, world!")
