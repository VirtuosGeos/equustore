#include "my_application.h"

#include <flutter_linux/flutter_linux.h>
#ifdef GDK_WINDOWING_X11
#include <gdk/gdkx11.h>
#endif

#include "flutter/generated_plugin_registrant.h"

// 1. Incluimos la librería de Bitsdojo
#include <bitsdojo_window_linux/bitsdojo_window_plugin.h>

struct _MyApplication {
  GtkApplication parent_instance;
  char** dart_entrypoint_arguments;
};

G_DEFINE_TYPE(MyApplication, my_application, GTK_TYPE_APPLICATION)

static void my_application_activate(GApplication* application) {
  MyApplication* self = MY_APPLICATION(application);
  GtkWindow* window =
      GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));

  // --- ZONA DE ELIMINACIÓN DE BARRA ---
  
  // 2. <--- LA CLAVE MAESTRA: Esto fuerza a Linux a NO dibujar la barra gris.
  gtk_window_set_decorated(window, FALSE); 

  // 3. Le decimos a Bitsdojo que nosotros nos encargamos del marco
  auto bdw = bitsdojo_window_from(window);
  bdw->setCustomFrame(true); 

  // Nota: No usamos gtk_window_set_default_size aquí porque Bitsdojo lo maneja en Dart
  // ------------------------------------

  g_autoptr(FlDartProject) project = fl_dart_project_new();
  fl_dart_project_set_dart_entrypoint_arguments(project, self->dart_entrypoint_arguments);

  FlView* view = fl_view_new(project);
  gtk_widget_show(GTK_WIDGET(view));
  gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(view));

  fl_register_plugins(FL_PLUGIN_REGISTRY(view));

  gtk_widget_show(GTK_WIDGET(window));
}

// (El resto del archivo es estándar de Flutter)
static void my_application_startup(GApplication* application) {
  G_APPLICATION_CLASS(my_application_parent_class)->startup(application);
}

static void my_application_shutdown(GApplication* application) {
  G_APPLICATION_CLASS(my_application_parent_class)->shutdown(application);
}

static void my_application_init(MyApplication* self) {
  self->dart_entrypoint_arguments = nullptr;
}

static void my_application_dispose(GObject* object) {
  MyApplication* self = MY_APPLICATION(object);
  g_clear_pointer(&self->dart_entrypoint_arguments, g_strfreev);
  G_OBJECT_CLASS(my_application_parent_class)->dispose(object);
}

static void my_application_class_init(MyApplicationClass* klass) {
  G_APPLICATION_CLASS(klass)->activate = my_application_activate;
  G_APPLICATION_CLASS(klass)->startup = my_application_startup;
  G_APPLICATION_CLASS(klass)->shutdown = my_application_shutdown;
  G_OBJECT_CLASS(klass)->dispose = my_application_dispose;
}

MyApplication* my_application_new() {
  return MY_APPLICATION(g_object_new(my_application_get_type(),
                                     "application-id", "com.example.equustore",
                                     "flags", G_APPLICATION_NON_UNIQUE,
                                     nullptr));
}

void my_application_set_dart_entrypoint_arguments(MyApplication* self, char** arguments) {
  self->dart_entrypoint_arguments = g_strdupv(arguments);
}